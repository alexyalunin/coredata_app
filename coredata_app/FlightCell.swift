//
//  FlightCell.swift
//  coredata_app
//
//  Created by Alexander on 15.12.2019.
//  Copyright © 2019 Мария Коровина. All rights reserved.
//

import UIKit

class FlightCell: UITableViewCell {

    @IBOutlet weak var fromView: UIView!
    @IBOutlet weak var fromCountry: UILabel!
    @IBOutlet weak var fromDate: UILabel!
    @IBOutlet weak var toView: UIView!
    @IBOutlet weak var toCountry: UILabel!
    @IBOutlet weak var toDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        fromView.layer.cornerRadius = 10
        toView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
