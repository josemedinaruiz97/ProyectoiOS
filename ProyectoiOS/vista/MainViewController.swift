//
//  MainViewController.swift
//  PruebaAutolayout
//
//  Created by Francisco Garcia Molina on 3/3/18.
//  Copyright © 2018 Francisco García Molina. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, callBack, UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {

    //MARK: Properties
    @IBOutlet weak var mainControllerProduct: UICollectionView!
    
    @IBOutlet weak var mainCardButton: UIButton!
    @IBOutlet weak var mainTotalLabel: UILabel!
    
    
    var productArray:[Producto]?
    var cardProduct = [CardBakery]()
    var arrayFamilias:[Familia]!
    var arrayTicket : [Ticket]!
    var arrayDetailTicket : [TicketDetail]!
    var token:String!
    var usuarioYContraseña: String!
    
    //MARK: Search properties
    let searchController = UISearchController(searchResultsController: nil)
    var filteredProduct : [Producto]?
    var searchActive : Bool = false
    
    var totalPrice: Double = 0.0
    var send : Producto?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Inicializar search
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search product"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        //MARK: Collection
        mainControllerProduct.delegate = self
        mainControllerProduct.dataSource = self
        
        let layout = self.mainControllerProduct.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 2
        layout.itemSize = CGSize(width: (self.mainControllerProduct.frame.size.width - 50)/2,height: ((self.mainControllerProduct.frame.size.height - 20)/3) )
        

        
        
        self.view.addSubview(mainControllerProduct)
        // Do any additional setup after loading the view.
        
        if !cardProduct.isEmpty{
            totalPrice=0
            for priceProduct in cardProduct{
                totalPrice = totalPrice + (priceProduct.price! * Double(priceProduct.amount!))
            }
            
            mainTotalLabel.text = "Total " + String(totalPrice) + "€"
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func productDetails(indexPath: IndexPath) {
        let cell : MainProductCollectionViewCell = mainControllerProduct!.cellForItem(at: indexPath) as! MainProductCollectionViewCell
        let name = cell.productTilteMain.text
        for product in productArray!{
            if product.product == name{
                send = product
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isFiltering(){
            return filteredProduct!.count
        }
        
        return productArray!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let prodcutCell: MainProductCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainProductCell", for: indexPath) as! MainProductCollectionViewCell
        let product: Producto
        if isFiltering() {
            product = filteredProduct![indexPath.row]
        } else {
            product = productArray![indexPath.row]
        }
        
        prodcutCell.productTilteMain.text = product.product
        prodcutCell.productImageMain.downloadedFrom(link: product.id)
        
        prodcutCell.indexPath = indexPath
        
        prodcutCell.callBack = self
        
        //style cell
        prodcutCell.layer.cornerRadius = 5
        prodcutCell.layer.borderColor = UIColor.white.cgColor
        prodcutCell.layer.borderWidth = 2
        
        return prodcutCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let prodcutCell: MainProductCollectionViewCell = collectionView.cellForItem(at: indexPath) as! MainProductCollectionViewCell
        
        //buscamos el producto por si se encuentre en el carro
        var added = false
        var product :Producto?
        for productFiltered in productArray!{
            if productFiltered.product == prodcutCell.productTilteMain.text{
                product = productFiltered
                for addedProduct in cardProduct{
                    if productFiltered.product == addedProduct.name{
                        added = true
                        addedProduct.amount = addedProduct.amount! + 1
                    }
                }
            }
            
        }
        
        if added == false {
            //añadimos al carro
            let newProduct = CardBakery(name: product!.product, category: product!.idfamily, price: Double(product!.price)!, amount:1)
            cardProduct.append(newProduct)
        }
        
        if cardProduct.isEmpty{
            mainTotalLabel.text = "Total 0€"
        }else{
            totalPrice=0
            for priceProduct in cardProduct{
                totalPrice = totalPrice + (priceProduct.price! * Double(priceProduct.amount!))
            }
            
            mainTotalLabel.text = "Total " + String(totalPrice) + "€"
        }
        
        self.mainControllerProduct.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch segue.identifier {
        case "mainCard"?:
            let des = segue.destination as? UINavigationController
            let destino = des?.viewControllers.first as? CardViewController
            /*guard let cardViewController = segue.destination as? CardViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }*/
            print(token)
            destino?.arrayProductos=self.productArray
            destino?.cardArray=self.cardProduct
            destino?.arrayFamilias=self.arrayFamilias
            destino?.arrayTicket=self.arrayTicket
            destino?.arrayDetailTicket=self.arrayDetailTicket
            destino?.token=self.token
            destino?.usuarioYContraseña=self.usuarioYContraseña
            break
        case "mainDetail"?:
            guard let detailsViewController = segue.destination as? DetailsViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            detailsViewController.productObject = send
            break
        default:
            print("")
            break
        }
    }
    
    //MARK: Search actions
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredProduct = productArray?.filter({( product : Producto) -> Bool in
            return product.product.lowercased().contains(searchText.lowercased())
        })
        
        self.mainControllerProduct.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        //collectionView.reloadData()
        self.searchController.dismiss(animated: true, completion: nil)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
        self.mainControllerProduct.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.mainControllerProduct.reloadData()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        if !searchActive {
            searchActive = true
            self.mainControllerProduct.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
    }

}
