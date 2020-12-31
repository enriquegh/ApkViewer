//
//  AppDelegate.swift
//  ApkViewer
//
//  Created by Enrique Gonzalez on 12/30/20.
//

import Cocoa
import SwiftUI
import ApkParser

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let apk = ApkModel(appName: "my.app",packageName: "com.myapp", targetSdkVersion: "29",minSdkVersion: "16",appVersion: "1.0", nativeCode: ["arm64-v8a", "armeabi-v7a", "x86", "x86_64"], permissions: ["android.permission.VIBRATE"])
        let contentView = ContentView(apk: apk)


        // Create the window and set the content view.
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.isReleasedWhenClosed = false
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

