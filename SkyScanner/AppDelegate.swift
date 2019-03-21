import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupWindow()
        
        setupRootNavigation()
        
        return true
    }
    
    private func setupWindow() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
    }
    
    private func setupRootNavigation() {
        let style = SkyScannerStyle()
        let tabBarController = UITabBarController(nibName: nil, bundle: nil)
        tabBarController.removeTabbarItemsText()
        tabBarController.tabBar.tintColor = style.tintColor
        tabBarController.tabBar.addShadow(drectionY: -6)
        
        window?.rootViewController = tabBarController
        let searchFlightsModule = SearchFlightsRouter.createModule()
        
        let navigationController = UINavigationController(rootViewController: searchFlightsModule.view)
        navigationController.tabBarItem.image = UIImage(named: "search")
        navigationController.navigationBar.tintColor = style.tintColor
        navigationController.navigationBar.addShadow(drectionY: 6)
        
        let exploreController = UINavigationController()
        exploreController.tabBarItem.image = UIImage(named: "explore")
        
        let profileController = UINavigationController()
        profileController.tabBarItem.image = UIImage(named: "profile")
        
        tabBarController.setViewControllers([exploreController,
                                             navigationController,
                                             profileController], animated: false)
        
        tabBarController.selectedIndex = 1
    }

}

