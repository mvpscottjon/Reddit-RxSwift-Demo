//
//  ResizableButton.swift
//  Reddit-RxSwiftDemo
//
//  Created by Seven on 2021/10/10.
//

import UIKit

class ResizableButton: UIButton {

    
    override func layoutSubviews() {
//        titleLabel?.preferredMaxLayoutWidth = frame.self.width
        super.layoutSubviews()
        
      
    }
  
    override var intrinsicContentSize:CGSize {

//        let imageViewWidth = imageView?.frame.width ?? 0.0
//        let labelSize = titleLabel?.sizeThatFits(CGSize(width: frame.width, height: .greatestFiniteMagnitude)) ?? .zero
//        let desiredButtonSize = CGSize(width: labelSize.width + titleEdgeInsets.left + titleEdgeInsets.right + imageViewWidth, height: labelSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom)
//
//        return desiredButtonSize
//        let intrinsicContentSize = super.intrinsicContentSize
//
//        let adjustedWidth = intrinsicContentSize.width + 10
//        let adjustedHeight = intrinsicContentSize.height + 10
//
//        return CGSize(width: adjustedWidth, height: adjustedHeight)
        let labelSize = titleLabel?.sizeThatFits(CGSize(width: frame.size.width, height: CGFloat.greatestFiniteMagnitude)) ?? .zero
               let desiredButtonSize = CGSize(width: labelSize.width + titleEdgeInsets.left + titleEdgeInsets.right, height: labelSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom)
               
               return desiredButtonSize
    }

    
    
}
extension ResizableButton{
    
    
}
