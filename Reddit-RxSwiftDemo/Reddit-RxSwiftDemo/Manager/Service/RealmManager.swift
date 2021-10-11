//
//  ReamlManager.swift
//  Reddit-RxSwiftDemo
//
//  Created by Seven on 2021/10/11.
//

import UIKit
import Realm
import RealmSwift
class RealmManager: NSObject {

   static let shared = RealmManager()
    
    private override init() {

    }

    
    
}

extension RealmManager{
    
    
    func getResults<T:Object>(type: T.Type) -> Results<T>? {
        let realm = try! Realm()
       
        
        return realm.objects(type)
    }
    
    
    func getObjectByPrimaryKey<T:Object>(type: T.Type, key: String) -> T? {
        let realm = try! Realm()
        //                let rs =  realm.object(ofType: type, forPrimaryKey: key)
        
        return realm.object(ofType: type, forPrimaryKey: key)
        
        
    }
    
    
    func saveObject(obj: Object,update:Realm.UpdatePolicy = .modified) {
        let realm = try! Realm()

          try! realm.write({
            
            realm.add(obj, update:update )
          })
      }
    
    func saveObjects(objs: [Object],update:Realm.UpdatePolicy = .modified) {
        let realm = try! Realm()

          try! realm.write({
              // If update = true, objects that are already in the Realm will be
              // updated instead of added a new.
            realm.add(objs, update:update )
          })
      }
    
    func deleteObjects(objs: Object){
        let realm = try! Realm()
        
        try! realm.write({
            realm.delete(objs)
            
        })
        
    }
    
    func deleteResults<T:Object>(rs: Results<T>?){
        
        guard let rs = rs  else {
            print("realm 刪除沒有 rs")
            return
        }
        
        let realm = try! Realm()
           
        
        
           try! realm.write({
               realm.delete(rs)
               
//            print("realm 刪除成功")

           })
           
        
        
       }
    
    
    func deleteList<T:Object>(list: List<T>?){
           
           guard let list = list  else {
               print("realm 刪除沒有 list")
               return
           }
           
           let realm = try! Realm()
              
           
           
              try! realm.write({
                  realm.delete(list)
                  
//               print("realm 刪除成功")

              })
              
           
           
          }
    
}
