//
//  DateViewController.swift
//  ProyectoiOS
//
//  Created by jjMac on 7/3/18.
//  Copyright © 2018 Jose Medina Ruiz. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    var arrayTicket: [Ticket]?
    var arrayProductos: [Producto]?
    var arrayDetailTicket: [TicketDetail]?
    var seletedDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonAccept(_ sender: Any) {
        datePicker.datePickerMode = UIDatePickerMode.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        seletedDate = dateFormatter.string(from: datePicker.date)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch (segue.identifier ?? "") {
        case "dateViewCollection":
            guard let destino = segue.destination as? DateViewCollection else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            destino.arrayTicket = self.arrayTicket
            destino.arrayDetailTicket = self.arrayDetailTicket
            destino.seletedDate = self.seletedDate
            destino.arrayProductos = self.arrayProductos
        default:
            fatalError("Unexpected destination: \(segue.destination)")
        }
    }

}
