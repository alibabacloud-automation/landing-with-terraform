package main

import (
	"encoding/json"
	"io"
	"log"
	"net/http"
	"os"
	"strings"
	"time"
)

var urlPrefix = "https://terraform-fc-test-for-example-module.oss-ap-southeast-1.aliyuncs.com"

func main() {
	if len(os.Args) != 2 {
		log.Println("input invalid")
		return
	}
	ossObjectPath := strings.TrimSpace(os.Args[1])
	log.Println("run log path:", ossObjectPath)
	TestRecordFileName := "TestRecordPublic.json"
	TestRecordUrl := urlPrefix + "/" + ossObjectPath + "/" + TestRecordFileName
	response, err := http.Get(TestRecordUrl)
	if err != nil || response.StatusCode != 200 {
		log.Println("fail to get test record file")
		return
	}
	defer response.Body.Close()

	content, _ := io.ReadAll(response.Body)
	var data interface{}
	json.Unmarshal(content, &data)

	testRecordMap := data.(map[string]interface{})

	for exampleName, testRecord := range testRecordMap {
		latestRecord := exampleName
		targetTestRecordFile := strings.Replace(strings.TrimRight(latestRecord, ".tmp"), "TestRecord", "quickstarts", 1)
		// fmt.Println(targetTestRecordFile)

		preUpdateTime := ""
		oldTestRecord := ""
		var testRecordFile *os.File
		if _, err := os.Stat(targetTestRecordFile); os.IsNotExist(err) {
			testRecordFile, err = os.Create(targetTestRecordFile)
			if err != nil {
				log.Println("[ERROR] failed to create test record file")
			}
			preUpdateTime = "not exist"
		} else {
			data, err := os.ReadFile(targetTestRecordFile)
			if err != nil {
				log.Println("[ERROR] failed to read test record file")
				return
			}
			oldTestRecord = string(data)
			oldParts := strings.Split(oldTestRecord, "\n")
			for _, v := range oldParts {
				if strings.Contains(v, "##") && preUpdateTime == "" {
					preUpdateTime = v
					break
				}
			}

			testRecordFile, err = os.OpenFile(targetTestRecordFile, os.O_TRUNC|os.O_RDWR, 0666)
			if err != nil {
				log.Println("[ERROR] failed to open test record file")
			}

		}

		currentUpdateTime := ""
		currentParts := strings.Split(testRecord.(string), "\n")
		for _, v := range currentParts {
			if strings.Contains(v, "##") && currentUpdateTime == "" {
				currentUpdateTime = v
				break
			}
		}
		defer testRecordFile.Close()

		if preUpdateTime == currentUpdateTime {
			testRecordFile.WriteString(oldTestRecord)
			continue
		} else {
			preTimeStr := strings.TrimLeft(preUpdateTime, "## ")
			curTimeStr := strings.TrimLeft(currentUpdateTime, "## ")
			preTime, err := time.Parse("02 Jan 2006 15:04 UTC", preTimeStr)
			if err != nil {
				continue
			}
			curTime, err := time.Parse("02 Jan 2006 15:04 UTC", curTimeStr)
			if err != nil {
				continue
			}

			if !curTime.After(preTime) {
				testRecordFile.WriteString(oldTestRecord)
				continue
			}
			currentTestRecord := testRecord.(string) + oldTestRecord
			testRecordFile.WriteString(currentTestRecord)
		}

	}

}
