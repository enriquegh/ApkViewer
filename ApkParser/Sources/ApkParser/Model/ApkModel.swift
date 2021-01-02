//
//  ApkModel.swift
//  ApkViewer
//
//  Created by Enrique Gonzalez on 12/30/20.
//

import Foundation

public struct ApkModel {
    public var appName:String
    public var packageName:String
    public var targetSdkVersion:String
    public var minSdkVersion:String
    public var appVersion:String
    public var nativeCode: String
    public var permissions: [String]
    
    public init(appName:String, packageName:String, targetSdkVersion:String, minSdkVersion:String,
                appVersion:String, nativeCode: String, permissions:[String]) {
        self.appName = appName
        self.packageName = packageName
        self.targetSdkVersion = targetSdkVersion
        self.minSdkVersion = minSdkVersion
        self.appVersion = appVersion
        self.nativeCode = nativeCode
        self.permissions = permissions
    }
    public init() {
        self.appName = "foo"
        self.packageName = "bar"
        self.targetSdkVersion = "1"
        self.minSdkVersion = "2"
        self.appVersion = "1.0"
        self.nativeCode = "foobar"
        self.permissions = ["hello"]
    }
}

