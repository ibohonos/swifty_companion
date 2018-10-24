//
//  UserTableViewController.swift
//  intraUsers
//
//  Created by Ivan BOHONOSIUK on 10/15/18.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController, APIIntraDelegate {
    var userData: UserData?
    var userLogin: String!
    var apic: APIController!
    
    @IBOutlet var userTable: UITableView!
    @IBOutlet weak var skillsTable: UITableView!
    
    func allUserInfo(info: UserData) {
        DispatchQueue.main.async {
            self.userData = info
            self.userTable.reloadData()
            self.skillsTable.reloadData()
        }
    }
    
    func error(er: NSError) {
        print(er.localizedDescription)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.apic!.setDelegate(intra: self)
        
        self.apic!.getLoginData(login: userLogin)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if userData != nil {
            return 1
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if userData != nil {
            return 2
        } else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userInfoCell", for: indexPath) as! UserInfoTableViewCell

            // Configure the cell...
            if userData != nil {
                let data = try? Data(contentsOf: URL(string: (userData!.image_url))!)
                cell.ava.image = UIImage(data: data!)
                cell.displayName.text = userData!.displayname
                cell.login.text = userData!.login
                cell.phone.text = "\(cell.phone.text!) \(userData!.phone ?? "None")"
                cell.location.text = "\(cell.location.text!) \(userData!.location ?? "Unavailable")"
                cell.wallets.text = "\(cell.wallets.text!) \(userData!.wallet)"
                cell.corrections.text = "\(cell.corrections.text!) \(userData!.correction_point)"
                cell.level.text = "\(cell.level.text!) \(userData!.cursus_users.level)"
                cell.levelBar.progress = Float(userData!.cursus_users.level - Double(Int(userData!.cursus_users.level)))
            }
            
            return cell
        } else/* if indexPath.row == 1*/ {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userSkillsCell", for: indexPath) as! SkillsTableViewCell
            
            // Configure the cell...
            if userData != nil {
                cell.name.text = userData!.cursus_users.skills![indexPath.row - 1].name
                cell.level.text = String(userData!.cursus_users.skills![indexPath.row - 1].level)
            }
            return cell
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
