//
//  CustomWebViewVC.swift
//  Reddit-RxSwiftDemo
//
//  Created by Seven on 2021/10/9.
//

import UIKit
import WebKit

class CustomWebViewVC: UIViewController {

    var webView:WKWebView!
    
    var url:URL?
    
    weak var coordinator:WebViewCoordinator?
    
    init(url:URL?){
        
        super.init(nibName: nil, bundle: nil)
        
        self.url = url
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.setupWebView()
        
    }
    
    deinit{
        print("\(self) deinit!!!!!!")
        self.coordinator?.parentCoordinator?.removeChildCoordinator(child: self.coordinator)
    }
    
  

}

extension CustomWebViewVC{
    
    private func setupWebView(){
    
        self.webView = WKWebView(frame: .zero)
        self.view.addSubview(self.webView)
        self.webView.snp.makeConstraints({
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        })
        
        guard let url = self.url   else {
            
            print("沒有Url")
            
            return}

        let req = URLRequest(url: url)
        self.webView.load(req)
        
        
    }
    
    private func loadURL(){
        
        print("有跑loarURL:",self.url)
        guard let url = self.url   else {
            
            return}
        
        
        let req = URLRequest(url: url)
        self.webView.load(req)
    }
    
}
