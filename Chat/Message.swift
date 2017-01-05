//
//  Message.swift
//  Chat
//
//  Created by Steven Patterson on 8/19/16.
//  Copyright © 2016 Steven Patterson. All rights reserved.
//

import Foundation
import CloudKit

class Message {
    static let kTitle = "Title"
    static let kPosts = "Posts"
    static let recordType = "Message"
    
    var title: String
    var posts: [Post] = []
    var userReference: CKReference?
    
    init(title: String, posts: [Post] = [], userReference: CKReference?){
        self.posts = posts
        self.title = title
        self.userReference = userReference
        
    }
    
    var cloudKitRecord: CKRecord {
        let record = CKRecord(recordType: Message.recordType)
        
        record[Message.kTitle] = title
        record[Message.kPosts] = posts
        return record
    }
    
    init?(cloudKitRecord: CKRecord) {
        guard let title = cloudKitRecord[Message.kTitle] as? String,
            posts = cloudKitRecord[Message.kPosts] as? [Post]
        where cloudKitRecord.recordType == Channel.recordType
            else {
                print("Message Failable Initializer Failed")
                return nil
        }
        
        self.title = title
        self.posts = posts
    }
}