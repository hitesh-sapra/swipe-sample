//
//  ProductCell.swift
//  SwipeSample
//
//  Created by Code Optimal Solutions Ios on 24/08/23.
//

import UIKit
import SDWebImage
class ProductCell: UITableViewCell {
    //Cell Identifier
    static var identifier = "ProductCell"
    
    //UI Component Connections
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var taxLbl: UILabel!
    @IBOutlet weak var productTypeLbl: UILabel!
    @IBOutlet weak var productNameLBL: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var customBackgroundView:UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellConfiguration()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateCell(data:ProductDataModel){
        if let url = URL(string: data.image){
            productImageView.sd_setImage(with: url,placeholderImage: UIImage(named: "plc_product"))
        }else{
            productImageView.image = UIImage(named: "plc_product")
        }
        priceLbl.text = "\(data.price)/-"
        taxLbl.text = "Tax: \(data.tax)%"
        productNameLBL.text = data.productName
        productTypeLbl.text = data.productType
        
    }
    
    
    
    /// Initial cell configuration and designing
    func cellConfiguration(){
        selectionStyle = .none
        customBackgroundView.layer.cornerRadius = 7
        customBackgroundView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        customBackgroundView.layer.borderWidth = 1
    }
    
}
