//
//  LocalService.swift
//  Reddit-RxSwiftDemo
//
//  Created by Seven on 2021/10/11.
//

import UIKit

protocol LocalStorageServiceProtocol{
    
   
    
    
    func retrieveImg(key:String? , storageType:StorageType) -> UIImage?
    
    func saveImg(key:String?,tmpFileURL:URL?, storageType:StorageType, completion: @escaping(URL?,Error?) -> Void)
}

enum StorageType{
//        case fileSystem
    case userDefaults
    case realmSystem
    
}

class LocalStorageService: NSObject,LocalStorageServiceProtocol {

   static let shared = LocalStorageService()
//    private override init() {
//
//    }
    
 
    enum LocalServiceError:Error{
        case oriURLNil
        case targetURLNil
        case docURLNil
        
    }
    
}


extension LocalStorageService{
    
    
    func retrieveImg(key:String? , storageType:StorageType = .realmSystem) -> UIImage? {
        
        guard let key = key else {return nil}
        

        
        switch storageType {
//        case .fileSystem:
//            return nil
        case .userDefaults:
            
            
            guard let value =  UserDefaults.standard.value(forKey: key) as? Data else {return nil}
            
            let data = try! PropertyListDecoder().decode(Data.self, from: value)
            
    //        print("先看v:",value,UIImage(data: data))
            
            return UIImage(data: data)
        case .realmSystem:
            
            let obj = RealmManager.shared.getObjectByPrimaryKey(type: RMLocalImage.self, key: key)
            
            

            guard let fileURL = obj?.fileURL?.toURL(), let data = obj?.imgData else {
                print("fileURL nil")
                return nil}
            
            
            
          
            
            
            let img = UIImage(data: data)
            
//            print("先看realm get v:",fileURL,data,img)

            return img
         
            
        }
        
        
        
    }
    
    func saveImg(key:String?,tmpFileURL:URL?, storageType:StorageType = .realmSystem  , completion: @escaping(URL?,Error?) -> Void){
        guard   let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first, let key = key else {
            completion(nil,LocalServiceError.docURLNil)
            return}

        let time = Int(Date().timeIntervalSince1970)
        let targetFileURL = docs.appendingPathComponent("\(time).jpg")
        
        
        guard let url = tmpFileURL else {
            debugPrint("url nil")
            completion(nil,LocalServiceError.oriURLNil)

            return}
        
        do{
            
            if FileManager.default.fileExists(atPath: targetFileURL.path){
                
                try FileManager.default.removeItem(at: targetFileURL)
                
              
                
            }
            
            
            
            try FileManager.default.copyItem(at: url, to: targetFileURL)

            

            
            
            
            completion(targetFileURL,nil)
            
        } catch{
            debugPrint("錯誤:",error)
            
            completion(nil,error)

        }
        
        
        
        switch storageType {

        case .userDefaults:
            //save to userDefaults
            let img = UIImage(contentsOfFile: targetFileURL.path)
            guard let data = try? PropertyListEncoder().encode(img?.pngData()) else {return}
            UserDefaults.standard.set(data, forKey: key)
            
            
        case .realmSystem:
            //save to realm
            let manager = RealmManager.shared
            let data = try? Data(contentsOf: targetFileURL)
            let obj = RMLocalImage(id: key, fileURL: targetFileURL.absoluteString, serverURL: key ,  imgData: data)
            
            manager.saveObject(obj: obj)
            
    
            
        }
     
   
        
    }
    
    
}
