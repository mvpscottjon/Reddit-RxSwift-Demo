//
//  PostWithThumbnailTbCell.swift
//  Reddit-RxSwiftDemo
//
//  Created by Seven on 2021/10/11.
//

import UIKit
import Kingfisher
import RxSwift


class PostWithThumbnailTbCell: UITableViewCell {
    
    
    var lbTitle:UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        
        lb.font = UIFont.boldSystemFont(ofSize: 16)
        lb.textColor = .black
        return lb
    }()
    
    //    var lbSubtitle:UILabel = {
    //        let lb = UILabel()
    //        lb.font = UIFont.systemFont(ofSize: 12)
    //        lb.textColor = .lightGray
    //        return lb
    //    }()
    
    var lbUserName:UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 12)
        return lb
    }()
    
    var lbDesciption:UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 12)
        lb.textColor = .lightGray
        return lb
    }()
    var imgViewUserPhoto:UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.backgroundColor = .thumbnail
        imgView.layer.masksToBounds = true
        imgView.clipsToBounds = true
        return imgView
        
    }()
    var imgViewThumbnail:UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.layer.masksToBounds = true
        imgView.isUserInteractionEnabled = true
        imgView.backgroundColor = .yellow
        return imgView
    }()
    var btnURL:UIButton = {
        let btn = UIButton()
        
        btn.setTitleColor(.blue, for: .normal)
        btn.contentHorizontalAlignment = .leading
        btn.titleLabel?.textAlignment = .left
        //        btn.titleLabel?.numberOfLines = 0
        //        btn.backgroundColor = .yellow
        //        btn.titleLabel?.lineBreakMode = .byWordWrapping
        return btn
    }()
    var btnDownload:UIButton = {
        let btn = UIButton()
        btn.tintColor = .mainColor
        btn.setTitleColor(.blue, for: .normal)
        btn.contentHorizontalAlignment = .center
        btn.titleLabel?.textAlignment = .center
        btn.setImage(UIImage(systemName: "arrow.down.circle.fill"), for: .normal)
//        btn.backgroundColor = .red
        return btn
    }()
    
    var cellVM:PostCellVM?{
        didSet{
            self.updateCell()
            
        }
    }
    
   private let cellInset : CGFloat = 20
    private let thumbnailSize = CGSize(width: 40 * 2.5, height: 30 * 2.5)
    private let btnSize = CGSize(width: 40, height: 40)

    var dBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            self.imgViewUserPhoto.layer.cornerRadius = self.imgViewUserPhoto.frame.width / 2
            
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        dBag = DisposeBag()
        self.imgViewThumbnail.image  = nil
        self.imgViewUserPhoto.image = nil
        self.lbTitle.text = nil
        self.lbDesciption.text = nil
        self.lbUserName.text = nil
    }
}

extension PostWithThumbnailTbCell {
    
