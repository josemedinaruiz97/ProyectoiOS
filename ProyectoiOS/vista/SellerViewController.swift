//
//  SellerViewController.swift
//  ProyectoiOS
//
//  Created by jjMac on 7/3/18.
//  Copyright © 2018 Jose Medina Ruiz. All rights reserved.
//

import UIKit

class SellerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, callBackTicket {

    var arrayTicket: [Ticket]?
    var arrayDetailTicket: [TicketDetail]?
    var arrayProductos: [Producto]?
    var arraySeller: [String]? = []
    var id : String?
    
    @IBOutlet weak var sellerCollection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for value in arrayTicket! {
            let id = value.idmember
            var control: Bool = false
            for value2 in arraySeller! {
                if(value2 == id) {
                    control = true
                }
            }
            if(control == false){
                arraySeller!.append(id)
            }
        }
        
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
        return (self.arraySeller?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : SellerCell =  sellerCollection.dequeueReusableCell(withReuseIdentifier: "cellSeller", for: indexPath) as! SellerCell
        
        let seller = self.arraySeller![indexPath.row]
        
        cell.indexPath = indexPath
        
        cell.idSeller = seller
        
        cell.callBack = self
        
        cell.labelSeller.text = seller
        
        return cell
    }
    
    func passIdTicket(indexPath: IndexPath) {
        let cell : SellerCell = sellerCollection!.cellForItem(at: indexPath) as! SellerCell
        self.id = cell.idSeller
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch (segue.identifier ?? "") {
        case "sellerDetail":
            guard let destino = segue.destination as? SellerViewDetail else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            destino.arrayTicket = self.arrayTicket
            destino.arrayDetailTicket = self.arrayDetailTicket
            destino.id = self.id
            destino.arrayProductos = self.arrayProductos
        default:
            fatalError("Unexpected destination: \(segue.destination)")
        }
    }

}
