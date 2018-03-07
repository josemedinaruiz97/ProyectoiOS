//
//  TicketCell2.swift
//  ProyectoiOS
//
//  Created by jjMac on 7/3/18.
//  Copyright © 2018 Jose Medina Ruiz. All rights reserved.
//

import UIKit

class TicketCell2: UICollectionViewCell {
    
    @IBOutlet weak var labelId: UILabel!
    @IBOutlet weak var labelSeller: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    var indexPath: IndexPath?
    var callBack: callBackTicket?
    
    
    @IBAction func buttonTicket(_ sender: Any) {
        self.callBack?.passIdTicket(indexPath: self.indexPath!)
    }
}
