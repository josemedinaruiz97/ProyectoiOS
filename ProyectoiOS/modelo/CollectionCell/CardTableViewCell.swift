//
//  CardTableViewCell.swift
//  ProyectoiOS
//
//  Created by dam on 6/3/18.
//  Copyright © 2018 Jose Medina Ruiz. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var cardProductTable: UILabel!
    @IBOutlet weak var cardProductAmount: UILabel!
    @IBOutlet weak var cardProductStepper: UIStepper!
    @IBOutlet weak var cardProductTotal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var callBackCard: callBackCard? = nil
    
    var indexPath: IndexPath!
    var amount: Int!
    var price: Double!
    
    @IBAction func stepperProductAmount(_ sender: UIStepper) {
        amount = Int(sender.value)
        
        cardProductAmount.text = String(amount)
        
        callBackCard?.addAmount(indexPath: indexPath, amount: amount)
    }
}
