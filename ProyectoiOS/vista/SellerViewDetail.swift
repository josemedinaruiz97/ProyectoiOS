//
//  SellerViewDetail.swift
//  ProyectoiOS
//
//  Created by jjMac on 7/3/18.
//  Copyright © 2018 Jose Medina Ruiz. All rights reserved.
//

import UIKit

class SellerViewDetail: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, callBackTicket {

    
    @IBOutlet weak var sellerTicketCollection: UICollectionView!
    
    var arrayTicket: [Ticket]?
    var arrayDetailTicket: [TicketDetail]?
    var arrayProductos: [Producto]?
    var aux: [Ticket]? = []
    var id : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        for value in arrayTicket! {
            if(value.idmember == id!){
                aux?.append(value)
            }
        }
        
        print(aux!)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.aux?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : TicketCell2 =  sellerTicketCollection.dequeueReusableCell(withReuseIdentifier: "cellTicket", for: indexPath) as! TicketCell2
        
        cell.indexPath = indexPath
        
        cell.callBack = self
        
        let isoDate = self.aux![indexPath.row].date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: isoDate)!
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let result = dateFormatter.string(from: date)
        
        cell.labelSeller.text = self.aux![indexPath.row].idmember
        cell.labelId.text = self.aux![indexPath.row].id
        cell.labelDate.text = result
        
        return cell
    }
    
    func passIdTicket(indexPath: IndexPath) {
        let cell : TicketCell = sellerTicketCollection!.cellForItem(at: indexPath) as! TicketCell
        self.id = cell.labelId.text
    }

    // MARK: - Navigation


}
