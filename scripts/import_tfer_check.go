package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"log"
	"os"
	"os/exec"
	"regexp"
	"strings"
)

func main() {
	stateFilePath = strings.TrimSpace(os.Args[1])
	importFilePath = stateFilePath + importFilePath
	tferFilePath = stateFilePath + tferFilePath

	getProviderInfo()

	getResourceInfo()

	excuteImportTest()

	excuteTferTest()
}

func getProviderInfo() {
	mainContent, err := os.ReadFile(stateFilePath + "/main.tf")
	if err != nil {
		log.Println("reading the main file failed, error: ", err)
		os.Exit(1)
	}
	originProviderList := []ProviderInfo{}
	variableMap := make(map[string]string)

	// get provider block info
	providerRe, err := regexp.Compile(providerRegexPattern)
	allProviderBlocks := providerRe.FindAllString(string(mainContent), -1)
	for _, provider := range allProviderBlocks {
		providerInfo := ProviderInfo{}
		parts := strings.Split(provider, "\n")
		for _, v := range parts[1:] {
			if strings.Contains(v, "alias") || strings.Contains(v, "region") {
				vv := v[strings.Index(v, "=")+1:]
				vv = strings.TrimSpace(vv)
				vv = strings.ReplaceAll(vv, "\"", "")
				if strings.Contains(v, "alias") {
					providerInfo.Alias = vv
				} else if strings.Contains(v, "region") {
					providerInfo.Region = vv
				}
			}
		}
		originProviderList = append(originProviderList, providerInfo)
	}

	// get variable block info
	variableRe, err := regexp.Compile(variableRegexPattern)
	allVariableBlocks := variableRe.FindAllString(string(mainContent), -1)
	for _, variable := range allVariableBlocks {
		parts := strings.Split(variable, "\n")
		key := strings.TrimPrefix(parts[0], "variable \"")
		key = strings.TrimSuffix(key, "\" {")
		for _, v := range parts[1:] {
			if strings.Contains(v, "default") {
				vv := v[strings.Index(v, "=")+1:]
				vv = strings.TrimSpace(vv)
				vv = strings.ReplaceAll(vv, "\"", "")
				variableMap[key] = vv
			}
		}
	}

	// handle variables in provider block
	for _, originProvider := range originProviderList {
		if strings.Contains(originProvider.Region, "var.") {
			originProvider.Region = variableMap[strings.TrimPrefix(originProvider.Region, "var.")]
		}
		// noAlias
		if originProvider.Alias == "" {
			providerInfo["default"] = originProvider.Region
		} else {
			providerInfo[originProvider.Alias] = originProvider.Region
		}
	}
}

