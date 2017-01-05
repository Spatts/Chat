//
//  UserController.swift
//  Chat
//
//  Created by Steven Patterson on 8/17/16.
//  Copyright © 2016 Steven Patterson. All rights reserved.
//

import Foundation
import CloudKit

class UserController {
    
    func createUser(firstName: String, lastName: String, password: String, username: String) {
        
        CloudKitManager.sharedController.fetchLoggedInUserRecord { (record, error) in
            
            guard let record = record else {
                return
            }
            let reference = CKReference(recordID: record.recordID, action: .None)
            
            let customRecord = CKRecord(recordType: User.recordType)
            customRecord["identifier"] = reference
            customRecord[User.kFirstName] = firstName
            customRecord[User.kLastName] = lastName
            customRecord[User.kUserName] = username
            customRecord[User.kPassword] = password
            
            CloudKitManager.sharedController.saveRecord(customRecord) { (record, error) in
                
                
                let user = User(firstName: firstName, lastName: lastName, password: password, username: username)
                user.recordID = customRecord.recordID
                
            }
        }
    }
    
    
    func fetchCustomUser(completion: (user: User) -> Void) {
        
        CloudKitManager.sharedController.fetchLoggedInUserRecord { (record, error) in
            
            guard let record = record else {
                return
            }
            
            let reference = CKReference(recordID: record.recordID, action: .None)
            let predicate = NSPredicate(format: "identifier == %@", argumentArray: [reference])
            CloudKitManager.sharedController.fetchRecordsWithType(User.recordType, predicate: predicate, recordFetchedBlock: { (record) in
                guard let user = User(cloudkitRecord: record) else {
                    print("Couldn't create user with customer user record")
                    return
                }
                
                
                completion(user: user)
                
                }, completion: { (records, error) in
                    
                    
                    
            })
            
        }
        
    }
    
}