//
//  ViewController.swift
//  Currency Convert
//
//  Created by Furkan Beyhan on 28.02.2019.
//  Copyright © 2019 Furkan Beyhan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    @IBAction func getRates(_ sender: Any) {
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=ce90ab40daf26039bc88e6c4d2b2fd20&format=1")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            }else{
                
                if data != nil {
                    
                    do{
                        
                    let jSONResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,AnyObject>
                    
                        DispatchQueue.main.async {
//                            print(jSONResult)
                            
                            let rates = jSONResult["rates"] as! [String:AnyObject]

                            let turkish = String(describing:rates["TRY"]!)
                            self.tryLabel.text = "TRY: \(turkish)"
                            
                            let cad = String(describing:rates["CAD"]!)
                            self.cadLabel.text = "CAD: \(cad)"
                            
                            let chf = String(describing:rates["CHF"]!)
                            self.chfLabel.text = "CHF: \(chf)"
                            
                            let gbp = String(describing:rates["GBP"]!)
                            self.gbpLabel.text = "GBP: \(gbp)"
                            
                            let jpy = String(describing:rates["JPY"]!)
                            self.jpyLabel.text = "JPY: \(jpy)"
                            
                            let usd = String(describing:rates["USD"]!)
                            self.usdLabel.text = "USD: \(usd)"
                            
                        }
                        
                        
                    }catch{
                        
                    }
                    
                }
                
            }
            
        }
        task.resume()
    }
    
}

