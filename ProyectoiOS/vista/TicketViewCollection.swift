//
//  TicketViewCollection.swift
//  ProyectoiOS
//
//  Created by jjMac on 6/3/18.
//  Copyright © 2018 Jose Medina Ruiz. All rights reserved.
//

import UIKit

class TicketViewCollection: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, callBackTicket {
    
    @IBOutlet weak var collectionTicket: UICollectionView!
    
    var arrayTicket: [Ticket]?
    var arrayDetailTicket: [TicketDetail]?
    var arrayProductos: [Producto]?
    var id: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return (self.arrayTicket?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : TicketCell =  collectionView.dequeueReusableCell(withReuseIdentifier: "ticketCell", for: indexPath) as! TicketCell
        
        let seller = self.arrayTicket![indexPath.row].idmember
        
        cell.indexPath = indexPath
        
        cell.callBack = self
        
        let isoDate = self.arrayTicket![indexPath.row].date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: isoDate)!
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let result = dateFormatter.string(from: date)
        
        cell.labelTicketCell.text = seller
        cell.labelDateCell.text = result
        cell.labelId.text = self.arrayTicket![indexPath.row].id
        
        return cell
    }

    func passIdTicket(indexPath: IndexPath) {
        let cell : TicketCell = collectionTicket!.cellForItem(at: indexPath) as! TicketCell
        self.id = cell.labelId.text
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch (segue.identifier ?? "") {
        case "detailTicketView":
            guard let viewCellContent = segue.destination as? TicketViewDetail else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            viewCellContent.arrayDetailTicket = self.arrayDetailTicket
            viewCellContent.id = self.id
            viewCellContent.arrayProductos = self.arrayProductos
        case "sellerView":
            guard let destino = segue.destination as? SellerViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            destino.arrayTicket = self.arrayTicket
            destino.arrayDetailTicket = self.arrayDetailTicket
            destino.arrayProductos = self.arrayProductos
        case "dateView": break
        default:
            fatalError("Unexpected destination: \(segue.destination)")
        }
    }
    
}
