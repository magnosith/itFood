//
//  CategoryTableViewCell.swift
//  itFood
//
//  Created by Student on 30/06/23.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleCategory: UILabel!
    @IBOutlet weak var imageCategory: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup (category: String){
        titleCategory.text = category
    }
}
