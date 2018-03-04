//
//  AppDelegate.swift
//  Westeros
//
//  Created by Jorge Vinaches on 08/02/2018.
//  Copyright © 2018 Jorge Vinaches. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var splitViewController: UISplitViewController?
    
    // Crear el modelo
    let houses = Repository.local.houses
    let seasons = Repository.local.seasons
    
    var houseListViewController: HouseListViewController?
    var seasonListViewController: SeasonListViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.backgroundColor = .cyan
        window?.makeKeyAndVisible()
        
        // Creamos los controladores (masterVC, detailVC)
        houseListViewController = HouseListViewController(model: houses)
        let lastSelectedHouse = houseListViewController!.lastSelectedHouse()
        let houseDetailViewController = HouseDetailViewController(model: lastSelectedHouse)
        houseListViewController!.delegate = houseDetailViewController
        
        seasonListViewController = SeasonListViewController(model: seasons)
        let lastSelectedSeason = seasonListViewController!.lastSelectedSeason()
        let seasonDetailViewController = SeasonDetailViewController(model: lastSelectedSeason)
        seasonListViewController!.delegate = seasonDetailViewController
        
        let houseListNavigationViewController = houseListViewController!.wrappedInNavigation()
        let seasonListNavigationViewController = seasonListViewController!.wrappedInNavigation()

        let tabBarController = UITabBarController()
        tabBarController.delegate = self
        tabBarController.viewControllers = [
            houseListNavigationViewController,
            seasonListNavigationViewController
        ]
        
        splitViewController = UISplitViewController()
        splitViewController?.viewControllers = [
            tabBarController.wrappedInNavigation(),
            houseDetailViewController.wrappedInNavigation(),
            seasonDetailViewController.wrappedInNavigation()
        ]
        
        houseDetailViewController.navigationItem.leftItemsSupplementBackButton = true
        houseDetailViewController.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        
        window?.rootViewController = splitViewController
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension AppDelegate: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        var viewController: UIViewController
        
        switch tabBarController.selectedIndex {
        case 0:
            let lastSelectedHouse = houseListViewController!.lastSelectedHouse()
            let houseDetailViewController = HouseDetailViewController(model: lastSelectedHouse)
            houseListViewController!.delegate = houseDetailViewController
            
            viewController = houseDetailViewController
        case 1:
            let lastSelectedSeason = seasonListViewController!.lastSelectedSeason()
            let seasonDetailViewController = SeasonDetailViewController(model: lastSelectedSeason)
            seasonListViewController!.delegate = seasonDetailViewController
            
            viewController = seasonDetailViewController
        default:
            return
        }
        
        viewController.navigationItem.leftItemsSupplementBackButton = true
        viewController.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        
        splitViewController?.showDetailViewController(viewController.wrappedInNavigation(), sender: nil)
    }
}
