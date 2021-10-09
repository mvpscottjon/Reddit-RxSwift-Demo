//
//  PostTbCell.swift
//  Reddit-RxSwiftDemo
//
//  Created by Seven on 2021/10/9.
//

import UIKit
import Kingfisher
import RxSwift
class PostTbCell: UITableViewCell {

    
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
        imgView.isUserInteractionEnabled = true
        return imgView
    }()
    var btnURL:UIButton = {
        let btn = UIButton()
        btn.setTitleColor(.blue, for: .normal)
        btn.contentHorizontalAlignment = .leading
        btn.titleLabel?.textAlignment = .left
        
        return btn
    }()
    
    
    var cellVM:PostCellVM?{
        didSet{
            self.updateCell()
            
        }
    }
    
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
        
        self.imgViewUserPhoto.layer.cornerRadius = self.imgViewUserPhoto.frame.width / 2
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        dBag = DisposeBag()
    }
}

extension PostTbCell {
    
    private func setupCell(){
        
        let cellInset : CGFloat = 20
        
        //MARK:Title
        let userSubView = UIView()
        self.contentView.addSubview(userSubView)
        userSubView.snp.makeConstraints({
            $0.top.leading.trailing.equalToSuperview().inset(cellInset)
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
        
        
 
        //MARK:lbTitle
        self.contentView.addSubview(lbTitle)
        lbTitle.snp.makeConstraints({
            $0.top.equalTo(userSubView.snp.bottom).offset(cellInset)
            $0.leading.trailing.equalToSuperview().inset(cellInset)
        })
        
        
       //MARK:Link
    
        self.contentView.addSubview(btnURL)
        btnURL.snp.makeConstraints({
            $0.top.equalTo(lbTitle.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(lbTitle)
        })
        
        
       
        self.contentView.addSubview(imgViewThumbnail)
        imgViewThumbnail.snp.makeConstraints({
            $0.top.equalTo(btnURL.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0)
            $0.bottom.equalToSuperview().inset(cellInset)
        })
        
        
        
    }
    
}

extension PostTbCell {

    private func updateCell(){
        self.lbUserName.text = self.cellVM?.userName
        self.lbDesciption.text = self.cellVM?.userDetail
        self.lbTitle.text = self.cellVM?.title
//        self.btnURL.setTitle(self.cellVM?.urlLink?.absoluteString ?? "", for: .normal)
        self.btnURL.setAttributedTitle(self.cellVM?.urlLinkAttrString, for: .normal)

        
       
        self.imgViewUserPhoto.kf.setImage(with: self.cellVM?.userPhotoURL)
        
        
//        if let h = self.cellVM?.imgThumbnilHeight{
//            self.imgViewThumbnail.snp.updateConstraints({
//                $0.height.equalTo(h)
//            })
//        }
        
//        self.imgViewThumbnail.kf.setImage(with: self.cellVM?.imgThumbnilURL,completionHandler: { rs in
//
////            print("照片讀取回來哦",self.cellVM?.imgThumbnilURL)
//            switch rs{
//            case .success(_):
////                print("成功","先看長寬",self.cellVM?.imgThumbnilHeight)
//                break
//            case .failure(_):
////                print("失敗")
//                self.imgViewThumbnail.snp.updateConstraints({
//                    $0.height.equalTo(0)
//                })
//            }
//
//
//        })
        
    }

}
