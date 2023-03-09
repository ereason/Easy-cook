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
        UITabBar.appearance().barTintColor = UIColor.backgroundColor
        UITabBar.appearance().tintColor = UIColor.redAccent


        let homeVC = generateNavigationViewController(vc: ReciptsListVC(), image: UIImage(named: K.mainImage)!)
        let favoritesVC = generateNavigationViewController(vc: FavVC(),  image: UIImage(named: K.favoriteImage)!)
        let searchVC = generateNavigationViewController(vc: SearchFoodViewController(), image: UIImage(named: K.searchImage)!)

        UINavigationBar.appearance().prefersLargeTitles = true
        viewControllers = [homeVC, favoritesVC, searchVC]
    }
}




