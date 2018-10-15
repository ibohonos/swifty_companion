//
//  ViewController.swift
//  intraUsers
//
//  Created by Ivan BOHONOSIUK on 10/15/18.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var login: UITextField!
    
    let empty = UIAlertController(title: "Error", message: "Empty field, please enter login", preferredStyle: .alert)
    let noUser = UIAlertController(title: "Error", message: "Invalid Username, try again", preferredStyle: .alert)
    
    let apiReq = APIController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        apiReq.basicRequest()
        
        empty.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        noUser.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func searchBtn(_ sender: UIButton) {
        if login.text != nil && login.text != "" {
            DispatchQueue.main.async {
                self.apiReq.getLoginData(login: self.login.text!)
            }
        } else {
            self.present(self.empty, animated: true, completion: nil)
        }
    }
    
}

