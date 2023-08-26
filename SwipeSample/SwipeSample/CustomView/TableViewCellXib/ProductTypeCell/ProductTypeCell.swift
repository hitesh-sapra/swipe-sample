//
//  ProductTypeCell.swift
//  SwipeSample
//
//  Created by Code Optimal Solutions Ios on 25/08/23.
//

import UIKit

class ProductTypeCell: UITableViewCell {
    static var identifier = "ProductTypeCell"
    @IBOutlet weak var checkmark: UIImageView!
    @IBOutlet weak var typeNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
