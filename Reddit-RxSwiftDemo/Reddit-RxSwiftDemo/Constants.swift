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
    
    static let bannerViewTag = 1204980299998
    
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
    static let mainColor = UIColor.init(redPercent: 30, greedPercent: 37, bluePercent: 52, alphaPercent: 100)
}

extension UIImage{
    
    // load from path
    convenience init?(fileURLWithPath url: URL, scale: CGFloat = 1.0) {
        
     
        
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data, scale: scale)
        } catch {
            print("-- Error: \(error)")
            return nil
        }
    }
}

extension UIViewController{
    
    func showAlert(title:String?, errMsg:String , alertStyle:UIAlertController.Style = .alert){
        
        let act = UIAlertController(title: title, message: errMsg, preferredStyle: alertStyle)
        
        let action = UIAlertAction(title: "Ok", style: .default)
        
        act.addAction(action)
        
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
