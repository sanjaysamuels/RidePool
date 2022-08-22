//
//  RPCustomTableViewCell.swift
//  CapStoneProject_RideShare
//
//  Created by Sanjay Sekar Samuel on 2022-08-04.
//

import UIKit

class RPCustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet var toFrom: UILabel!
    @IBOutlet var time: UILabel!
    //@IBOutlet var toFrom: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
