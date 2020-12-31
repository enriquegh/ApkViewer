//
//  ApkModel.swift
//  ApkViewer
//
//  Created by Enrique Gonzalez on 12/30/20.
//

import Foundation

struct ApkModel {
    var appName:String
    var packageName:String
    var targetSdkVersion:String
    var minSdkVersion:String
    var appVersion:String
    var nativeCode: [String]
    var permissions: [String]
}

