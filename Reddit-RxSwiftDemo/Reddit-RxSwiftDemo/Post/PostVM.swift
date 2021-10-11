//
//  PostVM.swift
//  Reddit-RxSwiftDemo
//
//  Created by Seven on 2021/10/7.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa
class PostVM: NSObject {

    let _service:PostServiceProtocol
    let _localService:LocalStorageServiceProtocol = LocalStorageService()
    let obPostDeatilArr = BehaviorRelay<[PostDetail]>(value: [])
    
    let isDownloadingSuccess = PublishRelay<Bool>()
    let isLoading = BehaviorRelay<Bool>(value: false)
    let obErrMsg = BehaviorRelay<Error?>(value: nil)
    
    init(apiService:PostServiceProtocol = PostService(), localService:LocalStorageServiceProtocol = LocalStorageService()) {
        self._service = apiService
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
    
//    func loadPostListBySearchText(text:String?)  {
//        self._service.loadPostListBySearchText(text: text, completion: {arr, err in
//
//            print("搜尋字\(text)回來：",arr.count,err)
//
//            guard err == nil else {
//                self.obPostDeatilArr.accept([])
//                return}
//
//            self.obPostDeatilArr.accept(arr)
//
//
//        })
//
//    }
    
    func loadPostListBySearch(text:String?) -> Observable<[PostDetail]>{

        
       return self._service.loadTopPostListBySearchText(text: text)
    }
    
}

extension PostVM{
    

    func downloadImg(url:URL?){
//        self.isLoading.accept(true)
        self._service.downloadImg(serverURL: url, completion: { fileURL,err in
            
            guard err == nil else {
                self.obErrMsg.accept(err)
                self.isDownloadingSuccess.accept(false)
                return}
     
            //save to local
            self._localService.saveImg(key: url?.absoluteString, tmpFileURL: fileURL, storageType: .realmSystem, completion: {targetFileURL, localErr in
                
                guard localErr == nil else {
                    self.obErrMsg.accept(localErr)
                    self.isDownloadingSuccess.accept(false)
                    return}
  
                self.isDownloadingSuccess.accept(true)
//                self.isLoading.accept(false)
            })
           
            
            
        })
        
        
    }
    
}
