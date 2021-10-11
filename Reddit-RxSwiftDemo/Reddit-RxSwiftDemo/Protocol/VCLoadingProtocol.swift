//
//  VCLoadingProtocol.swift
//  Reddit-RxSwiftDemo
//
//  Created by Seven on 2021/10/11.
//

import UIKit


protocol VCLoadingProtocol {
        
    func showLoadingView()
    func hideLoadingView()
    
}
extension UIViewController:VCLoadingProtocol{
    
    
}

extension VCLoadingProtocol where Self: UIViewController {
    
    func showLoadingView() {
        
        
        view.subviews.forEach { subview in
            
        
            
            if subview.tag == Constants.viewTagForLoadingView {
//                print("原本就有loadingView 不做事")
                
//                isExist = true
                subview.removeFromSuperview()
                
            }
        }
        
        
        
        
        let loadingView = UIView(frame: .zero)
            loadingView.tag = Constants.viewTagForLoadingView
//            loadingView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alphaPercentage: 50)
     
         let animateView =    UIActivityIndicatorView()
        
        
        loadingView.addSubview(animateView)
        
        
        animateView.snp.makeConstraints({$0.center.equalToSuperview()
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize(width: 70, height: 70))
            
        })
        
      
        
        
        
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints({
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
            
        })
    
  
        animateView.startAnimating()
        
    }
    
    func hideLoadingView() {
        view.subviews.forEach { subview in
            

            if subview.tag == Constants.viewTagForLoadingView {
                subview.removeFromSuperview()
            }
        }
    }
}

