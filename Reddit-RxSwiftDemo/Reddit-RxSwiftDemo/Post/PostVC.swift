//
//  PostVC.swift
//  Reddit-RxSwiftDemo
//
//  Created by Seven on 2021/10/7.
//

import UIKit
//import RxSwift
import RxDataSources
import SnapKit
import RxCocoa
import RxSwift
import RxGesture
class PostVC: UIViewController {

    var vm = PostVM()
    var tbView:UITableView  = UITableView(frame: .zero, style: .plain)
    var searchBar = UISearchBar(frame: .zero)
    
    let dBag = DisposeBag()
    
    weak var coordinator:PostCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        bindUI()
        testUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    deinit{
        debugPrint("\(self) deinit!!!!!!")
        self.coordinator?.parentCoordinator?.removeChildCoordinator(child: self.coordinator)

    }
    
}

extension PostVC{
    func createUI() {
        
        self.setupSearchBar()
        self.setupTbView()
        
    }
    
    func bindUI() {
        //MARK: bind tbView
//      _ =  self.vm.obPostDeatilArr.bind(to: self.tbView.rx.items){ tb, row, post in
//
//            self.configCell(tablieView: tb, row: row, post: post)
//      }.disposed(by: dBag)
        
        //MARK: tbView delegate
        _ = self.tbView.rx.setDelegate(self).disposed(by: dBag)
        
        //MARK:bind searchBar
        
        let searchRS = self.searchBar.rx.text.orEmpty.throttle(.microseconds(300), scheduler: MainScheduler.instance).distinctUntilChanged().flatMapLatest({ query -> Observable<[PostDetail]> in

            if query.isEmpty {
                return .just([])
            }

            return self.vm.loadPostListBySearch(text: query).catchAndReturn([])

        }).observe(on: MainScheduler.instance)

       _ = searchRS.bind(to: self.tbView.rx.items){ tb, row, post in
            
            self.configCell(tablieView: tb, row: row, post: post)
        }.disposed(by: dBag)
        
        
        //MARK: errMsg
        
        _ = self.vm.obErrMsg.subscribe(onNext: {[weak self] err in
            
            guard err != nil else {return}
            
            self?.showAlert(title: "Error！！", errMsg: err?.localizedDescription ?? "")
        })
        
        
    }
    
    func testUI(){
//        self.searchBar.backgroundColor = .red
//        self.tbView.backgroundColor = .white
    }
}

extension PostVC{
    
    private func setupSearchBar(){
        searchBar.text = "TAIWAN"
        searchBar.isTranslucent = false
        self.view.addSubview(searchBar)
        searchBar.snp.makeConstraints({
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(70)
            $0.leading.trailing.equalToSuperview().inset(10)
        })
        
    }
    
    private func setupTbView(){
        self.tbView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.cellID)
        self.tbView.register(PostTbCell.self, forCellReuseIdentifier: PostTbCell.cellID)

        
        self.view.addSubview(tbView)
        tbView.snp.makeConstraints({
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
        })
        
        
    }
}

extension PostVC {
    
    private func configCell(tablieView:UITableView, row:Int, post:PostDetail ) -> UITableViewCell{
        let cell = tablieView.dequeueReusableCell(withIdentifier: PostTbCell.cellID) as! PostTbCell
        
        cell.cellVM = PostCellVM(obj: post)
        //MARK:btnURL tapped
        cell.btnURL.rx.tap.subscribe(onNext: {[weak self] in
//            print("點了link:",cell.cellVM?.urlLink?.absoluteString)
            self?.openWebView(url: cell.cellVM?.urlLink)
        }).disposed(by: cell.dBag)
        
        //MARK: img LongPress
        cell.imgViewThumbnail.rx.longPressGesture(configuration: nil).when(.began).subscribe(onNext: { [weak self] gesture in
            
            self?.debugPrint("長按了")
            self?.saveImgToLocal(img: cell.imgViewThumbnail.image)
        }).disposed(by: cell.dBag)
//        let longPress = UILongPressGestureRecognizer()
//        cell.imgViewThumbnail.addGestureRecognizer(longPress)
//
//        longPress.rx.event.when.subscribe(onNext: {[weak self] _ in
//
//            self?.debugPrint("長按了哦")
//
//        }).disposed(by: cell.dBag)
        
        return cell
    }
}

extension PostVC{
    
    private func openWebView(url:URL?){
//        //
//        guard let url = url else {return}
//        UIApplication.shared.open(url)
//        DispatchQueue.main.async {
            self.coordinator?.runWebViewFlow(url: url)
//
//        }
        
//        let vc = CustomWebViewVC(url: url)

//        self.navigationController?.pushViewController(vc, animated: true)
        
//        self.navigationController?.present(vc, animated: true, completion: nil)

    }
    
    private func saveImgToLocal(img:UIImage?){
        
        debugPrint("alert save")
        let act = UIAlertController(title: "儲存照片", message: nil, preferredStyle: .actionSheet)
        
        let save = UIAlertAction(title: "Save", style: .default, handler: { [weak self] _ in
            
            self?.vm.saveImgToLocal(img: img)
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in })
     
        act.addAction(save)
        act.addAction(cancel)
        
        self.present(act, animated: true, completion: nil)
        
    }
    
}

extension PostVC :UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
