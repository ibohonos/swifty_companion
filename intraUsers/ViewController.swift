//
//  ViewController.swift
//  intraUsers
//
//  Created by Ivan BOHONOSIUK on 10/15/18.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import UIKit

class ViewController: UIViewController, APIIntraDelegate {
    
    var userData: UserData?

    @IBOutlet weak var login: UITextField!
    
    let empty = UIAlertController(title: "Error", message: "Empty field, please enter login", preferredStyle: .alert)
    let noUser = UIAlertController(title: "Error", message: "Invalid Username, try again", preferredStyle: .alert)
    
    var apiReq: APIController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        apiReq = APIController(na: self, intra: self)
        apiReq!.basicRequest()
        
        empty.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        noUser.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func allUserInfo(info: UserData) {
        DispatchQueue.main.async {
            self.userData = info
        }
    }
    
    func error(er: NSError) {
        print(er)
    }

    @IBAction func searchBtn(_ sender: UIButton) {
        let myLogin = login.text!.components(separatedBy: .whitespaces).joined()
        if myLogin != "" {
            DispatchQueue.main.async {
                self.apiReq!.getLoginData(login: myLogin)
            }
        } else {
            self.present(self.empty, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSegue" {
            if let vc = segue.destination as? UserTableViewController {
                DispatchQueue.main.async {
                    vc.userData = self.userData!
                }
            }
        }
    }
    
}

