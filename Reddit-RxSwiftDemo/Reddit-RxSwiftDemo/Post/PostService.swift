//
//  PostService.swift
//  Reddit-RxSwiftDemo
//
//  Created by Seven on 2021/10/9.
//

import UIKit
import Alamofire
import RxSwift
protocol PostServiceProtocol{
    
//    func  loadTopPostList(completion: @escaping(PostListModel?,Error?) -> Void)
    func  loadTopPostListBySearchText(text:String?) -> Observable<[PostDetail]>
   func downloadImg(url:URL?, completion:@escaping(URL?,Error?) -> Void)
}

class PostService: NSObject , PostServiceProtocol{

    var scheme:String{return Constants.apiScheme}
    var baseURL:String {
        return Constants.apiBaseHost
    }
    
//    var path:String{return "/r/KEYWORD/top.json"}
    
    var baseHeader:HTTPHeaders{
        var headers = HTTPHeaders()
        headers.update(name: "Accept", value: "application/json")
        headers.update(name: "Content-Type", value: "application/json;charset=utf-8")
        return headers
        
    }
}

extension PostService {
//
//    func loadTopPostList(completion: @escaping(PostListModel?,Error?) -> Void){
//        var component = URLComponents()
//        component.scheme = scheme
//        component.host = baseURL
//        component.path = path
////        print("先看url",component.url)
//
//        guard let url = component.url else {
//            completion(nil,ServiceError.urlNil)
//            return}
//
//
//        AF.request(url, method: .get, headers: baseHeader).responseDecodable(of: PostListModel.self) { rs in
//
//            switch rs.result {
//            case .success(let obj):
//                completion(obj,nil)
//            case .failure(let err):
//                completion(nil,err)
//            }
//
//
//        }
//
//    }
//
    
    func loadTopPostListBySearchText(text:String?) -> Observable<[PostDetail]> {
        
        guard let  text = text else {return .just([])}
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = baseURL
        component.path = "/r/\(text)/top.json"
//        print("先看url",component.url)

        guard let url = component.url else {
            return .just([])}
        
        let req = URLRequest(url: url)
        let session = URLSession.shared
        
        return session.rx.data(request: req).map({ self.decodeJson(data: $0) })
        
        
       
        
    }
    
    func decodeJson(data: Data) -> [PostDetail] {
        
        guard let obj = try? JSONDecoder().decode(PostListModel.self, from:  data) else {return []}
                
               return  obj.data?.children ?? []
        
        
    }
    
}


extension PostService {
    
    func downloadImg(url:URL?, completion:@escaping(URL?,Error?) -> Void){
        
        guard let url = url else {
            completion(nil,ServiceError.urlNil)
            return}
        
        let task = URLSession.shared.downloadTask(with: url) { tmpURL, response, err in
            
//            print("下載成功嗎", tmpURL, err)
            
            
            completion(tmpURL,nil)
            
            
        }
        
        task.resume()
    }
    
    
    
}
