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
    
    var apiReq: APIController = APIController()
    
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
        let myLogin = login.text!.components(separatedBy: .whitespaces).joined()
        if myLogin != "" {
            self.login.text = myLogin
            self.apiReq.checkLogin(login: myLogin) { (retVal) in
                if retVal != nil {
                    if retVal == false {
                        DispatchQueue.main.async {
                            self.present(self.noUser, animated: true, completion: nil)
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "loginSegue", sender: self)
                        }
                    }
                }
            }
        } else {
            self.present(self.empty, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSegue" {
            if let vc = segue.destination as? UserTableViewController {
                vc.userLogin = self.login.text!
                vc.apic = self.apiReq
            }
        }
    }
    
}

