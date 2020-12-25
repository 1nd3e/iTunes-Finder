//
//  AppDelegate.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 25.12.2020.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {
    
    // MARK: - Properties
    
    var window: UIWindow?
    
    private lazy var tabBarController: UITabBarController = {
        let searchViewController = SearchConfigurator.shared.configure()
        searchViewController.tabBarItem.title = "Search"
        
        let searchHistoryViewController = SearchHistoryConfigurator.shared.configure()
        searchHistoryViewController.tabBarItem.title = "History"
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [searchViewController, searchHistoryViewController]
        
        return tabBarController
    }()
    
    // MARK: - Methods
    
    // Sets root UIViewController in the window.
    private func setRootViewController() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        self.window = window
    }
    
}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setRootViewController()
        
        return true
    }
    
}
