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
struct Ticket: Codable {
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