    private func setupCell(){
        
        self.selectionStyle = .none
        

        
        self.contentView.addSubview(imgViewThumbnail)
        imgViewThumbnail.snp.makeConstraints({
            $0.top.trailing.equalToSuperview().inset(cellInset)
            $0.size.equalTo(thumbnailSize)
      
        })
        self.contentView.addSubview(btnDownload)
        btnDownload.snp.makeConstraints({
            $0.top.equalTo(imgViewThumbnail.snp.bottom)
            $0.size.equalTo(btnSize)
            $0.centerX.equalTo(imgViewThumbnail)
        })
        
        
        //MARK:userSubView
        let userSubView = UIView()
        self.contentView.addSubview(userSubView)
        userSubView.snp.makeConstraints({
            $0.top.leading.equalToSuperview().inset(cellInset)
            $0.trailing.equalTo(imgViewThumbnail.snp.leading)
        })
        //MARK:imgUserPhoto

        userSubView.addSubview(imgViewUserPhoto)
        imgViewUserPhoto.snp.makeConstraints({
            $0.width.height.equalTo(30)
            $0.top.leading.equalToSuperview()
            $0.bottom.equalTo(userSubView)
        })
        //MARK:userName
        userSubView.addSubview(lbUserName)
        lbUserName.snp.makeConstraints({
            $0.top.equalTo(imgViewUserPhoto)
            $0.leading.equalTo(imgViewUserPhoto.snp.trailing).offset(5)
            $0.trailing.equalToSuperview().inset(10)
            $0.bottom.equalTo(imgViewUserPhoto.snp.centerY)
        })
        //MARK:userDetail
        userSubView.addSubview(lbDesciption)
        lbDesciption.snp.makeConstraints({
            $0.top.equalTo(imgViewUserPhoto.snp.centerY)
            $0.leading.equalTo(imgViewUserPhoto.snp.trailing).offset(5)
            $0.trailing.equalToSuperview().inset(10)
            $0.bottom.equalTo(imgViewUserPhoto)
        })



        let msgSubView = UIView()
        self.contentView.addSubview(msgSubView)
        msgSubView.snp.makeConstraints({
            $0.top.equalTo(userSubView.snp.bottom).offset(10)
            $0.leading.equalTo(userSubView)
            $0.trailing.equalTo(imgViewThumbnail.snp.leading)
            $0.bottom.equalToSuperview()
        })

        //MARK:lbTitle
        msgSubView.addSubview(lbTitle)
        lbTitle.snp.makeConstraints({
//            $0.top.equalTo(userSubView.snp.bottom).offset(cellInset)

//            $0.leading.trailing.equalToSuperview().inset(cellInset)
            $0.top.leading.trailing.equalToSuperview()
            $0.height.greaterThanOrEqualTo(40)
        })


        //MARK:Link

        msgSubView.addSubview(btnURL)
        btnURL.snp.makeConstraints({
            $0.top.equalTo(lbTitle.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(lbTitle)
            $0.bottom.equalToSuperview()
        })


        
      
        
        
    }
    
}

extension PostWithThumbnailTbCell {
    
    private func updateCell(){
        self.lbUserName.text = self.cellVM?.userName
        self.lbDesciption.text = self.cellVM?.userDetail
        self.lbTitle.text = self.cellVM?.title
        //        self.btnURL.setTitle(self.cellVM?.urlLink?.absoluteString ?? "", for: .normal)
        self.btnURL.setAttributedTitle(self.cellVM?.urlLinkAttrString, for: .normal)
        
        
        
        self.imgViewUserPhoto.kf.setImage(with: self.cellVM?.userPhotoURL)
        
        
        if  self.cellVM?.imgThumbnilHeight == nil{
//            print("thumb == nil")
            self.imgViewThumbnail.snp.updateConstraints({
                $0.height.width.equalTo(0)
            })
            
            self.btnDownload.snp.updateConstraints({
                $0.height.width.equalTo(0)
            })
            
        }else {
//            print("不是empty:",self.cellVM?.imgThumbnailURL)
            self.imgViewThumbnail.snp.updateConstraints({
                $0.size.equalTo(self.thumbnailSize)
            })
            
            self.btnDownload.snp.updateConstraints({
                $0.size.equalTo(btnSize)
            })
        }
        
        if self.cellVM?.imgThumbnail != nil {
            
//            print("是local img")
            DispatchQueue.main.async {
                self.imgViewThumbnail.image = self.cellVM?.imgThumbnail
                
            }
        }else{
//            print("是server img")
            self.imgViewThumbnail.kf.setImage(with: self.cellVM?.imgThumbnailURL,completionHandler: { rs in
                
                //            print("照片讀取回來哦",self.cellVM?.imgThumbnilURL)
                switch rs{
                case .success(_):
                    //                print("成功","先看長寬",self.cellVM?.imgThumbnilHeight)
                    break
                case .failure(_):
                    break
                    //                print("失敗")
//                    self.imgViewThumbnail.snp.updateConstraints({
//                        $0.height.equalTo(0)
//                    })
                }
                
                
            })
            
            
        }
        
    }
    
}
