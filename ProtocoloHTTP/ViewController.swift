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
    }
    
    
    @IBAction func btnIr(_ sender: Any) {
        if (self.etBuscar.text != "")
        {
            llamadaAsincrona()
            
        }
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
                
                print(error!.localizedDescription)
                
            }
            else
            {
                
                DispatchQueue.main.async {
                    
                    let texto = NSString(data: data! as Data, encoding: String.Encoding.utf8.rawValue)
                    self.tvJson.text = texto! as String
                    
                }
                
                
            }
            
        })
        task.resume()
        print("antes")
    }
    
    
    
    
    
    
    
    
    
    


}

