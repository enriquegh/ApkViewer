//
//  PreviewViewController.swift
//  ApkQuickLook
//
//  Created by Enrique Gonzalez on 1/1/21.
//

import Cocoa
import Quartz
import ApkParser

class PreviewViewController: NSViewController, QLPreviewingController {
    
    
    @IBOutlet var appName: NSTextField!
    @IBOutlet var packageName: NSTextField!
    @IBOutlet var appVersion: NSTextField!
    @IBOutlet var targetSDK: NSTextField!
    @IBOutlet var minSDK: NSTextField!
    @IBOutlet var nativeCode: NSTextField!
    @IBOutlet var permissions: NSTextField!
    @IBOutlet var appIcon: NSImageView!


    
    override var nibName: NSNib.Name? {
        return NSNib.Name("PreviewViewController")
    }

    override func loadView() {
        super.loadView()
        // Do any additional setup after loading the view.
    }

    /*
     * Implement this method and set QLSupportsSearchableItems to YES in the Info.plist of the extension if you support CoreSpotlight.
     *
    func preparePreviewOfSearchableItem(identifier: String, queryString: String?, completionHandler handler: @escaping (Error?) -> Void) {
        // Perform any setup necessary in order to prepare the view.
        
        // Call the completion handler so Quick Look knows that the preview is fully loaded.
        // Quick Look will display a loading spinner while the completion handler is not called.
        handler(nil)
    }
     */
    
    func preparePreviewOfFile(at url: URL, completionHandler handler: @escaping (Error?) -> Void) {
        
        // Add the supported content types to the QLSupportedContentTypes array in the Info.plist of the extension.
        
        // Perform any setup necessary in order to prepare the view.
        
        // Call the completion handler so Quick Look knows that the preview is fully loaded.
        // Quick Look will display a loading spinner while the completion handler is not called.
        let parser = ApkParser(apkPath: url.path)
        parser.load()
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else {
              return
            }
            parser.parse()
            let apk:ApkModel = parser.createApkModel()
            DispatchQueue.main.async { [weak self] in
                
                self?.appName.stringValue = apk.appName
                self?.packageName.stringValue = apk.packageName
                self?.appVersion.stringValue = apk.appVersion
                self?.targetSDK.stringValue = apk.targetSdkVersion
                self?.minSDK.stringValue = apk.minSdkVersion
                self?.nativeCode.stringValue = apk.nativeCode ?? "No native codes found"
                self?.permissions.stringValue = apk.permissions?.joined(separator: ",") ?? ""
                self?.appIcon.image = apk.iconImage
            }

        }
        
        handler(nil)
    }
}
