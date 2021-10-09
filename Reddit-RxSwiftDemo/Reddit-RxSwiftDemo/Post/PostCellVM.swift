//
//  PostCellVM.swift
//  Reddit-RxSwiftDemo
//
//  Created by Seven on 2021/10/9.
//

import UIKit

class PostCellVM: NSObject {

   
    
    var userName:String?{
        return self._obj?.data.subreddit_name_prefixed
//        return self._obj?.data.display_name ?? self._obj?.data.name
    }
    var userDetail:String?{
        
        var str = ""
        if let auther = self._obj?.data.author{
            str.append(auther)
            str.append("・")
        }
        if let time = self.createTime {
            str.append(time)
            str.append("・")
        }
        if let domain = self._obj?.data.domain{
            
            str.append(domain)
        }
        
        return str
    }
    var userPhotoURL:URL?{
        return self._obj?.data.icon_img?.toURL()
    }
    var title:String?{
        return self._obj?.data.title
    }
    var subtitle:String?{
        return self._obj?.data.id
    }
    var urlLink:URL?{
       var components = URLComponents()
        components.scheme = Constants.apiScheme
        components.host = Constants.apiBaseHost
        guard let path = self._obj?.data.url else {return nil}
        components.path = path
        
//        print("URLLink:",components.url)
        return components.url
    }
    var urlLinkAttrString:NSAttributedString?{
        let attr : [NSAttributedString.Key:Any] = [NSAttributedString.Key.foregroundColor: UIColor.blue,
                    NSAttributedString.Key.link:self.urlLink?.absoluteString ?? ""
        ]
        let attrStr = NSAttributedString(string: self.urlLink?.absoluteString ?? "", attributes: attr)
        
        return attrStr
    }
    var imgThumbnilURL:URL?{
//        return self._obj?.data.mobile_banner_image?.toURL()
//        print("看一下thumbnail:",self._obj?.data.thumbnail?.toURL())
        
//        return self._obj?.data.thumbnail?.toURL()
        return self._obj?.data.thumbnail?.toURL()

    }
    var imgThumbnilHeight:CGFloat?{
        guard let w = self._obj?.data.thumbnail_width, let h = self._obj?.data.thumbnail_height else {return nil}
//
//        let  h = CGFloat(arr[1])
        let oriW = CGFloat(w)
        let oriH = CGFloat(h)
       let ratio = Constants.getFitScreenWRatio(oriW: oriW)
//
        return  oriH *  (ratio)
        
        
    }

    var createTime:String?{
        
        
        guard let timeInterval = self._obj?.data.created else {return nil}
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        
       let date = Date(timeIntervalSince1970: timeInterval )
       let dateStr = formatter.string(from: date)
    
        print("Date:",date,dateStr)
        return dateStr
    }
  
    private var _obj:PostDetail?
    
    init(obj:PostDetail?){
        super.init()
        
        self._obj = obj
    }
}
