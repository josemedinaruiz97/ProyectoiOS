//
//  Ticket.swift
//  ProyectoiOS
//
//  Created by jjMac on 6/3/18.
//  Copyright © 2018 Jose Medina Ruiz. All rights reserved.
//

import Foundation

class Ticket: Codable{
    
    var id : String
    var date : String
    var idmember : String
    
    init(id: String, idmember: String, date:String ) {
        self.id = id
        self.date = date
        self.idmember = idmember
    }
    convenience init(id: String, idmember: String) {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy' 'HH:mm"
        let result = formatter.string(from: date)
        self.init(id: id,idmember: idmember,date: result)
    }
}
