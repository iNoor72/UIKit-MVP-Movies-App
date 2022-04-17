//
//  AppDelegate.swift
//  VeryCreativesTask
//
//  Created by Noor Walid on 14/04/2022.
//

import UIKit
import AlamofireNetworkActivityLogger
import MOLH

@available(iOS 13.0, *)
@main
class AppDelegate: UIResponder, UIApplicationDelegate, MOLHResetable {
    func reset() {
        let rootViewController: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        let story = UIStoryboard(name: "Main", bundle: nil)
        rootViewController.rootViewController = story.instantiateViewController(withIdentifier: Constants.ViewControllers.HomeViewController)
    }
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        NetworkActivityLogger.shared.startLogging()
        MOLH.shared.activate(true)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

@available(iOS 13.0, *)
extension AppDelegate: LocalizationDelegate {
    func resetApp() {
        let rootViewController: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        let story = UIStoryboard(name: "Main", bundle: nil)
        rootViewController.rootViewController = story.instantiateViewController(withIdentifier: Constants.ViewControllers.HomeViewController)
        }
}
