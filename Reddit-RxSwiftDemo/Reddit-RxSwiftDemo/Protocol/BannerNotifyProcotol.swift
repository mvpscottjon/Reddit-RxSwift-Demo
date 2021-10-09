//
//  BannerNotifyProcotol.swift
//  Reddit-RxSwiftDemo
//
//  Created by Seven on 2021/10/10.
//

import UIKit

protocol BannerNotifyProcotol {

    func showBanner(msg:String?,type:NotifyBannerView.BannerType)
    func hideBanner()
}
extension UIViewController:BannerNotifyProcotol{
    
}
                                
                                
extension BannerNotifyProcotol where Self: UIViewController {
    
    func showBanner(msg:String?,type:NotifyBannerView.BannerType){
        
        view.subviews.forEach { subview in



            if subview.tag == Constants.bannerViewTag {

                subview.removeFromSuperview()

            }
        }
        
     
        
        let banner = NotifyBannerView(type:type, msg: msg)
        banner.tag = Constants.bannerViewTag
        self.view.addSubview(banner)
        banner.snp.makeConstraints({
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        })
     
        banner.alpha = 0
        self.view.bringSubviewToFront(banner)
      
        
        
        let fadeIn =   UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1, delay: 0,options: .curveEaseIn, animations: {

            banner.alpha = 1

        }, completion: {_ in
            
            let fadeOut = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 3, delay: 0.5, options: .curveEaseOut, animations: {
                banner.alpha = 0
                
            }, completion: nil)
            
            fadeOut.startAnimation()
            
        })
        
       

        fadeIn.startAnimation()
       
    }
    
    func hideBanner(){
        view.subviews.forEach { subview in

            if subview.tag == Constants.bannerViewTag {
                subview.removeFromSuperview()
            }
        }
        
    }
    
}
