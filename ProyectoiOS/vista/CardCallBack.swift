//
//  CardCallBack.swift
//  ProyectoiOS
//
//  Created by dam on 7/3/18.
//  Copyright © 2018 Jose Medina Ruiz. All rights reserved.
//

import Foundation

protocol callBackCard {
    func addAmount(indexPath: IndexPath, amount : Int)
    func delAmount(id: Int, idCell : IndexPath)
}
