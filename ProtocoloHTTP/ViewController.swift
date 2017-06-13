//
//  ViewController.swift
//  ProtocoloHTTP
//
//  Created by Ian Arvizu on 04/06/17.
//  Copyright © 2017 Ian Arvizu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var etBuscar: UITextField!
    @IBOutlet weak var tvJson: UITextView!
    var libro: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func btnBuscar(_ sender: Any) {
        if (self.etBuscar.text != "")
        {
            llamadaAsincrona()
        }
        else
        {
            self.showAlertMessage(title: "Advertencia", message: "Por favor digite el ISBN a buscar", owner: self)
        
            return
        }
    }
    
    
    @IBAction func btnIr(_ sender: Any) {
        if (self.etBuscar.text != "")
        {
            llamadaAsincrona()
            
        }
    }
    
    func showAlertMessage (title: String, message: String, owner:UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{ (ACTION :UIAlertAction!)in
        }))
        self.present(alert, animated: true, completion: nil)
    }

    
    
    @IBAction func btnClear(_ sender: Any) {
        
        self.etBuscar.text = ""
        self.tvJson.text = ""
    }

    
    func sincrono() {
        let urls = "http://dia.ccm.itesm.mx/"
        let url = NSURL(string: urls)
        let datos:NSData? = NSData(contentsOf: url! as URL)
        let texto = NSString(data: datos! as Data, encoding: String.Encoding.utf8.rawValue)
        print(texto!)
    }
    
    func llamadaAsincrona() {
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        libro = etBuscar.text
        let url = URL(string: "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"+libro)!
        
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if error != nil
            {
                
                let alert = UIAlertController(title: "Error 404", message: "Internet Problems...", preferredStyle: .alert)
            
                let cancelar = UIAlertAction(title: "OK", style: .cancel)
                
                alert.addAction(cancelar)
                
                self.present(alert, animated: true)
                
            }
            else
            {
                
                DispatchQueue.main.async {
                    
                    
                    //let texto = NSString(data: data! as Data, encoding: String.Encoding.utf8.rawValue)
                    
                    var autores: String = ""
                    
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves)
                        let disco1 = json as! NSDictionary
                        let disco2 = disco1["ISBN:"+self.libro] as! NSDictionary
                        let titulo = disco2["title"] as! NSString as String
                        
                        let disco3 = disco2["authors"] as! NSArray
                        
                        for i in 0 ..< disco3.count
                        {
                            let disco4 = disco3[i] as! NSDictionary
                            autores += disco4["name"] as! NSString as String + "\n"
                            
                        }
                        
                        self.tvJson.text = "TITULO: \n"
                        self.tvJson.text = self.tvJson.text + titulo+"\n\n"
                        
                        self.tvJson.text = self.tvJson.text + "AUTORES: \n"
                        self.tvJson.text = self.tvJson.text + autores
                        
                    }
                    catch _ {
                        
                    }
                    
                    
                    
                    
                }
                
                
            }
            
        })
        task.resume()
        print("antes")
    }
    
    
    
    
    
    
    
    
    
    


}

