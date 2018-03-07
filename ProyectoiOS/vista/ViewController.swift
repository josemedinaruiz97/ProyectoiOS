//
//  ViewController.swift
//  PruebaAutolayout
//
//  Created by Francisco García Molina on 15/2/18.
//  Copyright © 2018 Francisco García Molina. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, callBack{
    
    //MARK: Properties
    @IBOutlet weak var ProductCollectionView: UICollectionView!
    @IBOutlet weak var CategoryCollectionView: UICollectionView!
    
    @IBOutlet weak var btnCard: UIButton!
    @IBOutlet weak var totalLabel: UILabel!
    
    
    var categoryArray : [Familia]?
    var productArray : [Producto]?
    var catSelectArray : [Producto]?=[]
    var cardProduct = [CardBakery]()
    
    var totalPrice: Double = 0.0
    var send : Producto?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        ProductCollectionView.delegate = self
        CategoryCollectionView.delegate = self
        
        ProductCollectionView.dataSource = self
        CategoryCollectionView.dataSource = self
        
        self.view.addSubview(ProductCollectionView)
        self.view.addSubview(CategoryCollectionView)
        
        let layout = self.ProductCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 2
        layout.itemSize = CGSize(width: (self.ProductCollectionView.frame.size.width - 50)/2,height: ((self.ProductCollectionView.frame.size.height + 75)/3) )
        
        if !cardProduct.isEmpty{
            for priceProduct in cardProduct{
                totalPrice = totalPrice + (priceProduct.price! * Double(priceProduct.amount!))
            }
            
            totalLabel.text = "Total " + String(totalPrice) + "€"
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.ProductCollectionView{
            
            return catSelectArray!.count
            
        }
        return categoryArray!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.ProductCollectionView{
            let prodcutCell: ProductCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCollectionViewCell
            prodcutCell.productTilte.text = catSelectArray![indexPath.row].product
            
            prodcutCell.indexPath = indexPath
            
            prodcutCell.callBack = self
            
            //style cell
            prodcutCell.layer.cornerRadius = 5
            prodcutCell.layer.borderColor = UIColor.white.cgColor
            prodcutCell.layer.borderWidth = 2
            
            return prodcutCell
        } else {
            let categoryCell: CategoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
            categoryCell.categoryTitle.text = categoryArray?[indexPath.row].family
            
            print("categoria")
            
            let indexPathForFirstRow = IndexPath(row: 0, section: 0)
            
            if indexPath == indexPathForFirstRow{
                self.CategoryCollectionView.selectItem(at: indexPathForFirstRow, animated: true, scrollPosition: UICollectionViewScrollPosition ())
                
                selectedItem(collectionView: CategoryCollectionView, indexPath: indexPath, categoryCell: categoryCell)
            }
            
            categoryCell.layer.cornerRadius = 5
            categoryCell.layer.borderColor = UIColor.black.cgColor
            categoryCell.layer.borderWidth = 2
            
            return categoryCell
        }

    }
    
    func productDetails(indexPath: IndexPath) {
        let cell : ProductCollectionViewCell = ProductCollectionView!.cellForItem(at: indexPath) as! ProductCollectionViewCell
        let name = cell.productTilte.text
        for product in catSelectArray!{
            if product.product == name{
                send = product
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Seleccion item")
        if collectionView == self.ProductCollectionView{
            let prodcutCell: ProductCollectionViewCell = collectionView.cellForItem(at: indexPath) as! ProductCollectionViewCell
            
            //buscamos el producto por si se encuentre en el carro
            var added = false
            var product : Producto?
            for productFiltered in catSelectArray!{
                if productFiltered.product == prodcutCell.productTilte.text{
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
                totalLabel.text = "Total 0€"
            }else{
                totalPrice=0
                for priceProduct in cardProduct{
                    totalPrice = totalPrice + (priceProduct.price! * Double(priceProduct.amount!))
                }
                
                totalLabel.text = "Total " + String(totalPrice) + "€"
            }
            
            self.ProductCollectionView.reloadData()
            
        } else {
            let categoryCell: CategoryCollectionViewCell = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell
            catSelectArray?.removeAll()
            
            selectedItem(collectionView: CategoryCollectionView, indexPath: indexPath, categoryCell: categoryCell)
            
            self.ProductCollectionView.reloadData()
        }
    }
    
    func selectedItem(collectionView: UICollectionView, indexPath: IndexPath, categoryCell: CategoryCollectionViewCell){

        print("CellCat: " + categoryCell.categoryTitle.text!, indexPath)
        for category in categoryArray!{
            if categoryCell.categoryTitle.text == category.family{
                for product in productArray!{
                    if product.idfamily == category.id{
                        catSelectArray?.append(product)
                    }
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let detailsViewController = segue.destination as? DetailsViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        detailsViewController.productObject = send
    }
    
}


