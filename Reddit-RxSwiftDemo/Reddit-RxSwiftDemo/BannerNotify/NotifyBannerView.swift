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
        return lb
    }()
    override init(frame:CGRect) {
        super.init(frame: frame)
        
        self.setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}


extension NotifyBannerView{
    
    private func setupView(){
        
        self.addSubview(lbMsg)
        lbMsg.snp.makeConstraints({$0.edges.equalToSuperview()})
        
        
        
    }
    
}
