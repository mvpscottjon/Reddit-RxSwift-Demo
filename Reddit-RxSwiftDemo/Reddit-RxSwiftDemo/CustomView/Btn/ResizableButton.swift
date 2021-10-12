//
//  ResizableButton.swift
//  Reddit-RxSwiftDemo
//
//  Created by Seven on 2021/10/10.
//

import UIKit

class ResizableButton: UIButton {

    
    override func layoutSubviews() {
        titleLabel?.preferredMaxLayoutWidth = frame.size.width
        super.layoutSubviews()
        
      
    }
  
    override var intrinsicContentSize:CGSize {

        let labelSize = titleLabel?.sizeThatFits(CGSize(width: self.titleLabel?.preferredMaxLayoutWidth ?? frame.width, height: CGFloat.greatestFiniteMagnitude)) ?? .zero
               let desiredButtonSize = CGSize(width: labelSize.width + titleEdgeInsets.left + titleEdgeInsets.right, height: labelSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom)
               
               return desiredButtonSize
    }

    
    
}
extension ResizableButton{
    
    
}
