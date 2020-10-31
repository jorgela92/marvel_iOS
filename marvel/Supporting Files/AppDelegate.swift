//
//  AppDelegate.swift
//  marvel
//
//  Created by Jorge Lapeña Antón on 28/10/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    fileprivate var viewController: UITableViewController {
        return CharactersListViewController.loadFromNib()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupRootViewController()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}
}

//MARK: - private methods -
private extension AppDelegate {
    func setupRootViewController() {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        let navigationController = UIStoryboard(name: Storyboard.main, bundle: nil).instantiateViewController(withIdentifier: String(describing: ParentNavigationController.self)) as! ParentNavigationController
        navigationController.viewControllers = [viewController]
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}
