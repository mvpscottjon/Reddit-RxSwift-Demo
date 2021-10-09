//
//  PostCoordinator.swift
//  Reddit-RxSwiftDemo
//
//  Created by Seven on 2021/10/7.
//

import UIKit

class PostCoordinator: Coordinator {
 
    
    var childCoordinator: [Coordinator] = []
    
    var navigation: UINavigationController?
    
   weak var parentCoordinator: Coordinator?
    
    init(navigation:UINavigationController?) {
        
        self.navigation = navigation
        
    }
    
    func start() {
        let vc = PostVC()
        vc.coordinator = self
        vc.modalPresentationStyle = .fullScreen
//        vc.view.backgroundColor = .red
        self.navigation?.pushViewController(vc, animated: true)
        
//        self.navigation?.viewControllers.last?.present(vc, animated: true, completion: nil)
//        let nc = UINavigationController(rootViewController: vc)
//        nc.modalPresentationStyle = .fullScreen
//        self.navigation?.present(nc, animated: true, completion: nil)
        
    }

}


extension PostCoordinator{
    
    func runWebViewFlow(url:URL?){
        let child = WebViewCoordinator(navigation: self.navigation, url: url)
        child.parentCoordinator = self
        self.childCoordinator.append(child)

        child.start()
        
//        let vc = CustomWebViewVC(url: url)
//        self.navigation?.pushViewController(vc, animated: true)
    }
    
}
