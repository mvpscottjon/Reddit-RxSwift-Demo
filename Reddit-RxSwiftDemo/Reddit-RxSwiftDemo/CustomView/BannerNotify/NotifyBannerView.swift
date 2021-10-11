//
//  BannerNotifyView.swift
//  Reddit-RxSwiftDemo
//
//  Created by Seven on 2021/10/10.
//

import UIKit

class NotifyBannerView: UIView {
    
    
    var lbMsg:UILabel = {
       let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 30)
        
        return lb
    }()

    enum BannerType{
        case success
        case failed
        case info
        
    }
    
    
    private  var msg:String?{
        
        didSet{
            self.lbMsg.text = self.msg
        }
        
    }
    
    private var _type:BannerType = .success
    init(type:BannerType = .success, msg:String?) {
        super.init(frame: .zero)
         self._type = type
        self.msg = msg
         self.setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}


extension NotifyBannerView{
    
    private func setupView(){
        lbMsg.text = msg
        self.addSubview(lbMsg)
        lbMsg.snp.makeConstraints({$0.edges.equalToSuperview()})
     
        switch self._type{
        case .success:
            lbMsg.backgroundColor = .init(redPercent: 92, greedPercent: 184, bluePercent: 92, alphaPercent: 100)
        case .info:
            lbMsg.backgroundColor = .init(redPercent: 43, greedPercent: 255, bluePercent: 0, alphaPercent: 100)
        case .failed:
            lbMsg.backgroundColor = .init(redPercent: 181, greedPercent: 0, bluePercent: 0, alphaPercent: 100)
            
        }
        
        
    }
    
}
