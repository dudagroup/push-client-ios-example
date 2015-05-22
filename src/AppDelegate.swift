//
//  AppDelegate.swift
//  PushClientExample
//
//  Copyright (c) 2015 DU DA Group. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let pushClient = PushClient(pushServerUrl: NSURL(string: "http://192.168.1.133:3000/")!)

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        if PushClientHelper.mustRegisterUserNotificationSettings {
            PushClientHelper.registerUserNotificationSettings()
        } else {
            PushClientHelper.registerForRemoteNotificationTypes()
        }
        
        PushClientHelper.addCallbackHandler { (userInfo, fromBackground) -> Void in
            NSLog("userInfo %@", userInfo)
            NSLog("fromBackground %@", fromBackground)
        }
        
        
        PushClientHelper.handleLaunchNotification(launchOptions)
        
        return true
    }

    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        pushClient.subscribe(deviceToken, domain: "test", customData: nil)
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        NSLog("Register Error %@", error)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        PushClientHelper.receivedRemoteNotification(userInfo)
    }
}

