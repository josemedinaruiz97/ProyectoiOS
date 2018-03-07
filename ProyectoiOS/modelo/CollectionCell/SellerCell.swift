//
//  SellerCell.swift
//  ProyectoiOS
//
//  Created by jjMac on 7/3/18.
//  Copyright © 2018 Jose Medina Ruiz. All rights reserved.
//

import UIKit

class SellerCell: UICollectionViewCell {
    
    @IBOutlet weak var labelSeller: UILabel!
    
    var callBack : callBackTicket?
    var indexPath : IndexPath?
    var idSeller : String?
    
    @IBAction func buttonSeller(_ sender: Any) {
        self.callBack?.passIdTicket(indexPath: self.indexPath!)
    }
    
}
