//
//  CardCollectionViewController.swift
//  ProyectoiOS
//
//  Created by Jose Medina Ruiz on 8/3/18.
//  Copyright © 2018 Jose Medina Ruiz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CardCollectionViewController: UICollectionViewController, OnHttpResponse{
    func onDataReceived(data: Data) {
        guard let respuesta:Dictionary=RestJsonUtil.jsonToDict(data: data) else {
            return
        }
        print(respuesta)
        print("llego")
        if(respuesta["ok"] as! Bool){
            print("pasa")
            token=respuesta["token"] as! String
            arrayTicket=try!JSONDecoder().decode([Ticket].self, from:try! JSONSerialization.data(withJSONObject: respuesta["op"] ?? ""))
            arrayDetailTicket=try!JSONDecoder().decode([TicketDetail].self, from:try! JSONSerialization.data(withJSONObject: respuesta["op1"] ?? ""))
            print(arrayDetailTicket)
            print("pasa")
            cardArray=Array()
            performSegue(withIdentifier: "segueReturn", sender:self)
            
            
        }else{
            print(token)
            guard let cliente = ClienteHttp(target: "product", authorization: "Basic " + usuarioYContraseña, responseObject: self,"POST",cardArray) else {
                return
            }
            cliente.request()
        }
    }
    
    func onErrorReceivingData(message: String) {
        
    }
    
    var cardArray:[CardBakery]!
    var arrayProductos:[Producto]!
    var arrayFamilias:[Familia]!
    var arrayTicket : [Ticket]!
    var arrayDetailTicket : [TicketDetail]!
    var token:String!
    var usuarioYContraseña: String!
    
    @IBAction func btnConfirmar(_ sender: UIBarButtonItem) {
        guard let cliente = ClienteHttp(target: "product", authorization: "Bearer " + self.token, responseObject: self,"POST",cardArray) else {
            return
        }
        cliente.request()
    }
    
    @IBAction func btnCancelar(_ sender: UIBarButtonItem) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.cardArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : CardCollectionViewCell =  collectionView.dequeueReusableCell(withReuseIdentifier: "cardViewCell", for: indexPath) as! CardCollectionViewCell
        let product:CardBakery=cardArray![indexPath.row]
        cell.lProducto.text=product.name
        cell.lCantidad.text=String(describing: product.amount!)
        
        // Configure the cell
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let des = segue.destination as? UINavigationController
        let destino = des?.viewControllers.first as? SegmentedController
        destino!.cardArray=self.cardArray
        destino!.arrayProductos=self.arrayProductos
        destino!.arrayFamilias=self.arrayFamilias
        destino!.arrayTicket=self.arrayTicket
        destino!.arrayDetailTicket=self.arrayDetailTicket
        destino!.token=self.token
        destino!.usuarioYContraseña=self.usuarioYContraseña
    }
}
