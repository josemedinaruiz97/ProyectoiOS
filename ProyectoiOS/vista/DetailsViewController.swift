//
//  DetailsViewController.swift
//  PruebaAutolayout
//
//  Created by Francisco García Molina on 22/2/18.
//  Copyright © 2018 Francisco García Molina. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var labelNameProduct: UILabel!
    @IBOutlet weak var labelCategory: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    
    @IBOutlet weak var btnCard: UIButton!
    
    var productObject: Producto?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        labelNameProduct.text = productObject?.product
        labelCategory.text = productObject?.idfamily
        labelPrice.text = String(describing: productObject!.price) + " €"
        labelDescription.text = productObject?.description
        imageProduct.downloadedFrom(link: (productObject?.id)!)
        
        scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: labelDescription.bottomAnchor).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
