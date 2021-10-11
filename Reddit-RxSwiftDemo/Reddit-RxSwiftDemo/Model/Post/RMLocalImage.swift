//
//  RMLocalImage.swift
//  Reddit-RxSwiftDemo
//
//  Created by Seven on 2021/10/11.
//

import UIKit

import Realm
import RealmSwift
import CloudKit
class RMLocalImage: Object,Decodable {
    
    static override func primaryKey() -> String? {
        return "id"
    }
    
    
    @objc dynamic var id: String = ""
    @objc dynamic var fileURL: String?
    @objc dynamic var serviceURL: String?
    @objc dynamic var imgData: Data?
    //    let  imgURL = RealmProperty<String>()
    
//        let imgData = RealmOptional<Data>()
    
    enum CodingKeys: String, CodingKey{
        case id
        case serverURL
        case fileURL
        case imgData
    }
    
    convenience required init(from decoder: Decoder) throws {
        
        let container  = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(String.self, forKey: .id)
        let fileURL = try container.decode(String.self, forKey: .fileURL)
        let serverURL = try container.decode(String.self, forKey: .serverURL)
        let imgData = try container.decode(Data.self, forKey: .imgData)

        self.init(id: id, fileURL: fileURL,serverURL: serverURL, imgData: imgData)
      
    }
    
    convenience  init(id:String,fileURL:String?,serverURL: String?,imgData:Data? ) {
        self.init()
        self.id = id
        self.fileURL = fileURL
        self.imgData = imgData
        self.serviceURL = serverURL
    }
    
    required override init() {
        super.init()
    }
    
}
