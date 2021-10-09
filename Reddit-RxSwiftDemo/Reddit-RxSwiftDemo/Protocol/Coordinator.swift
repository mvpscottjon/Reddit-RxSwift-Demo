//
//  Coordinator.swift
//  Reddit-RxSwiftDemo
//
//  Created by Seven on 2021/10/7.
//

import UIKit

protocol Coordinator: AnyObject{
    
    var childCoordinator: [Coordinator] {get set}
    var navigation: UINavigationController? {get set}
//    var parentCoordinator:Coordinator? {get}
    func start()
   
}

extension Coordinator{
    
    func removeChildCoordinator(child:Coordinator?){
        
        guard let child = child else {return}
        
        var targetIdx:Int?

        for (idx,v) in childCoordinator.enumerated(){
            
            if   v === child{
                
                targetIdx = idx
                
                break

            }
            
            
        }
        
        guard targetIdx != nil else {return}
        
        childCoordinator.remove(at: targetIdx!)
        
        
        
        
    }
    
}


