import UIKit

class BaseTabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let buscaVC = self.criarTabItem(viewController: BuscaVC(), titulo: "Lista de usuários GIT", imagem: "icone-busca")

        viewControllers = [
            buscaVC
        ]
        
        selectedIndex = 2
    }
    
    func criarTabItem(viewController: UIViewController, titulo: String, imagem: String) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        
        viewController.navigationItem.title = titulo
        viewController.tabBarItem.title = titulo
        viewController.tabBarItem.image = UIImage(named: imagem)
        //viewController.view.backgroundColor = .white
        
        return navController
        
    }
    
}
