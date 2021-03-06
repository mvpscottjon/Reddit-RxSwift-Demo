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
import Kingfisher
class PostVC: UIViewController {

    var vm = PostVM()
    var tbView:UITableView  = UITableView(frame: .zero, style: .plain)
    var searchBar :UISearchBar = {
        let bar = UISearchBar(frame: .zero)
        bar.text = "TAIWAN"
        bar.placeholder = "Search"
        bar.isTranslucent = false

        return bar
    }()
    
    private let loadingActivityIndicator = UIActivityIndicatorView()
    
    private let refreshControl: UIRefreshControl = {
        return UIRefreshControl()
    }()
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
        
        self.hideKeyboardWhenTounchAround()
    }
    
    func bindUI() {

        //MARK: tbView delegate
        _ = self.tbView.rx.setDelegate(self).disposed(by: dBag)
  
        //MARK: bind Table data
        self.vm.obPostDeatilArr.bind(to: self.tbView.rx.items){ tb, row, post in

            self.configCell(tablieView: tb, row: row, post: post)
        }.disposed(by: dBag)

        //MARK: Bind search
        let searchRS = self.searchBar.rx.text.orEmpty.throttle(.microseconds(300), scheduler: MainScheduler.instance).distinctUntilChanged().flatMapLatest({ [unowned self]  query -> Observable<[PostDetail]>  in
            
            if query.isEmpty{
                
                return self.vm.loadPostListBySearch(text: "all").catchAndReturn([])
            }
            
            return self.vm.loadPostListBySearch(text: query).catchAndReturn([])
            
        }).observe(on: MainScheduler.instance)

        searchRS.subscribe(onNext: {[weak self] arr in


            self?.vm.obPostDeatilArr.accept(arr)

             }, onError: nil, onCompleted: nil).disposed(by: dBag)

       
        
        
        

        //MARK: tbView refresh

        self.tbView.refreshControl = refreshControl
//
        let fresh = refreshControl.rx.controlEvent(.valueChanged)
            .flatMapLatest({ [unowned self] _ -> Observable<[PostDetail]> in
                //            return Observable.just([])

                if self.searchBar.text?.isEmpty ?? true == true {
                    
                    return self.vm.loadPostListBySearch(text: "all").catch({ _ in .just([])})
                }
                
                return self.vm.loadPostListBySearch(text: self.searchBar.text).catch({ _ in .just([])})
            })
            .observe(on: MainScheduler.instance)



        fresh.subscribe(onNext: { arr in

//            print("?????????",arr.count)

            self.vm.obPostDeatilArr.accept(arr)

            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.tbView.refreshControl?.endRefreshing()
            })

        }, onError: { arr in
//            print("fresch??? err")

        }
        ,onCompleted: {
//            print("fresch??? completed")

        }).disposed(by: dBag)

        
        
       
        
        
        
        //MARK: errMsg
        
        _ = self.vm.obErrMsg.observe(on: MainScheduler.instance).subscribe(onNext: {[weak self] err in
            
            guard err != nil else {return}
            
            self?.showAlert(title: "Error??????", errMsg: err?.localizedDescription ?? "")
        }).disposed(by: dBag)
        
       
        
        //MARK: Download state
        _ = self.vm.isDownloadingSuccess.observe(on: MainScheduler.instance).subscribe(onNext: {[weak self] isOk in
//            self?.debugPrint("????????? isDownloadingSuccess:",isOk)

            if isOk{
            self?.showBanner(msg: "Image saved", type: .success)
            }else {
                self?.showBanner(msg: "Save failed", type: .failed)
            }
        }, onError: { [weak self] err in
            self?.vm.obErrMsg.accept(err)

        }).disposed(by: dBag)
        
        
        
        
       
        
        //MARK: LoadingView
        _ = self.vm.isLoading.observe(on: MainScheduler.instance).subscribe(onNext: {[weak self] isLoading in

//            self?.debugPrint("????????? isLoading:",isLoading)

            guard isLoading else {
                self?.hideLoadingView()
                return}

            self?.showLoadingView()
        }, onError: nil, onCompleted: nil).disposed(by: dBag)
        
        
    }
    
    func testUI(){
//        self.searchBar.backgroundColor = .red
//        self.tbView.backgroundColor = .white
    }
}

extension PostVC{
    
    private func setupSearchBar(){
        searchBar.delegate = self
        self.view.addSubview(searchBar)
        searchBar.snp.makeConstraints({
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(70)
            $0.leading.trailing.equalToSuperview().inset(10)
        })
        
    }
    
    private func setupTbView(){
        self.tbView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.cellID)
//        self.tbView.register(PostTbCell.self, forCellReuseIdentifier: PostTbCell.cellID)
        self.tbView.register(PostWithThumbnailTbCell.self, forCellReuseIdentifier: PostWithThumbnailTbCell.cellID)

        
        self.view.addSubview(tbView)
        tbView.snp.makeConstraints({
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
        })
        
        
    }
}

extension PostVC {
    
    private func configCell(tablieView:UITableView, row:Int, post:PostDetail ) -> UITableViewCell{
//        let cell = tablieView.dequeueReusableCell(withIdentifier: PostTbCell.cellID) as! PostTbCell
        let cell = tablieView.dequeueReusableCell(withIdentifier: PostWithThumbnailTbCell.cellID) as! PostWithThumbnailTbCell

        
        cell.cellVM = PostCellVM(obj: post)
        //MARK:btnURL tapped
        cell.btnURL.rx.tap.subscribe(onNext: {[weak self] in
//            print("??????link:",cell.cellVM?.urlLink?.absoluteString)
            self?.openWebView(url: cell.cellVM?.urlLink)
        }).disposed(by: cell.dBag)
        
        //MARK: img LongPress
        cell.imgViewThumbnail.rx.longPressGesture(configuration: nil).when(.began).subscribe(onNext: { [weak self] gesture in
            
            self?.debugPrint("?????????")
            self?.showDownloadAlert(url: cell.cellVM?.imgThumbnailURL)
        }).disposed(by: cell.dBag)

        
        //MARK: Btn download
        cell.btnDownload.rx.tap.subscribe(onNext: { [weak self] gesture in
            
            self?.debugPrint("?????????")
            self?.showDownloadAlert(url: cell.cellVM?.imgThumbnailURL)
        }).disposed(by: cell.dBag)
        
        return cell
    }
}

extension PostVC{
    
    private func openWebView(url:URL?){

            self.coordinator?.runWebViewFlow(url: url)


    }
    
    private func showDownloadAlert(url:URL?){
        
        debugPrint("alert save")
        let act = UIAlertController(title: "Download to local?", message: nil, preferredStyle: .actionSheet)
        
        let save = UIAlertAction(title: "Download", style: .default, handler: { [weak self] _ in
            
            self?.vm.downloadImg(url: url)
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in
            
//            self.showBanner(msg: "Failed", type: .failed)
            
        })
     
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

//extension PostVC{
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
////        debugPrint("????????????")
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//        let frameHeight = scrollView.frame.size.height
//
//        if offsetY >= 0 && offsetY > contentHeight - frameHeight {
//
////            guard self.vm.isLoading.value == false  else {
//////                print("?????????")
////                return
////            }
//
////            debugPrint("?????????")
//
//
//        }
//
//    }
//
//}

extension PostVC: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        print("????????????")
        self.stopEditingMode()
    }
    
}
