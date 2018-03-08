//
//  CardCollectionViewCell.swift
//  ProyectoiOS
//
//  Created by Jose Medina Ruiz on 8/3/18.
//  Copyright © 2018 Jose Medina Ruiz. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lProducto: UILabel!
    @IBOutlet weak var lCantidad: UILabel!
    
    var indexPath: IndexPath?
    var callBack: callBackCarro?
    
    @IBAction func buttonSumar(_ sender: Any) {
        self.callBack?.mas(indexPath: self.indexPath!)
    }
    @IBAction func buttonRestar(_ sender: Any) {
        self.callBack?.menos(indexPath: self.indexPath!)
    }
}
