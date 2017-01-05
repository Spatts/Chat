//
//  User.swift
//  Chat
//
//  Created by Steven Patterson on 8/16/16.
//  Copyright © 2016 Steven Patterson. All rights reserved.
//

import Foundation
import CloudKit


class User {
    static let kFirstName = "FirstName"
    static let kLastName = "LastName"
    static let kPassword = "password"
    static let kUserName = "username"
    static let recordType = "User"
    
    var firstName: String
    var lastName: String
    var password: String
    var username: String
    var recordID: CKRecordID?
    
    
    init(firstName: String, lastName: String, password: String, username: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.password = password
    }
    
    init?(cloudkitRecord: CKRecord) {
        guard let firstName = cloudkitRecord[User.kFirstName] as? String,
            lastName = cloudkitRecord[User.kLastName] as? String,
            username = cloudkitRecord[User.kUserName] as? String,
            password = cloudkitRecord[User.kPassword] as? String else {return nil}
        
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.password = password
        self.recordID = cloudkitRecord.recordID
    }
    

    
    
}