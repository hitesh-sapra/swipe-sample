//
//  ImageCell.swift
//  SwipeSample
//
//  Created by Code Optimal Solutions Ios on 25/08/23.
//

import UIKit

class ImageCell: UICollectionViewCell {
    static var identifier = "ImageCell"
    @IBOutlet weak var checkMark: UIImageView!
    @IBOutlet weak var galleryImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        checkMark.isHidden = true
        // Initialization code
    }
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        checkMark.isHidden = true
//    }
    func cellSelected(){
        checkMark.isHidden = false
    }
    func cellUnSelected(){
        checkMark.isHidden = true
    }
}
