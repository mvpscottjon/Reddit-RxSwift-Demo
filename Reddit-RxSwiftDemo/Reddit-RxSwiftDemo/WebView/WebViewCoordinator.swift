//
//  WebViewCoordinator.swift
//  Reddit-RxSwiftDemo
//
//  Created by Seven on 2021/10/9.
//

import UIKit

class WebViewCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    
    var navigation: UINavigationController?
    weak var parentCoordinator:Coordinator?
    private var _url:URL?
    init(navigation:UINavigationController?, url:URL?){
        self._url = url
        self.navigation = navigation
        
    }
    
    
    
    func start() {
        let vc = CustomWebViewVC(url: self._url)
        vc.coordinator = self
//        self.navigation?.pushViewController(vc, animated: true)
        self.navigation?.present(vc, animated: true, completion: nil)
        
    }
    

    deinit{
        debugPrint("WEb Coordinator deinit!!!!!!")
        
    }
    
    
}

extension WebViewCoordinator {
    
    
    
    
}
