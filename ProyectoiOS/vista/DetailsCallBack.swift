//
//  DetailsCallBack.swift
//  PruebaAutolayout
//
//  Created by dam on 1/3/18.
//  Copyright © 2018 Francisco García Molina. All rights reserved.
//

import Foundation

protocol callBack {
    func productDetails(indexPath : IndexPath)
}

protocol callBackTicket {
    func passIdTicket(indexPath : IndexPath)
}

protocol callBackCarro {
    func mas(indexPath: IndexPath)
    func menos(indexPath: IndexPath)
}
