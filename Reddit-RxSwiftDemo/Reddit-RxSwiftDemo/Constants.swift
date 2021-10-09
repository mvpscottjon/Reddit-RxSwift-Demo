//
//  Constants.swift
//  Reddit-RxSwiftDemo
//
//  Created by Seven on 2021/10/9.
//

import UIKit

struct Constants {

    
    static func  getFitScreenWRatio(oriW:CGFloat) -> CGFloat{
        
      return  UIScreen.main.bounds.width / oriW

    }
    
    static var apiBaseHost:String{
        
        #if DEBUG
        return "www.reddit.com"
        
        #else
        return "www.reddit.com"
        
        #endif
       
    }
    
    static var apiScheme:String{
        
        #if DEBUG
        return "https"
        
        #else
        return "https"
        #endif
    }
    
    
}

extension String{
    
    func toURL() -> URL?{
        
        let url = URL(string: self)
            return url
    }
    
}
extension UITableViewCell{
    
    static var cellID:String{
        return "\(self)"
    }
    
}

extension UIColor{
    
    convenience init(redPercent:CGFloat, greedPercent:CGFloat, bluePercent:CGFloat, alphaPercent:CGFloat ){
        self.init(red: redPercent / 255, green: greedPercent / 255 , blue: bluePercent / 255, alpha: alphaPercent / 100)
        
    }
    
}

extension UIColor{
    
    static let thumbnail = UIColor(redPercent: 128, greedPercent: 128, bluePercent: 128, alphaPercent: 100)
    
}

extension UIImage{
    
    
}

extension UIViewController{
    
    func showAlert(title:String?, errMsg:String , alertStyle:UIAlertController.Style = .alert){
        
        let act = UIAlertController(title: title, message: errMsg, preferredStyle: alertStyle)
        
        self.present(act, animated: true, completion: nil)
        
        
    }
     

  
    
}

extension NSObject {
    
    func debugPrint(_ items: Any...){
        #if DEBUG
        print("DEBUG ONLY: \(items)")
        #endif
       
    }
    
}