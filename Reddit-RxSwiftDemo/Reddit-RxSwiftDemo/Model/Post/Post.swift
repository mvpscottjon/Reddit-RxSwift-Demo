//
//  Post.swift
//  Reddit-RxSwiftDemo
//
//  Created by Seven on 2021/10/9.
//

import UIKit

struct PostListModel :Codable{

    let kind:String?
    let data:PostData?
    
}

struct PostData:Codable{
    let after:String?
    let dist:Int?
    let modhash:String?
    let geo_filter:String?
    let children:[PostDetail]?
    let before:String?
    
    
}

struct PostDetail:Codable {
    let kind:String?
    let data:PostDetailData
    
    
}

struct PostDetailData:Codable{
    let id:String?
    let title:String?
    //name
    let name:String?
    let display_name:String?
    let subreddit_name_prefixed:String?
    
    
    //userDetail
    let author:String?
    let created:Double?
    let domain:String?
    
    let icon_img:String?
    let description_html:String?
    let public_description_html:String?
    let description:String?
    let url:String?
    //    let banner_background_image:String?
    //    let banner_img:String?
//    let mobile_banner_image:String?
//    let banner_size:[Int]?
    let community_icon: String?
    let thumbnail:String?
    let thumbnail_height:Int?
    let thumbnail_width:Int?
    let url_overridden_by_des:String?
}

