//
//  AvataarWebView.swift
//  WebViewDemo
//
//  Created by avataar on 13/06/22.
//

import UIKit
import WebKit
import AVFoundation

struct ScriptMessage: Codable {
    let type: String
    let productId: String
    let variantId: String
}

class AvataarWebView: UIViewController, WKScriptMessageHandler {
   
    private var wkWebView: WKWebView!
    
    public func setupWKWebview() {
        self.wkWebView = WKWebView(frame: self.view.bounds, configuration: self.getWKWebViewConfiguration())
        self.view.addSubview(self.wkWebView)
    }

    public func openWebView(productId: String, variantId: String) {
        let urlString = "https://orion-dev.avataar.me/engine/TOUCHCHANGES1/AVTR_EXP_d41d8cd9/index.html?ar=0&tenantId=AVTR-TNT-t8mv4evu&productId="+productId+"&variantId="+variantId+"&env=local&onFloor=false"
        if let url = URL(string:  urlString) {
            self.wkWebView.load(URLRequest(url: url))
        }
    }

    public func getWKWebViewConfiguration() -> WKWebViewConfiguration {
        let userController = WKUserContentController()
        userController.add(self, name: "avataarCallBack")
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userController
        return configuration
    }

   // A WKUserContentController object provides a bridge between your app and the JavaScript code running in the
   // web view and allow to call custom JavaScript and Native App functions that call through to your web and
   // native app code.
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let bodyString = message.body as? String,
                 let bodyData = bodyString.data(using: .utf8) else {
               return
           }
           
           if let bodyStruct = try? JSONDecoder().decode(ScriptMessage.self, from: bodyData) {
                switch(bodyStruct.type) {
                    case "addToCart":
                        addToCart(productId: bodyStruct.productId, variantId: bodyStruct.variantId)
                    case "removeFromCart" :
                        removeFromCart(productId: bodyStruct.productId, variantId: bodyStruct.variantId)
                    default:
                        print("Unsupported message")
                }
           }
    }
    
    // Add Product to Card
    func addToCart(productId: String, variantId: String) {
        print("Add to Cart: Product Id - " + productId + " Variant Id" + variantId)
    }

    // Remove Product from Card
    func removeFromCart(productId: String, variantId: String){
        print("Remove from Cart: Product Id - " + productId + " Variant Id" + variantId)
    }
    
    // Goto Cart
    func goToCart() -> Void {
        print("Go to Cart")
    }

    //Close View
    func closeWebView() -> Void {
        print("clsoe Web View")
    }
}
