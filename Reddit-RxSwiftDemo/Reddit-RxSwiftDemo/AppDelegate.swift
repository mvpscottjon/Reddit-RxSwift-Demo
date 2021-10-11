//
//  AppDelegate.swift
//  Reddit-RxSwiftDemo
//
//  Created by Seven on 2021/10/7.
//

import UIKit
//import SwiftUI
import RealmSwift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    var appCoordinator:AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {


//        self.configAppCoordinator()
        self.configNavBar()
        self.congifRealm()
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


extension AppDelegate{
    
    private func configAppCoordinator(){
        
        print("config appCoordinator")
        
        let navVC = UINavigationController(rootViewController: UIViewController())
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navVC
        self.window?.backgroundColor = .white
        
        appCoordinator = AppCoordinator(navigation: navVC)
        appCoordinator?.start()
        self.window?.makeKeyAndVisible()
        
    }
    
    private func configNavBar(){
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .mainColor
        
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        if #available(iOS 15.0, *) {
            UINavigationBar.appearance().compactScrollEdgeAppearance = appearance
        }
        
    }
    
    private func congifRealm(){
        
        var config = Realm.Configuration(
      
            schemaVersion: 1,

            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {
                
                }
            })

        config.deleteRealmIfMigrationNeeded = true
        // Tell Realm to use this new configuration bject for the default Realm
        Realm.Configuration.defaultConfiguration = config

//        let realm = try! Realm()
        
        
//        try!  realm.write {
//
//            realm.deleteAll()
//
//        }
    }
}
