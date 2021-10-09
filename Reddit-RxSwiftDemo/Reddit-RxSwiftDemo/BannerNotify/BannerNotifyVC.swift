//
//  BannerNotifyVC.swift
//  Reddit-RxSwiftDemo
//
//  Created by Seven on 2021/10/10.
//

import UIKit

class BannerNotifyVC: UIViewController {

  
    var msg:String?{
        
        didSet{
            self.debugPrint("msg:",msg)
            
        }
    }
    
    init(msg:String?) {
        super.init(nibName: nil, bundle: nil)
        self.msg = msg
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    


}
