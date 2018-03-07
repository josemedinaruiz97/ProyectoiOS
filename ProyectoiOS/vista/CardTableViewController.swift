//
//  CardTableViewController.swift
//  ProyectoiOS
//
//  Created by dam on 6/3/18.
//  Copyright © 2018 Jose Medina Ruiz. All rights reserved.
//

import UIKit

class CardTableViewController: UITableViewController, callBackCard {
    
    
    //MARK: Properties
    
    @IBOutlet weak var btnBuy: UIButton!
    @IBOutlet weak var cardTableView: UITableView!
    @IBOutlet weak var labelTotalCard: UILabel!
    
    var cardProduct = [CardBakery]()
    var totalPrice: Double = 0.0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !cardProduct.isEmpty{
            for priceProduct in cardProduct{
                totalPrice = totalPrice + (priceProduct.price! * Double(priceProduct.amount!))
            }
            
            labelTotalCard.text = "Total " + String(totalPrice) + "€"
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cardProduct.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productCell: CardTableViewCell = tableView.dequeueReusableCell(withIdentifier: "productCellTable", for: indexPath) as! CardTableViewCell

        productCell.cardProductTable.text = cardProduct[indexPath.row].name
        productCell.cardProductAmount.text = String(cardProduct[indexPath.row].amount!)
        productCell.cardProductTotal.text = String(cardProduct[indexPath.row].price! * Double(cardProduct[indexPath.row].amount!))
        

        return productCell
    }
    
    func addAmount(indexPath: IndexPath, amount: Int) {
        let cell : CardTableViewCell = cardTableView!.cellForRow(at: indexPath) as! CardTableViewCell
        cardProduct[indexPath.row].amount = amount
        let price: Double = Double(cardProduct[indexPath.row].price!)
        
        let pTotal: Double = price * Double(amount)
        cell.cardProductTotal.text = String(pTotal)
        cell.cardProductAmount.text = String(amount)
        
        if amount == 0 {
            cardProduct.remove(at: indexPath.row)
        }
        
        cardTableView.reloadData()
        
    }
    
    func delAmount(id: Int, idCell: IndexPath) {
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
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
