//
//  APIController.swift
//  intraUsers
//
//  Created by Ivan BOHONOSIUK on 15.10.2018.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import UIKit

class APIController: NSObject {
    var token: String?
    var UID: String = "025e43e98d6af22dba1b285cb92140c8b2f39e23169dcf9063036f60233edaa6"
    var SECRET: String = "2630b2488a5485bc4c93d831a0ffcf752665bfca6b00fa49150c9c9b0d2508d2"
    var userData: UserData?
    let delegate: UIViewController!
    let intraDelegate: APIIntraDelegate
    
    init(na: UIViewController, intra: APIIntraDelegate) {
        self.delegate = na
        self.intraDelegate = intra
    }
    
    public func basicRequest() {
        let bearer = ((UID + ":" + SECRET).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        let url = URL(string: "https://api.intra.42.fr/oauth/token")
        let sessionConf = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConf)
        var request = URLRequest(url: url! as URL)
        
        request.httpMethod = "POST"
        request.setValue("Basic " + bearer, forHTTPHeaderField: "Authorization")
        request.httpBody = "grant_type=client_credentials&client_id=\(UID)&client_secret=\(SECRET)".data(using: String.Encoding.utf8)
        let dataTask = session.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                do {
                    let dic = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                    self.token = (dic["access_token"] as? String)!
                    if let token = self.token {
                        print("Access token: \(token)")
                    }
                }
                catch (let error) {
                    print(error)
                }
            }
        }
        dataTask.resume()
    }
    
    public func getLoginData(login: String) {
        let url = URL(string: "https://api.intra.42.fr/v2/users/\(login)")
        let sessionConf = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConf)
        var request = URLRequest(url: url! as URL)
        
        request.httpMethod = "GET"
        request.setValue("Bearer " + self.token!, forHTTPHeaderField: "Authorization")
        
        let dataTask = session.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                do {
                    let dic = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                    if dic["login"] != nil {
                        let curs = dic["cursus_users"] as! NSArray
                        let cursus_users =  curs[0] as! NSDictionary
                        let skills = cursus_users["skills"] as! NSArray
                        let projects = dic["projects_users"] as! NSArray
                        let achievements = dic["achievements"] as! NSArray
                        var allSkills: [Skills] = []
                        var allProjects: [Projects] = []
                        var allAchievements: [Achievements] = []
                        
                        for skill in skills as! [[String : Any]] {
                            allSkills.append(Skills(
                                id: skill["id"] as! Int,
                                name: skill["name"] as! String,
                                level: skill["level"] as! Double))
                        }
                        
                        for project in projects as! [[String : Any]] {
                            let nameProject = project["project"] as! NSDictionary
                            let date: String? =  project["marked_at"] as? String
                            var newDate: String?
                            if date != nil {
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                                let date2 = dateFormatter.date(from: date!)
                                dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                                newDate = dateFormatter.string(from: date2!)
                            }
                            
                            allProjects.append(Projects(
                                id: project["id"] as! Int,
                                occurrence: project["occurrence"] as! Int,
                                final_mark: project["final_mark"] as? Int,
                                status: project["status"] as! String,
                                validated: project["validated?"] as? Bool,
                                project_name: nameProject["name"] as! String,
                                marked_at: newDate,
                                marked: project["marked"] as! Bool
                            ))
                        }
                        
                        for achievement in achievements as! [[String : Any]] {
                            allAchievements.append(Achievements(
                                id: achievement["id"] as! Int,
                                name: achievement["name"] as! String,
                                desc: achievement["description"] as! String,
                                image: achievement["image"] as! String
                            ))
                        }
                        
                        self.userData = UserData(
                            id: dic["id"]! as! Int,
                            email: dic["email"]! as! String,
                            login: dic["login"]! as! String,
                            first_name: dic["first_name"]! as! String,
                            last_name: dic["last_name"]! as! String,
                            phone: dic["phone"]! as! String,
                            displayname: dic["displayname"]! as! String,
                            image_url: dic["image_url"]! as! String,
                            correction_point: dic["correction_point"]! as! Int,
                            pool_month: dic["pool_month"]! as! String,
                            pool_year: dic["pool_year"]! as! String,
                            location: dic["location"]! as? String,
                            wallet: dic["wallet"]! as! Int,
                            projects_users: allProjects,
                            achievements: allAchievements,
                            cursus_users: Cursus(
                                grade: cursus_users["grade"]! as! String,
                                level: cursus_users["level"]! as! Double,
                                skills: allSkills,
                                id: cursus_users["id"]! as! Int,
                                begin_at: cursus_users["begin_at"]! as? String,
                                end_at: cursus_users["end_at"]! as? String,
                                has_coalition: cursus_users["has_coalition"]! as! Bool
                            )
                        )
                        self.intraDelegate.allUserInfo(info: self.userData!)
                        self.delegate.performSegue(withIdentifier: "loginSegue", sender: self.delegate)
                    }
                }
                catch (let error) {
                    print(error)
                }
            }
        }
        dataTask.resume()
    }
}
