//
//  Ticket.swift
//  ProyectoiOS
//
//  Created by jjMac on 6/3/18.
//  Copyright © 2018 Jose Medina Ruiz. All rights reserved.
//

import Foundation

class Ticket{
    
    var id : String
    var date : String
    var idmember : String
    var idclient : String
    
    init(id: String, idmember: String, idcliente: String) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy' 'HH:mm"
        let result = formatter.string(from: date)
        
        self.id = id
        self.date = result
        self.idmember = idmember
        self.idclient = idcliente
    }
}
