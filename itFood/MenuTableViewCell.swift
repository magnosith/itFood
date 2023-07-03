//
//  MenuTableViewCell.swift
//  itFood
//
//  Created by Student on 30/06/23.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleFood: UILabel!
    @IBOutlet weak var imageFood: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup (menuItems: MenuItem){
        titleFood.text = menuItems.name
    }
    
}
