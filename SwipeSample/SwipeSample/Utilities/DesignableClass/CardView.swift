//
//  CardView.swift
//  SwipeSample
//
//  Created by Code Optimal Solutions Ios on 25/08/23.
//

import Foundation
import UIKit
class CornerRadiusView:UIView{

    @IBInspectable var cornerRadius:CGFloat = 0
    @IBInspectable var borderColor:UIColor? = UIColor.lightGray
    @IBInspectable var borderWidth:CGFloat = 0
    

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor?.cgColor
        self.layer.borderWidth = borderWidth
        let  shadow_path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        self.layer.shadowPath = shadow_path.cgPath
    }
}
