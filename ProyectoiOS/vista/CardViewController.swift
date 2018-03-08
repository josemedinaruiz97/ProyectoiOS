//
//  CardViewController.swift
//  ProyectoiOS
//
//  Created by Jose Medina Ruiz on 7/3/18.
//  Copyright © 2018 Jose Medina Ruiz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CardViewController: UICollectionViewController, OnHttpResponse{
    
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
            performSegue(withIdentifier: "segueReturnCard", sender:self)
            
            
        }else{
            var array:String="["
            for card in cardArray {
                var name=card.name!
                var category=card.category!
                var price=card.price!
                var amount=card.amount!
                array+="{\"name\":\"\(name)\",\"category\":\"\(category)\",\"price\":\"\(price)\",\"amount\":\"\(amount)\"},"
            }
            let endIndex = array.index(array.endIndex, offsetBy: -1)
            array = array.substring(to: endIndex)
            array+="]"
            print(array)
            let lenguajes: [String: Any] = ["op":array]
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
        var array:String="["
        for card in cardArray {
            var name=card.name!
            var category=card.category!
            var price=card.price!
            var amount=card.amount!
            array+="{name:\(name),category:\(category),price:\(price),amount:\(amount)},"
        }
        let endIndex = array.index(array.endIndex, offsetBy: -1)
        array = array.substring(to: endIndex)
        array+="]"
        let lenguajes: [String: Any] = ["op":array]
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

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
        let cell : CardCell =  collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardCell
        let product:CardBakery=cardArray![indexPath.row]
        cell.lProducto.text=product.name
        cell.lCantidad.text=String(describing: product.amount!)
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
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
