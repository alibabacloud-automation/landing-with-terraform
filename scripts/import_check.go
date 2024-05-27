package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"log"
	"os"
	"os/exec"
	"strings"
)

func main() {
	stateFilePath := strings.TrimSpace(os.Args[1])
	importFilePath = stateFilePath + importFilePath

	getImportFile(stateFilePath)

	excuteImportTest(stateFilePath, importFilePath)
}

func getImportFile(stateFilePath string) {

	// Skip the test for the examples with provider
	mainContent, err := os.ReadFile(stateFilePath + "/main.tf")
	if strings.Contains(string(mainContent), "provider \"alicloud\"") {
		log.Println("Skip the test for the examples with provider")
		return
	}

	stateContent, err := os.ReadFile(stateFilePath + "/terraform.tfstate")
	if err != nil {
		log.Println("reading the state file failed, error: ", err)
		os.Exit(1)
	}

	resourceState := new(TerraformState)
	err = json.Unmarshal(stateContent, resourceState)
	if err != nil {
		log.Println("unmarshalling the state content failed, error: ", err)
		os.Exit(1)
	}

	for _, res := range resourceState.Resources {
		if res.Mode != "managed" || !strings.HasPrefix(res.Type, "alicloud_") {
			continue
		}
		if _, ok := importUnsupportedResources[res.Type]; ok {
			log.Printf("[WARNING] %s does not support import.", res.Type)
			continue
		}
		for _, instance := range res.Instances {
			item := instance.(map[string]interface{})
			id := item["attributes"].(map[string]interface{})["id"]
			if _, ok := importResource[res.Type]; !ok {
				importResource[res.Type] = map[string]string{}
			}
			to := res.Type + "." + res.Name
			to += "-import"
			if v, ok := item["index_key"]; ok {
				if vv, okk := v.(string); okk {
					bufs := make([]byte, 0)
					for _, ch := range vv {
						if (ch > 47 && ch < 58) || (ch > 64 && ch < 91) || (ch > 96 && ch < 123) || ch == 45 || ch == 95 {
							bufs = append(bufs, byte(ch))
							continue
						}
						bufs = append(bufs, '-')
					}
					to += "-" + string(bufs)
				} else {
					to += fmt.Sprintf("-%v", v)
				}
			}
			importResource[res.Type][to] = fmt.Sprintf(`
import {
	id = "%s"
	to = %s
}

`, id, to)
		}
	}

	if _, err := os.Stat(importFilePath); os.IsNotExist(err) {
		os.MkdirAll(importFilePath, 0755)
	}
	for _, value := range importResource {
		for k, v := range value {
			os.Mkdir(importFilePath+k, 0755)
			os.Create(importFilePath + k + "/import.tf")
			os.WriteFile(importFilePath+k+"/import.tf", []byte(v), 0644)
		}
	}

}

func excuteImportTest(stateFilePath, importFilePath string) {

	resultAll := []importResult{}

	for t, value := range importResource {
		for k := range value {
			testFilePath := importFilePath + k

			cmd := exec.Command("bash", "scripts/import-test.sh", stateFilePath, testFilePath)
			var stdout, stderr bytes.Buffer
			cmd.Stdout = &stdout
			cmd.Stderr = &stderr
			success := true
			errorStage := 0
			if err := cmd.Run(); err != nil {
				success = false
				var exitCode int
				if exitError, ok := err.(*exec.ExitError); ok {
					exitCode = exitError.ExitCode()
					errorStage = exitCode
				}
			}

			errMessage := ""

			errMessageSlice := strings.Split(stderr.String(), "\n")
			for _, v := range errMessageSlice {
				if strings.Contains(v, "Error: ") {
					errMessage += v + "\n"
				}
			}

			var result = importResult{
				ExamplePath:  stateFilePath,
				ResourceType: t,
				ResourceName: k,
				Success:      success,
				Error:        errMessage,
				ErrorStage:   errorStage,
			}
			resultAll = append(resultAll, result)
		}
	}

	resultPath := importResultPath + strings.TrimPrefix(stateFilePath, "quickstarts/")
	if _, err := os.Stat(resultPath); os.IsNotExist(err) {
		os.MkdirAll(resultPath, 0755)
	}

	jsonData, _ := json.Marshal(resultAll)
	os.WriteFile(resultPath+"/importResult.json", jsonData, 0644)

}

var (
	importFilePath   = "/import_test/"
	importResultPath = "TestRecordImport/"

	importResource = map[string]map[string]string{}
)

type importResult struct {
	ExamplePath  string `json:"example_path"`
	ResourceType string `json:"resource_type"`
	ResourceName string `json:"resource_name"`
	Success      bool   `json:"success"`
	Error        string `json:"error"`
	ErrorStage   int    `json:"error_stage"`
}

type TerraformState struct {
	Version          int         `json:"version"`
	TerraformVersion string      `json:"terraform_version"`
	Serial           int         `json:"serial"`
	Lineage          string      `json:"lineage"`
	Outputs          interface{} `json:"outputs"`
	Resources        []Resource  `json: "resources"`
	CheckResults     interface{} `json:"check_results"`
}

type Resource struct {
	Mode      string        `json:"mode"`
	Type      string        `json: "type"`
	Name      string        `json:"name"`
	Provider  string        `json:"provider"`
	Instances []interface{} `json:"instances"`
}

var importUnsupportedResources = map[string]struct{}{}
