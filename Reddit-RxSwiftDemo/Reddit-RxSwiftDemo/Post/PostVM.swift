//
//  PostVM.swift
//  Reddit-RxSwiftDemo
//
//  Created by Seven on 2021/10/7.
//

import UIKit
import RxSwift
import RxRelay
class PostVM: NSObject {

    let _service:PostServiceProtocol
    let obPostDeatilArr = BehaviorRelay<[PostDetail]>(value: [])
    
    let isDownloadingSuccess = PublishRelay<Bool>()
    let obErrMsg = BehaviorRelay<Error?>(value: nil)
    
    init(service:PostServiceProtocol = PostService()) {
        self._service = service
        super.init()
        
//        self.loadTopList()
    }
    
}

extension PostVM{
    
//    func loadTopList(){
//        self._service.loadTopPostList(completion: {obj,err in
//
//            guard err == nil else {
//                self.obErrMsg.accept(err)
//                return}
//
//            print("結果回來:",obj?.data?.children?.count)
//
//            self.obPostDeatilArr.accept(obj?.data?.children ?? [])
//
//
//        })
//
//    }
    
    
    func loadPostListBySearch(text:String?) -> Observable<[PostDetail]>{
//        guard let text = text else {return .just([])}
//        var component = URLComponents()
//        component.scheme = Constants.apiScheme
//        component.host = Constants.apiBaseHost
//        component.path = "/\(text)/top.json"
//        
//        guard let url = component.url else {return .just([])}
//        
//        let req = URLRequest(url: url)
//        let sesson = URLSession.shared
//        
//        return sesson.rx.data(request: req).map({
//            
//        })
        
       return self._service.loadTopPostListBySearchText(text: text)
    }
    
}

extension PostVM{
    
//    func saveImgToLocal(img:UIImage?){
//
//        guard let img = img else {return}
//
//        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
//
//
//    }
//
    func downloadImg(url:URL?){
        
        self._service.downloadImg(url: url, completion: { fileURL,err in
            
            guard err == nil else {
                self.isDownloadingSuccess.accept(false)
                return}
            
            self.isDownloadingSuccess.accept(true)
        })
        
        
    }
    
}
