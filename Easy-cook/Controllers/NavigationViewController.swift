//
//  NavigationViewController.swift
//  Easy-cook
//
//  Created by Дербе Эмма on 01.03.2023.
//

import UIKit

// MARK: - viewDidLoad
class NavigationViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
    }
}

// MARK: - generateNavigationController
extension NavigationViewController {
    fileprivate func generateNavigationViewController(vc: UIViewController, image: UIImage) -> UINavigationController {

        let navigationVC = UINavigationController(rootViewController: vc)
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}

// MARK: - setupNavigationController
extension NavigationViewController {
    private func setupNavigationController() {
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().tintColor = .systemPink


        let homeVC = generateNavigationViewController(vc: ReciptsListVC(), image: UIImage(named: "main")!)
        let favoritesVC = generateNavigationViewController(vc: ReciptsListVC(),  image: UIImage(named: "favorite")!)
        
        let searchVC = generateNavigationViewController(vc: RecipeViewController(636729), image: UIImage(named: "search")!)

        UINavigationBar.appearance().prefersLargeTitles = true
        viewControllers = [homeVC, favoritesVC, searchVC]
    }
}




