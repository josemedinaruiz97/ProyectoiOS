//
//  ViewController.swift
//  ProyectoiOS
//
//  Created by Jose Medina Ruiz on 16/2/18.
//  Copyright © 2018 Jose Medina Ruiz. All rights reserved.
//

import UIKit

class SegmentedController: UIViewController {
    var container:ContainerViewController!
    var arrayProductos:[Producto]?
    var arrayFamilias:[Familia]?
    var token:String!
    var usuarioYContraseña:String!
    @IBAction func accion(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            container.segueIdentifierReceivedFromParent("segunda")
            break
        case 1:
            container.segueIdentifierReceivedFromParent("primera")
            break
        default:
        container.segueIdentifierReceivedFromParent("primera")
        break
        
    }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        container.segueIdentifierReceivedFromParent("primera")
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="container"){
            self.container=segue.destination as! ContainerViewController
            container.arrayProductos=self.arrayProductos
            container.arrayFamilias=self.arrayFamilias
            container.viewDidLoad()
        }
    }


}

