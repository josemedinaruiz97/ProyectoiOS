//
//  Producto.swift
//  ProyectoiOS
//
//  Created by Jose Medina Ruiz on 3/3/18.
//  Copyright © 2018 Jose Medina Ruiz. All rights reserved.
//

import Foundation
struct Producto: Codable {
    var description:String
    var id:String
    var idfamily:String
    var price:String
    var product:String

}
struct Familia: Codable {
    var id:String
    var family:String
    
}
struct Tickets: Codable {
    var id:String
    var date:String
    var idmember:String
    var idclient:String
    init(id: String,date: String,idmember: String,idcliente: String) {
        self.id = id
        self.date=date
        self.idmember=idmember
        self.idclient=idcliente
    }
    
}
struct TicketsDetail {
    var id : String
    var idticket : String
    var idproduct : String
    var quantity : String
    var price : String
    
    init(id: String, idticket: String, idproduct: String, quantity: String, price: String) {
        
        self.id = id
        self.idticket = idticket
        self.idproduct = idproduct
        self.quantity = quantity
        self.price = price
        
    }
}
