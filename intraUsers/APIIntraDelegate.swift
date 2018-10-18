//
//  APIIntraDelegate.swift
//  intraUsers
//
//  Created by Ivan BOHONOSIUK on 18.10.18.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import Foundation

protocol APIIntraDelegate {
    func allUserInfo(info: UserData)
    func error(er: NSError)
}
