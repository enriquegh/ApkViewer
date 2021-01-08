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
            Spacer()
            HStack {
                Image(nsImage: apk.iconImage ?? NSImage())
                    .padding(.trailing)
                VStack {
                    AppPropertyView(propertyName: "Application Name:", propertyValue: apk.appName)
                    AppPropertyView(propertyName: "Version:", propertyValue: apk.appVersion)
                    AppPropertyView(propertyName: "Package Name:", propertyValue: apk.packageName)
                    AppPropertyView(propertyName: "Target SDK version:", propertyValue: apk.targetSdkVersion)
                    AppPropertyView(propertyName: "Min SDK version:", propertyValue: apk.minSdkVersion)
                    AppPropertyView(propertyName: "Permissions:", propertyValue: apk.permissions?.joined(separator: "\n") ?? "")
                    AppPropertyView(propertyName: "Native Code libraries:", propertyValue: apk.nativeCode ?? "No native codes found")
                }
            }

        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func openFile() {
        let panel = NSOpenPanel()
        panel.canChooseDirectories = false
        panel.canChooseFiles = true
        panel.allowsMultipleSelection = false
        panel.begin { response in
            if response == NSApplication.ModalResponse.OK, let fileUrl = panel.url {
                self.fileContent = "Selected \(fileUrl.path)"
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

