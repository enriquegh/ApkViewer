//
//  ContentView.swift
//  ApkViewer
//
//  Created by Enrique Gonzalez on 12/30/20.
//

import SwiftUI
import ApkParser

struct ContentView: View {
    @State private var apk:ApkModel = ApkModel()
    @State private var fileContent = "";
    @State private var fileUrl:URL = URL(fileURLWithPath: "/my/path");
    @State private var isFileSelected = false;
    @State private var wasFileParsed = false;

    
    var body: some View {

        VStack {
        
            VStack {
                Text(fileContent).padding()
                Button(action: {
                    openFile()
                    isFileSelected = true
                    wasFileParsed = false

                }, label: {
                    Text("Select File")
                })
                Button(action:{
                    parseFile()
                    isFileSelected = false
                    wasFileParsed = true
                    
                } ,label:{
                    Text("Parse file")
                    
                }).disabled(!isFileSelected || wasFileParsed)
            
            }
            HStack {
                Text("Application Name:")
                Text(apk.appName)
            }
            
            HStack {
                Text("Version:")
                Text(apk.appVersion)
            }
            
            HStack {
                Text("Package Name:")
                Text(apk.packageName)
            }
            
            HStack {
                Text("Target SDK version:")
                Text(apk.targetSdkVersion)
            }
            
            HStack {
                Text("Min SDK version:")
                Text(apk.minSdkVersion)
            }

            HStack {
                Text("Permissions:")
                Text(apk.permissions?.joined(separator: ", ") ?? "")
            }
            HStack {
                Text("Native Code libraries:")
                Text(apk.nativeCode ?? "No native codes found")
            }
            Image(nsImage: apk.iconImage ?? NSImage())

        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func openFile() {
        let panel = NSOpenPanel()
        panel.nameFieldLabel = "Save cat image as:"
        panel.nameFieldStringValue = "cat.jpg"
        panel.canChooseDirectories = false
        panel.canChooseFiles = true
        panel.allowsMultipleSelection = false
        panel.begin { response in
            if response == NSApplication.ModalResponse.OK, let fileUrl = panel.url {
                self.fileContent = "Opening \(fileUrl.path)"
                self.fileUrl = fileUrl
            } else {
                self.fileContent = "Cancel clicked in Save dialog"
            }
        }
    }
    
    func parseFile() {
        let parser = ApkParser(apkPath: self.fileUrl.path)
        parser.load()
        parser.parse()
        self.apk = parser.createApkModel()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

