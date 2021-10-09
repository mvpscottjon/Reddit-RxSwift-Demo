//
//  AppCoordinator.swift
//  Reddit-RxSwiftDemo
//
//  Created by Seven on 2021/10/7.
//

import UIKit

class AppCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    
    var navigation: UINavigationController?
    
    weak var parentCoordinator: Coordinator?

    
    init(navigation:UINavigationController){

        self.navigation = navigation
    }
    
//    init(){
//
//    }
    
    func start() {
        
        
        let vc = AppMainVC()
//        vc.view.backgroundColor = .green
        vc.coordinator = self
        self.navigation?.pushViewController(vc, animated: false)
//        self.navigation?.present(vc, animated: true, completion: nil)

//        self.navigation?.setViewControllers([vc], animated: true)
            
        
    }
    

}

extension AppCoordinator{
    
    
    func runPostFlow(){
        
        print("有跑run post")
        let child = PostCoordinator(navigation: self.navigation)
        child.parentCoordinator = self
        self.childCoordinator.append(child)
        child.start()
    }
    
}
