import os
import json
 
def get_files():
    recordList = []
    for filepath,dirnames,filenames in os.walk(r'./quickstarts'):
        for filename in filenames:
            if filename != 'TestRecord.md':
                continue

            testRecordPath = filepath.split('/')
            subcategory = testRecordPath[2]
            exampleName = testRecordPath[3]
            updateTime = ""
            success = ""
            version = ""
            # print(testRecordPath)

            f = open(os.path.join(filepath,filename))              
            line = f.readline()               
            while line: 
                if line.startswith("## "):
                    updateTime = line.strip("## ").strip("\n")
                if line.startswith("success"):
                    success = line.strip("success: ").strip("\n")
                if line.__contains__("+ provider") and line.__contains__("alicloud"):
                    version = line.strip("+ provider ").split(" ")[-1].strip("\n")
                    break
                line = f.readline() 
        
            f.close()
            error = ""
            logPath = os.path.join(filepath,'terraform.log')
            if success == "false" and os.path.exists(logPath):
                f = open(logPath)
                error = f.read()
                f.close()
                
            d = dict(subcategory=subcategory,exampleName=exampleName,updateTime=updateTime,version=version,success=success,error=error)  
            recordList.append(d)
    
    finalRecord = dict(data=recordList)
    with open("./TestRecord.json","w") as file:
        json.dump(finalRecord,file)


if __name__ == '__main__':
    get_files()