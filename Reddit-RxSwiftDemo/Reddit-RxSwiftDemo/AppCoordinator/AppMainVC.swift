//
//  AppMainVC.swift
//  Reddit-RxSwiftDemo
//
//  Created by Seven on 2021/10/9.
//

import UIKit

class AppMainVC: UIViewController {
    
    
    weak var coordinator:AppCoordinator? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
        DispatchQueue.main.async {
            self.run()
        }
          
//        })
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    
}

extension AppMainVC{
    
    func run(){
        self.coordinator?.runPostFlow()

        
    }
    
}
