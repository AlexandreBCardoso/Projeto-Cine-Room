//
//  AppDelegate.swift
//  CineRoom
//
//  Created by ANDRE LUIZ TONON on 26/02/21.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		FirebaseApp.configure()
		GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
		ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions )
		
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
	
	
	// MARK: - Google Sign In
	func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
		
		ApplicationDelegate.shared.application(app,
															open: url,
															sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
															annotation: options[UIApplication.OpenURLOptionsKey.annotation]
		)
		
		return ((GIDSignIn.sharedInstance()?.handle(url)) != nil)
	}
	
}
