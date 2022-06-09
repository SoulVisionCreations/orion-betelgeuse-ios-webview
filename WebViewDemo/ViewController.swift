//
//  ViewController.swift
//  WebViewDemo
//
//  Created by avataar on 08/06/22.
//

import UIKit
import WebKit
import AVFoundation

class ViewController: UIViewController, WKScriptMessageHandler {
    
    private var wkWebView: WKWebView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        self.setupWKWebview()
        self.checkCameraPermission()
    }

    private func setupWKWebview() {
        self.wkWebView = WKWebView(frame: self.view.bounds, configuration: self.getWKWebViewConfiguration())
        self.view.addSubview(self.wkWebView)
    }

    private func loadPage() {
        // test web view using html for testing and triger native callback from javascript
//        if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
//                    self.wkWebView.load(URLRequest(url: url))
//                }
        if let url = URL(string: "https://orion-dev.avataar.me/engine/AVTR-TNT-t8mv4evu/AVTR_EXP_d41d8cd9/index.html?ar=0&mode=renderer&tenantId=AVTR-TNT-t8mv4evu&productId=168") {
            self.wkWebView.load(URLRequest(url: url))
        }
    }

    private func getWKWebViewConfiguration() -> WKWebViewConfiguration {
        let userController = WKUserContentController()
        userController.add(self, name: "avataarCallBack")
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userController
        return configuration
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if let bodyString = message.body as? String {
            self.showToast(controller: self, message: bodyString, seconds: 1)
        } else {
            self.showToast(controller: self, message: "Call back function", seconds: 1)
        }
    }

    private func addToCart(proudctid: String) {
        
    }

    func checkCameraPermission() {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch cameraAuthorizationStatus {
            case .notDetermined: requestCameraPermission()
            case .authorized: loadPage()
            case .restricted, .denied: print("camera access denied")
            @unknown default: loadPage()
    }
    }
    
    func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: {accessGranted in
            guard accessGranted == true else { return }
            self.loadPage()
        })
    }
    
    func showToast(controller: UIViewController, message : String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 15
        controller.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
}

