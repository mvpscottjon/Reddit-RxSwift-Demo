//
//  PostCellVM.swift
//  Reddit-RxSwiftDemo
//
//  Created by Seven on 2021/10/9.
//

import UIKit

class PostCellVM: NSObject {

   
    
    var userName:String?{
//        return self._obj?.data.subreddit_name_prefixed
        return self._obj?.data.display_name ?? self._obj?.data.author
    }
    var userDetail:String?{
        
        var str = ""
        if let name = self._obj?.data.name{
            str.append(name)
            str.append("・")
        }
        if let time = self.createTime {
            str.append(time)
//            str.append("・")
        }
//        if let domain = self._obj?.data.domain{
//
//            str.append(domain)
//        }
        
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
        guard let path = self._obj?.data.url else {
            
            return URL(string: self._obj?.data.url ?? "")
        }
        components.path = path
        
        guard let url = components.url else {
            
            return URL(string: self._obj?.data.url ?? "")
        }
        
        
//        print("URLLink:",components.url )
        return url
    }
    var urlLinkAttrString:NSAttributedString?{
        let attr : [NSAttributedString.Key:Any] = [NSAttributedString.Key.foregroundColor: UIColor.blue,
                    NSAttributedString.Key.link:self.urlLink?.absoluteString ?? ""
        ]
        let attrStr = NSAttributedString(string: self.urlLink?.absoluteString ?? "", attributes: attr)
        
        return attrStr
    }
    var imgThumbnailURL:URL?{
      
        return self._obj?.data.thumbnail?.toURL()
    }
    var imgThumbnail:UIImage?{
        
       let img = LocalStorageService.shared.retrieveImg(key: self.imgThumbnailURL?.absoluteString)
        
//        print("看img local file:",img)
        
        return img
    }
    var imgThumbnilHeight:CGFloat?{
        guard let w = self._obj?.data.thumbnail_width, let h = self._obj?.data.thumbnail_height else {return nil}
        let oriW = CGFloat(w)
        let oriH = CGFloat(h)
        let ratio = Constants.getFitScreenWRatio(oriW: oriW)
        return  oriH *  (ratio)
        
        
    }

    var createTime:String?{

        guard let timeInterval = self._obj?.data.created else {return nil}
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        let date = Date(timeIntervalSince1970: timeInterval )
        let dateStr = formatter.string(from: date)
        
        return dateStr
    }
  
    private var _obj:PostDetail?
    
    init(obj:PostDetail?){
        super.init()
        
        self._obj = obj
    }
}
