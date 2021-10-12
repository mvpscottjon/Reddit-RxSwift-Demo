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
        self.navigation?.pushViewController(vc, animated: true)
   
        
    }

}


extension PostCoordinator{
    
    func runWebViewFlow(url:URL?){
        let child = WebViewCoordinator(navigation: self.navigation, url: url)
        child.parentCoordinator = self
        self.childCoordinator.append(child)

        child.start()

    }
    
}
