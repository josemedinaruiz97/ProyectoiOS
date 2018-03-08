//
//  TicketDetail.swift
//  ProyectoiOS
//
//  Created by jjMac on 7/3/18.
//  Copyright © 2018 Jose Medina Ruiz. All rights reserved.
//

import Foundation

class TicketDetail:Codable{
    
    var id: String
    var idticket: String
    var idproduct: String
    var quantity: String
    var price: String
    
    init(id: String, idticket: String, idproduct: String, quantity: String, price: String) {
        
        self.id = id
        self.idticket = idticket
        self.idproduct = idproduct
        self.quantity = quantity
        self.price = price
        
    }
}
