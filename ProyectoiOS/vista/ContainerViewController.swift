//
//  ContainerViewController.swift
//
//
//  Created by Aaqib Hussain on 03/08/2015.
//  Copyright (c) 2015 Kode Snippets. All rights reserved.
//

import UIKit

open class ContainerViewController: UIViewController {
    var arrayProductos:[Producto]!
    var arrayFamilias:[Familia]!
    var arrayTicket : [Ticket]!
    var arrayDetailTicket : [TicketDetail]!
    var token:String!
    var usuarioYContraseña: String!
    var cardProduct = [CardBakery]()
    var anterior=""
    //Manipulating container views
    fileprivate weak var viewController : UIViewController!
    /** Pass in a tuple of required TimeInterval with UIViewAnimationOptions */
    var animationDurationWithOptions:(TimeInterval, UIViewAnimationOptions) = (0,[])
    
    /** Specifies which ever container view is on the front */
    open var currentViewController : UIViewController{
        get {
            return self.viewController
            
        }
    }
    
    
    fileprivate var segueIdentifier : String!
    
    /*Identifier For First Container SubView*/
    @IBInspectable internal var firstLinkedSubView : String!
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
    }
    open override func viewDidAppear(_ animated: Bool) {
        if let identifier = firstLinkedSubView{
            segueIdentifierReceivedFromParent(identifier)
        }
    }
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func segueIdentifierReceivedFromParent(_ identifier: String){
        
        self.segueIdentifier = identifier
        self.performSegue(withIdentifier: self.segueIdentifier, sender: nil)
        
    }
    
    
    
    
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segueIdentifier{
            if(segue.identifier=="primera"){
                if viewController != nil{
                    if anterior != "tercera"{
                        let datos=try? viewController as! ViewController
                        try? self.cardProduct=(datos?.cardProduct)!
                    }
                    viewController.view.removeFromSuperview()
                    viewController = nil
                }
                anterior="primera"
                print(token)
                let destino = segue.destination as? MainViewController
                destino?.productArray=self.arrayProductos
                destino?.cardProduct=self.cardProduct
                destino?.arrayFamilias=self.arrayFamilias
                destino?.arrayTicket=self.arrayTicket
                destino?.arrayDetailTicket=self.arrayDetailTicket
                destino?.token=self.token
                destino?.usuarioYContraseña=self.usuarioYContraseña
                print("pepe")
            }else if(segue.identifier=="segunda"){
                if viewController != nil{
                    if anterior != "tercera"{
                        let datos=try? viewController as! MainViewController
                        try? self.cardProduct=(datos?.cardProduct)!
                    }
                    viewController.view.removeFromSuperview()
                    viewController = nil
                }
                anterior="segunda"
                let destino = segue.destination as? ViewController
                destino?.productArray=self.arrayProductos
                destino?.categoryArray=self.arrayFamilias
                destino?.cardProduct=self.cardProduct
                print("pepe1")
                print(cardProduct)
            }else if(segue.identifier=="tercera"){

                if viewController != nil{
                    if anterior == "primera"{
                        let datos=try? viewController as! MainViewController
                        try? self.cardProduct=(datos?.cardProduct)!
                    }else{
                        let datos=try? viewController as! ViewController
                        try? self.cardProduct=(datos?.cardProduct)!
                    }
                    viewController.view.removeFromSuperview()
                    viewController = nil
                }
                anterior="tercera"
                let destino = segue.destination as? TicketViewCollection
                destino?.arrayTicket = self.arrayTicket
                destino?.arrayDetailTicket = self.arrayDetailTicket
                destino?.arrayProductos = self.arrayProductos
        }
            //Add to dictionary if isn't already there
            viewController = segue.destination
            UIView.transition(with: self.view, duration: animationDurationWithOptions.0, options: animationDurationWithOptions.1, animations: {
                self.addChildViewController(self.viewController)
                self.viewController.view.frame = CGRect(x: 0,y: 0, width: self.view.frame.width,height: self.view.frame.height)
                self.view.addSubview(self.viewController.view)
            }, completion: { (complete) in
                self.viewController.didMove(toParentViewController: self)
            })
            
        }

        //destino?.=self.arrayFamilia
        //destino?.token=self.token
        //destino?.usuarioYContraseña=self.usuarioYContraseña
    }
    
    
    
    
}
