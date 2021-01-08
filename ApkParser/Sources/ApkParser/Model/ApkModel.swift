//
//  ApkModel.swift
//  ApkViewer
//
//  Created by Enrique Gonzalez on 12/30/20.
//

import Foundation
import Cocoa

public struct ApkModel {
    public var appName:String
    public var packageName:String
    public var targetSdkVersion:String
    public var minSdkVersion:String
    public var appVersion:String
    public var nativeCode: String?
    public var permissions: [String]?
    public var iconImage: NSImage?
    
    public init(appName:String, packageName:String, targetSdkVersion:String, minSdkVersion:String,
                appVersion:String, nativeCode: String?, permissions:[String]?, iconImage:NSImage?) {
        self.appName = appName
        self.packageName = packageName
        self.targetSdkVersion = targetSdkVersion
        self.minSdkVersion = minSdkVersion
        self.appVersion = appVersion
        self.nativeCode = nativeCode
        self.permissions = permissions
        self.iconImage = iconImage
    }
    public init() {
        self.appName = "My Super App"
        self.packageName = "com.package.myapp"
        self.targetSdkVersion = "29"
        self.minSdkVersion = "20"
        self.appVersion = "1.6.1-debug"
        self.nativeCode = "'armeabi' 'armeabi-v7' 'x86'"
        self.permissions = ["android.permission.WRITE_EXTERNAL_STORAGE", "android.permission.WRITE_EXTERNAL_STORAGE", "android.permission.WRITE_EXTERNAL_STORAGE", "android.permission.WRITE_EXTERNAL_STORAGE", "android.permission.WRITE_EXTERNAL_STORAGE"]
        self.iconImage = NSImage()
    }
}

