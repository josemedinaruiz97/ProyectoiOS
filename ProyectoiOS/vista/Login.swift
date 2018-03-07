//
//  ViewController1.swift
//  ProyectoiOS
//
//  Created by Jose Medina Ruiz on 28/2/18.
//  Copyright © 2018 Jose Medina Ruiz. All rights reserved.
//

import UIKit

class Login: UIViewController, OnHttpResponse, UITextFieldDelegate{
    //MARK: Propiedades
    @IBOutlet weak var tilLogin: UITextField!
    @IBOutlet weak var tilPassword: UITextField!
    @IBOutlet weak var lError: UILabel!
    private var arrayProductos:[Producto]=Array()
    private var arrayFamilia:[Familia]=Array()
    private var arrayTicket : [Ticket] = [Ticket(id: "1", idmember: "1", idcliente: ""), Ticket(id: "2", idmember: "2", idcliente: "")]
    private var arrayDetailTicket : [TicketDetail] = [TicketDetail(id: "1", idticket: "1", idproduct: "1", quantity: "3", price: "1.5"), TicketDetail(id: "2", idticket: "2", idproduct: "2", quantity: "2", price: "0.5")]
    private var token:String!
    private var usuarioYContraseña:String!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func evento(_ sender: Any) {
        guard let login=tilLogin.text, !tilLogin.text!.isEmpty else{
            lError.text="Error login vacio"
            lError.isHidden=false
            return
        }
        guard let password=tilPassword.text , !tilPassword.text!.isEmpty else {
            lError.text="Error password vacio"
            lError.isHidden=false
            return
        }
        usuarioYContraseña =  RestJsonUtil.toBase64(cadena: login+":"+password)
        guard let cliente = ClienteHttp(target: "product", authorization: "Basic " + usuarioYContraseña, responseObject: self) else {
            return
        }
        cliente.request()
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
    }
    func onDataReceived(data: Data) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        guard let respuesta:Dictionary=RestJsonUtil.jsonToDict(data: data) else {
            lError.text="Datos erroneos"
            lError.isHidden=false;
            return
        }
        print(respuesta["ok"] as! Bool)
        if(respuesta["ok"] as! Bool){
            token=respuesta["token"] as! String
            let peticion:String=respuesta["peti"] as! String
            if(peticion=="product"){
                arrayProductos=try!JSONDecoder().decode([Producto].self, from:try! JSONSerialization.data(withJSONObject:
                    respuesta["op"] ?? ""))
                print(arrayProductos)
                guard let cliente1 = ClienteHttp(target: "family", authorization: "Bearer " + token, responseObject: self) else {
                    return
                }
                cliente1.request()
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                }
            }
            else{
                arrayFamilia=try!JSONDecoder().decode([Familia].self, from:try! JSONSerialization.data(withJSONObject: respuesta["op"] ?? ""))
                print(arrayFamilia)
        }
            if(arrayFamilia.count>0 && arrayProductos.count>0){
            performSegue(withIdentifier: "hello", sender:self)
            }
        
        }else{
            lError.text="Usuario y contraseña no validos"
            lError.isHidden=false;
            return
        }
    }
    
    func onErrorReceivingData(message: String) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let des = segue.destination as? UINavigationController
        let destino = des?.viewControllers.first as? SegmentedController
        print(arrayProductos)
        destino?.arrayProductos=self.arrayProductos
        destino?.arrayFamilias=self.arrayFamilia
        destino?.token=self.token
        destino?.arrayTicket = self.arrayTicket
        destino?.arrayDetailTicket = self.arrayDetailTicket
        destino?.usuarioYContraseña=self.usuarioYContraseña
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField==tilLogin{
            tilPassword.becomeFirstResponder()
        }else{
            self.evento((Any).self)
        }
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
