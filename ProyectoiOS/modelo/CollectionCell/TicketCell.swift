//
//  TicketCell.swift
//  ProyectoiOS
//
//  Created by jjMac on 6/3/18.
//  Copyright © 2018 Jose Medina Ruiz. All rights reserved.
//

import UIKit

class TicketCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var labelTicketCell: UILabel!
    @IBOutlet weak var labelDateCell: UILabel!
    @IBOutlet weak var labelId: UILabel!
    var callBack : callBackTicket?
    var indexPath : IndexPath?
    
    @IBAction func buttonTicket(_ sender: Any) {
        self.callBack?.passIdTicket(indexPath: self.indexPath!)
    }
}
