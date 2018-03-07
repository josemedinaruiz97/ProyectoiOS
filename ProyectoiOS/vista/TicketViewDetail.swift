//
//  TicketViewDetail.swift
//  ProyectoiOS
//
//  Created by jjMac on 7/3/18.
//  Copyright © 2018 Jose Medina Ruiz. All rights reserved.
//

import UIKit

class TicketViewDetail: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var id: String?
    var arrayDetailTicket: [TicketDetail]?
    var aux: [TicketDetail] = []
    var arrayProductos: [Producto]?

    override func viewDidLoad() {
        super.viewDidLoad()

        for value in arrayDetailTicket! {
            if(value.idticket == self.id!) {
                aux.append(value)
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
        return self.aux.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : DetailCell =  collectionView.dequeueReusableCell(withReuseIdentifier: "detailCell", for: indexPath) as! DetailCell
        
        let idproduct = self.aux[indexPath.row].idproduct
        
        var nameproduct : String?
        for value in arrayProductos! {
            if(value.id == self.aux[indexPath.row].idproduct){
                nameproduct = value.product
            }
        }
        
        cell.labelIdProduct.text = idproduct
        cell.labelName.text = nameproduct
        cell.labelCantidad.text = "C: " + self.aux[indexPath.row].quantity
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
