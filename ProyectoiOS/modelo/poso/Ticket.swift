//
//  Ticket.swift
//  ProyectoiOS
//
//  Created by jjMac on 6/3/18.
//  Copyright © 2018 Jose Medina Ruiz. All rights reserved.
//

import Foundation

class Ticket{
    var seller : String?
    var basket : [CardBakery]?
    var date : String?
    
    init(){
        
    }
    
    init(seller: String, basket: [CardBakery]){
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        
        self.seller = seller
        self.basket = basket
        self.date = result
    }
}
