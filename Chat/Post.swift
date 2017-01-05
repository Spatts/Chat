//
//  Post.swift
//  Chat
//
//  Created by Steven Patterson on 8/16/16.
//  Copyright © 2016 Steven Patterson. All rights reserved.
//

import Foundation
import CloudKit


class Post {
    static let kText = "Text"
    static let kTimeStamp = "TimeStamp"
    static let recordType = "Post"
    
    
    var text: String
    var timeStamp: NSDate?
    var userReference: CKReference?
    var messageReference: CKReference?
    
    init(text: String, timeStamp: NSDate?, userReference: CKReference? = nil, messageReference: CKReference? = nil) {
        self.messageReference = messageReference
        self.text = text
        self.timeStamp = timeStamp
        self.userReference = userReference
    
    }
    
    var cloudKitRecord: CKRecord {
        let record = CKRecord(recordType: Post.recordType)
        
        record[Post.kText] = text
        record[Post.kTimeStamp] = timeStamp
        return record
    }
    
    init?(cloudKitRecord: CKRecord) {
        guard let text = cloudKitRecord[Post.kText] as? String,
        timeStamp = cloudKitRecord[Post.kTimeStamp] as? NSDate
        where cloudKitRecord.recordType == Post.recordType
            else {
                print("Post Failable Initializer Failed")
                return nil
        }
        
        self.timeStamp = timeStamp
        self.text = text
        
    }
    
}