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
//                        let skills = cursus_users["skills"] as! NSArray
//                        let skill = skills[0] as! NSDictionary
                        
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
                            projects_users: nil,
                            achievements: nil,
                            cursus_users: Cursus(
                                grade: cursus_users["grade"]! as! String,
                                level: cursus_users["level"]! as! Double,
                                skills: nil,
                                id: cursus_users["id"]! as! Int,
                                begin_at: cursus_users["begin_at"]! as? NSDate,
                                end_at: cursus_users["end_at"]! as? NSDate,
                                has_coalition: cursus_users["has_coalition"]! as! Bool
                            )
                        )
                        print("level = \(self.userData!.cursus_users.level)")
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
