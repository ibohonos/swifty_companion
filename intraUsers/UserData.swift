//
//  UserData.swift
//  intraUsers
//
//  Created by Ivan BOHONOSIUK on 10/15/18.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import Foundation

struct UserData : CustomStringConvertible {
    var id: Int
    var email: String
    var login: String
    var first_name: String
    var last_name: String
    var phone: String
    var displayname: String
    var image_url: String
    var correction_point: Int
    var pool_month: String
    var pool_year: String
    var location: String?
    var wallet: Int
    var projects_users: [Projects]?
    var achievements: [Achievements]?
    var cursus_users: Cursus
    
    public var description : String {
        return "\(displayname)\n\(login)\n\(pool_year)"
    }
}

struct Projects: CustomStringConvertible {
    var id: Int
    var occurrence: Int
    var final_mark: Int
    var status: String
    var validated: Bool
    var current_team_id: Int
    var project_name: String
    var marked_at: NSDate
    var marked: Bool
    
    public var description : String {
        return "\(project_name)\n\(status)\n\(final_mark)\n\(validated)\n\(marked_at)"
    }
}

struct Achievements: CustomStringConvertible {
    var id: Int
    var name: String
    var desc: String
    var image: String
    
    public var description : String {
        return "\(name)\n\(desc)"
    }
}

struct Cursus: CustomStringConvertible {
    var grade: String
    var level: Double
    var skills: [Skills]?
    var id: Int
    var begin_at: NSDate?
    var end_at: NSDate?
    var has_coalition: Bool
    
    public var description : String {
        return "\(level)\n\(grade)"
    }
}

struct Skills: CustomStringConvertible {
    var id: Int
    var name: String
    var level: Double
    
    public var description : String {
        return "\(name)\n\(level)"
    }
}
