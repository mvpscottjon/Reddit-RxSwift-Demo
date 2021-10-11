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
    func loadPostListBySearchText(text:String?,completion: @escaping([PostDetail],Error?) -> Void)
    func  loadTopPostListBySearchText(text:String?) -> Observable<[PostDetail]>
   func downloadImg(serverURL:URL?, completion:@escaping(URL?,Error?) -> Void)
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

    //user AF and completion
    func loadPostListBySearchText(text:String?,completion: @escaping([PostDetail],Error?) -> Void){
        
        guard let  text = text else {
            completion([],ServiceError.parameterNil)
            return
            
        }

        
        var component = URLComponents()
        component.scheme = scheme
        component.host = baseURL
        component.path = "/r/\(text)/top.json"
//        print("先看url",component.url)

        guard let url = component.url else {
            completion([],ServiceError.urlNil)
            return}


        AF.request(url, method: .get, headers: baseHeader).responseDecodable(of: PostListModel.self) { rs in

            switch rs.result {
            case .success(let obj):
                
                
                completion(obj.data?.children ?? [],nil)
            case .failure(let err):
                completion([],err)
            }


        }

    }

    
    //use rx and urlSession
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
    
   private func decodeJson(data: Data) -> [PostDetail] {
        
        guard let obj = try? JSONDecoder().decode(PostListModel.self, from:  data) else {return []}
                
               return  obj.data?.children ?? []
        
        
    }
    
}


extension PostService {
    
    func downloadImg(serverURL:URL?, completion:@escaping(URL?,Error?) -> Void){
        
        guard let serverURL = serverURL else {
            completion(nil,ServiceError.urlNil)
            return}

        
        AF.download(serverURL).response(completionHandler: {res in

            guard res.error == nil else {
                completion(nil,res.error)
                return
            }
            
            completion(res.fileURL,nil)

        })
        
    }
    
    
    
}
