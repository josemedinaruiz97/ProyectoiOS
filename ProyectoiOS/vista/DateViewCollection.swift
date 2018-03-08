//
//  DateViewCollection.swift
//  ProyectoiOS
//
//  Created by jjMac on 7/3/18.
//  Copyright © 2018 Jose Medina Ruiz. All rights reserved.
//

import UIKit

class DateViewCollection: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, callBackTicket {
    
    @IBOutlet weak var dateCollection: UICollectionView!
    
    var arrayTicket: [Ticket]?
    var arrayProductos: [Producto]?
    var arrayDetailTicket: [TicketDetail]?
    var aux: [Ticket]? = []
    var seletedDate: String?
    var id: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        for value in arrayTicket! {
            var fecha = value.date
            let range = fecha.index(fecha.endIndex, offsetBy: -9)..<fecha.endIndex
            fecha.removeSubrange(range)
            if(fecha == seletedDate!){
                aux!.append(value)
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
        return self.aux!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : TicketCell3 =  dateCollection.dequeueReusableCell(withReuseIdentifier: "dateTicketCell", for: indexPath) as! TicketCell3
        
        let seller = self.aux![indexPath.row].idmember
        
        cell.indexPath = indexPath
        
        cell.callBack = self
        
        let isoDate = self.aux![indexPath.row].date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: isoDate)!
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let result = dateFormatter.string(from: date)
        
        cell.labelSeller.text = seller
        cell.labelDate.text = result
        cell.labelId.text = self.aux![indexPath.row].id
        
        return cell
    }
    
    func passIdTicket(indexPath: IndexPath) {
        let cell : TicketCell3 = dateCollection!.cellForItem(at: indexPath) as! TicketCell3
        self.id = cell.labelId.text
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch (segue.identifier ?? "") {
        case "sinceDate":
            guard let destino = segue.destination as? TicketViewDetail else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            destino.arrayDetailTicket = self.arrayDetailTicket
            destino.id = self.id
            destino.arrayProductos = self.arrayProductos
        default:
            fatalError("Unexpected destination: \(segue.destination)")
        }
    }
    
}
