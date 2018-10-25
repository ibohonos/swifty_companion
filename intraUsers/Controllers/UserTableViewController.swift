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
    
    func allUserInfo(info: UserData) {
        DispatchQueue.main.async {
            self.userData = info
            self.userTable.reloadData()
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
            return 4
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if userData != nil {
            if section == 0 {
                return 1
            }
            if section == 1 {
                return userData!.cursus_users.skills!.count
            }
            if section == 2 {
                return userData!.projects_users!.count
            }
            if section == 3 {
                return userData!.achievements!.count
            }
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if userData != nil {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "userInfoCell", for: indexPath) as! UserInfoTableViewCell

                // Configure the cell...
                let data = try? Data(contentsOf: URL(string: (userData!.image_url))!)
                cell.ava.image = UIImage(data: data!)
                cell.displayName.text = userData!.displayname
                cell.login.text = userData!.login
                cell.phone.text = "Phone: \(userData!.phone ?? "None")"
                cell.location.text = "Location: \(userData!.location ?? "Unavailable")"
                cell.wallets.text = "Wallets: \(userData!.wallet)"
                cell.corrections.text = "Corrections: \(userData!.correction_point)"
                cell.level.text = "Level: \(userData!.cursus_users.level)"
                cell.levelBar.progress = Float(userData!.cursus_users.level - Double(Int(userData!.cursus_users.level)))
                
                return cell
            }
            
            if indexPath.section == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "userSkillsCell", for: indexPath) as! UserInfoTableViewCell
                
                // Configure the cell...
                cell.skillName.text = userData!.cursus_users.skills![indexPath.row].name
                cell.skillLevel.text = String(userData!.cursus_users.skills![indexPath.row].level)
                
                return cell
            }
            
            if indexPath.section == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "userProjectsCell", for: indexPath) as! UserInfoTableViewCell
                
                // Configure the cell...
                cell.projectName.text = userData!.projects_users![indexPath.row].project_name
                if userData!.projects_users![indexPath.row].status == "finished" {
                    cell.projectMark.text = String(describing: userData!.projects_users![indexPath.row].final_mark!)
                } else if userData!.projects_users![indexPath.row].status == "in_progress" || userData!.projects_users![indexPath.row].status == "parent" {
                    cell.projectMark.text = "None"
                }
                
                return cell
            }
            
            if indexPath.section == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "userAchievementsCell", for: indexPath) as! UserInfoTableViewCell
                
                // Configure the cell...
                
                cell.achName.text = userData!.achievements![indexPath.row].name
                cell.achDesc.text = String(userData!.achievements![indexPath.row].desc)
                
                return cell
            }
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return addHeader(text: "User info")
        }
        if section == 1 {
            return addHeader(text: "Skills")
        }
        if section == 2 {
            return addHeader(text: "Projects")
        }
        if section == 3 {
            return addHeader(text: "Achievements")
        }
        return UIView()
    }
    
    func addHeader(text: String) -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.17, green:0.49, blue:0.19, alpha:1.0)
        
        
        let label = UILabel()
        label.text = text
        label.textColor = UIColor.white
        label.frame = CGRect(x: 15, y: 3, width: 200, height: 20)
        view.addSubview(label)
        
        return view
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
