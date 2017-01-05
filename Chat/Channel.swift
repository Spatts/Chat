//
//  Channel.swift
//  Chat
//
//  Created by Steven Patterson on 8/19/16.
//  Copyright © 2016 Steven Patterson. All rights reserved.
//

import Foundation
import CloudKit

class Channel {
    static let kTitle = "Title"
    static let kTimeStamp = "TimeStamp"
    static let kPosts = "Posts"
    static let recordType = "Channel"
    
    var title: String
    var timeStamp: NSDate?
    var recordID: CKRecordID?
    var userReference: CKReference?
    var posts: [Post] = []
    
    
    init(title: String, timeStamp: NSDate?, posts: [Post] = [], userReference: CKReference) {
        self.title = title
        self.timeStamp = timeStamp
        self.userReference = userReference
        self.posts = posts
    }
    
    var cloudKitRecord: CKRecord {
        let record = CKRecord(recordType: Channel.recordType)
        
        record[Channel.kTitle] = title
        record[Channel.kTimeStamp] = timeStamp
        record[Channel.kPosts] = posts
        return record
    }
    
    init?(cloudKitRecord: CKRecord) {
        guard let title = cloudKitRecord[Channel.kTitle] as? String,
            timeStamp = cloudKitRecord[Channel.kTimeStamp] as? NSDate,
            posts = cloudKitRecord[Channel.kPosts] as? [Post]
            where cloudKitRecord.recordType == Channel.recordType
            else {
                print("Sorry Channel Failable Initializer Failed")
                return nil
        }
        
        self.timeStamp = timeStamp
        self.title = title
        self.posts = posts
    }
    
    
}