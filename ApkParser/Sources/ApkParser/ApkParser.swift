//
//  ApkParser.swift
//  ApkViewer
//
//  Created by Enrique Gonzalez on 12/30/20.
//

import Foundation

@available(OSX 10.13, *)
public class ApkParser {
    var appName:String!
    var packageName:String!
    var targetSdkVersion:String!
    var minSdkVersion:String!
    var appVersion:String!
    var nativeCode: String?
    var permissions: [String]?
    
    var rawOutput:NSString = ""
    var aaptPath:String = Bundle.module.path(forResource: "aapt", ofType: nil)!
    var apkPath:String
    
    public init(apkPath:String) {
        self.apkPath = apkPath
    }
    
    public func load() {
        let task:Process = Process()
        let pipe:Pipe = Pipe()

        task.launchPath = self.aaptPath
        task.arguments = ["dump", "badging", self.apkPath]
        task.standardOutput = pipe
        task.launch()

        let handle = pipe.fileHandleForReading
        let data = handle.readDataToEndOfFile()
        let output = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
//        print(output)
        self.rawOutput = output ?? ""
        
        
    }
    
    public func parse() {
        let permissionsPattern = #"uses-permission[s,d,k,\d,-]*: name='([^']*)'.*"#
        let pattern = #"package: name='(?<packageName>[^']*)'.*versionName='(?<appVersion>[^']*)'.*?(?:compileSdkVersion='(?<compileSdkVersion>[\d{2}]*)'.*)?sdkVersion:'(?<minSdkVersion>[^']*)'.*targetSdkVersion:'(?<targetSdkVersion>[^']*)'.*application-label:'(?<appName>[^']*)'.*native-code: (?<nativeCode>.*)"#
        let stringOutput = self.rawOutput as String
        
        do {
            let mainRegex = try NSRegularExpression(pattern: pattern, options: [NSRegularExpression.Options.dotMatchesLineSeparators])
            let permissionRegex = try NSRegularExpression(pattern: permissionsPattern, options: [])

            // Get all permissions
            let matches = permissionRegex.matches(in: stringOutput, range: NSMakeRange(0, self.rawOutput.length))
            if !matches.isEmpty {
                self.permissions = [String]()
                for match in matches {
                    let nsRange = match.range(at: 1)
                    if nsRange.location != NSNotFound,
                       let range = Range(nsRange, in:stringOutput) {
                        self.permissions?.append(String(stringOutput[range]))

                    }
                }
            }

            if let match = mainRegex.firstMatch(in: stringOutput, options: [], range: NSMakeRange(0, self.rawOutput.length)) {
                self.appName = getNamedCapture(regexMatch: match, stringOutput: stringOutput, captureName: "appName")
                self.packageName = getNamedCapture(regexMatch: match, stringOutput: stringOutput, captureName: "packageName")
                self.targetSdkVersion = getNamedCapture(regexMatch: match, stringOutput: stringOutput, captureName: "targetSdkVersion")
                self.minSdkVersion = getNamedCapture(regexMatch: match, stringOutput: stringOutput, captureName: "minSdkVersion")
                self.appVersion = getNamedCapture(regexMatch: match, stringOutput: stringOutput, captureName: "appVersion")
                self.nativeCode = getNamedCapture(regexMatch: match, stringOutput: stringOutput, captureName: "nativeCode")
                
            }
            
            

        } catch {
            print(error)
        }

    }
    
    func getNamedCapture(regexMatch:NSTextCheckingResult, stringOutput:String, captureName:String) -> String {
        let nsRange = regexMatch.range(withName: captureName)
        if nsRange.location != NSNotFound,
           let range = Range(nsRange, in:stringOutput) {
            return String(stringOutput[range])

        }
        else {
            return ""
        }
    }
    
    public func createApkModel() -> ApkModel {
        return ApkModel(appName: self.appName, packageName: self.packageName, targetSdkVersion: self.targetSdkVersion, minSdkVersion: self.minSdkVersion, appVersion: self.appVersion, nativeCode: self.nativeCode ?? "", permissions: self.permissions ?? [""])
    }
}