func getResourceInfo() {
	var providerVersion string
	cmd := exec.Command("terraform", "-chdir="+stateFilePath, "version")
	stdout, _ := cmd.CombinedOutput()
	versionStr := strings.Split(string(stdout), "\n")
	for _, v := range versionStr {
		if strings.Contains(v, "alicloud") {
			parts := strings.Split(v, " ")
			providerVersion = strings.TrimPrefix(parts[len(parts)-1], "v")
		}
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

	resourceInfo = make([]ResourceInfo, 0)
	for _, res := range resourceState.Resources {
		if res.Mode != "managed" || !strings.HasPrefix(res.Type, "alicloud_") {
			continue
		}

		for _, instance := range res.Instances {
			item := instance.(map[string]interface{})
			id := item["attributes"].(map[string]interface{})["id"]
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
			resource := ResourceInfo{
				ResourceType:    res.Type,
				ResourceName:    to,
				Id:              id.(string),
				ProviderVersion: providerVersion,
			}

			providerName := res.Provider[strings.Index(res.Provider, "]")+1:]
			providerName = strings.TrimPrefix(providerName, ".")
			if region, ok := providerInfo["default"]; ok && len(providerName) == 0 {
				resource.Region = region
			}
			if region, ok := providerInfo[providerName]; ok {
				resource.Region = region
			}
			resourceInfo = append(resourceInfo, resource)
		}
	}

}

func excuteImportTest() {

	// generate import test files
	if _, err := os.Stat(importFilePath); os.IsNotExist(err) {
		os.MkdirAll(importFilePath, 0755)
	}

	for _, resource := range resourceInfo {
		importName := resource.ResourceName
		importStr := fmt.Sprintf(`
import {
	id = "%s"
	to = %s
}
		`, resource.Id, importName)
		if len(resource.Region) != 0 {
			importStr = fmt.Sprintf(`
provider "alicloud" {
  alias  = "my-provider"
  region = "%s"
}

import {
  provider = alicloud.my-provider
  id       = "%s"
  to       = %s
}
					`, resource.Region, resource.Id, importName)
		}

		os.Mkdir(importFilePath+importName, 0755)
		os.Create(importFilePath + importName + "/import.tf")
		os.WriteFile(importFilePath+importName+"/import.tf", []byte(importStr), 0644)
	}

	// excute test
	resultAll := []TestResult{}
	for _, resource := range resourceInfo {
		testFilePath := importFilePath + resource.ResourceName

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

		fmt.Println(stdout.String())

		var result = TestResult{
			ExamplePath:     stateFilePath,
			ResourceType:    resource.ResourceType,
			ResourceName:    resource.ResourceName,
			Success:         success,
			Error:           errMessage,
			ErrorStage:      errorStage,
			ProviderVersion: resource.ProviderVersion,
		}
		resultAll = append(resultAll, result)
	}

	resultPath := importResultPath + strings.TrimPrefix(stateFilePath, "quickstarts/")
	if _, err := os.Stat(resultPath); os.IsNotExist(err) {
		os.MkdirAll(resultPath, 0755)
	}

	jsonData, _ := json.Marshal(resultAll)
	os.WriteFile(resultPath+"/"+importResultFileName, jsonData, 0644)

}

func excuteTferTest() {
	if _, err := os.Stat(tferFilePath); os.IsNotExist(err) {
		os.MkdirAll(tferFilePath, 0755)
	}

	resultAll := []TestResult{}
	for _, resource := range resourceInfo {

		resourceType := strings.TrimPrefix(resource.ResourceType, "alicloud_")

		testFilePath := tferFilePath + resource.ResourceName
		cmd := exec.Command("bash", "scripts/tfer-test.sh", stateFilePath, resourceType, resource.Id, testFilePath, resource.Region)
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
			if strings.Contains(v, "Error: ") || strings.Contains(v, "is required, but no definition") {
				errMessage += v + "\n"
			}
		}

		fmt.Println(stdout.String())

		var result = TestResult{
			ExamplePath:     stateFilePath,
			ResourceType:    resource.ResourceType,
			ResourceName:    resource.ResourceName,
			Success:         success,
			Error:           errMessage,
			ErrorStage:      errorStage,
			ProviderVersion: resource.ProviderVersion,
		}
		resultAll = append(resultAll, result)

	}

	resultPath := tferResultPath + strings.TrimPrefix(stateFilePath, "quickstarts/")
	if _, err := os.Stat(resultPath); os.IsNotExist(err) {
		os.MkdirAll(resultPath, 0755)
	}

	jsonData, _ := json.Marshal(resultAll)
	os.WriteFile(resultPath+"/"+tferResultFileName, jsonData, 0644)

}

var (
	providerRegexPattern = `provider "alicloud" {\s*[^}]*}`
	variableRegexPattern = `variable ".*?" {\s*.*?\s*}`

	stateFilePath = ""

	importFilePath       = "/import_test/"
	importResultPath     = "TestRecordImport/"
	importResultFileName = "importResult.json"

	tferFilePath       = "/tfer_test/"
	tferResultPath     = "TestRecordTfer/"
	tferResultFileName = "tferResult.json"

	resourceInfo = []ResourceInfo{}
	providerInfo = map[string]string{}
)

type ProviderInfo struct {
	Region string
	Alias  string
}

type TestResult struct {
	ExamplePath     string `json:"example_path"`
	ResourceType    string `json:"resource_type"`
	ResourceName    string `json:"resource_name"`
	Success         bool   `json:"success"`
	Error           string `json:"error"`
	ErrorStage      int    `json:"error_stage"`
	ProviderVersion string `json:"provider_version"`
}

type ResourceInfo struct {
	ResourceType    string
	ResourceName    string
	Id              string
	ProviderVersion string
	Region          string
}

type TerraformState struct {
	Version          int         `json:"version"`
	TerraformVersion string      `json:"terraform_version"`
	Serial           int         `json:"serial"`
	Lineage          string      `json:"lineage"`
	Outputs          interface{} `json:"outputs"`
	Resources        []Resource  `json:"resources"`
	CheckResults     interface{} `json:"check_results"`
}

type Resource struct {
	Mode      string        `json:"mode"`
	Type      string        `json:"type"`
	Name      string        `json:"name"`
	Provider  string        `json:"provider"`
	Instances []interface{} `json:"instances"`
}
