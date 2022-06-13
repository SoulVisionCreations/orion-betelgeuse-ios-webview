# Sample iOS Application for Avataar Integration

This repository contains sample code for integrating Avataar experience URL into your iOS Application.

## Key Terms

- Product ID: This is the primary product identifier
- Variant ID: Sometimes products have multiple variants like color etc. If each such variant has a unique Product ID, then variant ID is the same as Product ID. If all variants have the same Product ID, then unique ID used to represent the variant should be used here.
- Parent App: The parent application invoking the Avataar's Web experience.

## Key Files

- ViewController.swift: This is main ViewController, The ViewController passes on the prodcutId and variantId to the AvataarWebView. Before open webview it will invoke camerea access and after authorise to the app, It will call a openWebView method, which is inherited from AvataarWebView. 
- AvataarWebView.swift: This class contains the boilerplate code to invoke the actual Avataar Web experience. This triggers the Avataar experience URL. This takes the productID and variantID from the ViewController above. It has a method called #"userContentController" and It provides a bridge between your app and the JavaScript code running in the web view. Use this method to respond to a message sent from the webpage’s JavaScript code and This method attaches the Javascript bridge Object with webView window object.

## Operation

- Avataar's Web experience might have buttons for functionalities like AddToCart. When the end-user clicks these buttons, the Parent App needs to be informed to take the necessary actions.
- AvataarWebView defines the callback functions required by Avataar's Web experience.
- In addition to this, product ID and variant ID are also needed for the Avataar Web experience. This is also passed during the openWebView call to AvataarWebView.
- In this example, the Avataar Web experience is triggered from ViewController after authorize camera access.
- The product and variant ID are passed from the ViewController to the AvataarWebView.

## How to run
