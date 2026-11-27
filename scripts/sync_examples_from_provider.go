package main

import (
	"fmt"
	"os"
	"regexp"
	"strconv"
	"strings"
)

const (
	changelogPath    = "./terraform-provider-alicloud/CHANGELOG.md"
	providerDocsPath = "./terraform-provider-alicloud/website/docs/r/"
	quickstartsPath  = "./quickstarts/"

	exampleStart = "```terraform"
	exampleEnd   = "```"

	alicloudProvider = "terraform {\n" +
		"  required_providers {\n" +
		"    alicloud = {\n" +
		"      source = \"aliyun/alicloud\"\n" +
		"    }\n" +
		"  }\n" +
		"}"

	header = "## Introduction\n\nThis example is used to create a `%s` resource.\n\n<!-- BEGIN_TF_DOCS -->\n\n<!-- END_TF_DOCS -->\n"
)

func main() {

	if len(os.Args) < 2 {
		fmt.Println("please input the provider version")
		os.Exit(1)
	}

	version := os.Args[1]
	releaseNotesPath := ""
	if len(os.Args) > 2 {
		releaseNotesPath = os.Args[2]
	}
	newResource, err := getNewResource(version, releaseNotesPath)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	resourceDocList := []string{}
	files, _ := os.ReadDir(providerDocsPath)
	for _, file := range files {
		if file.IsDir() {
			continue
		} else {
			resourceDocList = append(resourceDocList, file.Name())
		}
	}

	for _, resourceDoc := range resourceDocList {
		doc, err := os.ReadFile(providerDocsPath + resourceDoc)
		if err != nil {
			fmt.Printf("fail to open file %s. Error: %s\n", resourceDoc, err)
		}
		docContent := string(doc)
		if strings.Contains(docContent, "**DEPRECATED:**") {
			continue
		}

		subcategoryIndex := strings.Index(docContent, "subcategory: ") + len("subcategory: ")
		subcategoryEndIndex := strings.Index(docContent[subcategoryIndex:], "\n")
		subcategory := docContent[subcategoryIndex : subcategoryIndex+subcategoryEndIndex]
		subcategory = strings.ReplaceAll(subcategory, "\"", "")
		subcategory = strings.ReplaceAll(subcategory, " ", "_")
		subcategory = strings.ReplaceAll(subcategory, "_(", "(")

		exampleList := []string{}
		for {
			index := strings.Index(docContent, exampleStart)
			if index == -1 {
				break
			}

			docContent = docContent[index+len(exampleStart):]
			endIndex := strings.Index(docContent, exampleEnd)
			exampleStr := docContent[:endIndex]
			exampleStr = strings.TrimSpace(exampleStr)
			exampleList = append(exampleList, exampleStr)
			docContent = docContent[endIndex+len(exampleEnd):]
		}

		resourceName := "alicloud_" + strings.TrimSuffix(resourceDoc, ".html.markdown")
		targetFileName := strings.ReplaceAll(strings.ReplaceAll(resourceName, "alicloud", "101"), "_", "-") + "-docs-Example"
		examplePath := quickstartsPath + subcategory + "/"

		for i, exp := range exampleList {

			exampleName := targetFileName
			if len(exampleList) != 1 {
				if i < 9 {
					exampleName += "-0" + strconv.Itoa(i+1)
				} else {
					exampleName += "-" + strconv.Itoa(i+1)
				}
			}
			exampleName = examplePath + exampleName

			_, err := os.Stat(exampleName + "/main.tf")
			// the example exists
			if err == nil {
				expFile, err := os.OpenFile(exampleName+"/main.tf",
					os.O_RDWR|os.O_TRUNC, 0644)
				if err != nil {
					continue
				}
				expFile.WriteString(exp)
				expFile.Close()
			}
			// the example does not exist
			if err != nil && os.IsNotExist(err) {
				if _, ok := newResource[resourceName]; !ok {
					continue
				}

				err := os.MkdirAll(exampleName, 0755)
				if err != nil {
					return
				}

				expFile, err := os.OpenFile(exampleName+"/main.tf",
					os.O_RDWR|os.O_CREATE|os.O_TRUNC, 0644)
				if err != nil {
					continue
				}
				expFile.WriteString(exp)
				expFile.Close()

				providerFile, err := os.OpenFile(exampleName+"/provider.tf",
					os.O_RDWR|os.O_CREATE|os.O_TRUNC, 0644)
				if err != nil {
					continue
				}
				providerFile.WriteString(alicloudProvider)
				providerFile.Close()

				headerFile, err := os.OpenFile(exampleName+"/README.md",
					os.O_RDWR|os.O_CREATE|os.O_TRUNC, 0644)
				if err != nil {
					continue
				}
				headerFile.WriteString(fmt.Sprintf(header, resourceName))
				headerFile.Close()
			}
		}
	}

}

func getNewResource(version, releaseNotesPath string) (map[string]struct{}, error) {
	if releaseNotesPath == "" {
		releaseNotesPath = changelogPath
	}
	content, err := os.ReadFile(releaseNotesPath)
	if err != nil {
		return nil, err
	}
	notes := string(content)
	if releaseNotesPath == changelogPath {
		heading := "## " + strings.TrimPrefix(version, "v") + " "
		_, section, found := strings.Cut("\n"+notes, "\n"+heading)
		if !found {
			return nil, fmt.Errorf("cannot find the changelog of version %s", version)
		}
		notes, _, _ = strings.Cut(section, "\n## ")
	}

	newResource := map[string]struct{}{}
	resourceEntry := regexp.MustCompile("(?m)^[ \\t]*[-*+][ \\t]+(?:\\*\\*)?New Resource:(?:\\*\\*)?[ \\t]+`(alicloud_[a-z0-9_]+)`")
	for _, match := range resourceEntry.FindAllStringSubmatch(notes, -1) {
		newResource[match[1]] = struct{}{}
	}
	return newResource, nil
}
