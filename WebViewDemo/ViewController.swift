//
//  ViewController.swift
//  WebViewDemo
//
//  Created by avataar on 08/06/22.
//

import UIKit
import WebKit
import AVFoundation

class ViewController: AvataarWebView {
    private var productId: String! = "158"
    private var variantId: String! = "168"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupWKWebview()
        self.askCameraPermission()
    }
    
    // Camera permission is needed to trigger Avataar's experience This sample code asks for camera permission as soon as 3D experience is triggered irrespective of whether 3D experience or AR experience is opened first. This will be a one time permission for an app user.
    
    private func askCameraPermission() {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch cameraAuthorizationStatus {
            case .notDetermined: requestCameraPermission()
            case .authorized: self.openWebView(productId: self.productId, variantId: self.variantId)
            case .restricted, .denied: print("camera access denied")
            default: print("camera access denied")
        }
    }
    
    private func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: {accessGranted in
            guard accessGranted == true else { return }
            self.openWebView(productId: self.productId, variantId: self.variantId)
        })
    }
}

