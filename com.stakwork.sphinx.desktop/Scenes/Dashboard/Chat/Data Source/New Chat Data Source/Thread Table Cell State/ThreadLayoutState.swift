//
//  ThreadLayoutState.swift
//  Sphinx
//
//  Created by Tomas Timinskas on 28/09/2023.
//  Copyright © 2023 Tomas Timinskas. All rights reserved.
//

import Foundation

struct ThreadLayoutState {
    
    struct ThreadMessages {
        var orignalThreadMessage: ThreadOriginalMessage
        var threadPeople: [ThreadPeople]
        var threadPeopleCount: Int
        var repliesCount: Int
        var lastReplyTimestamp: String
        
        init(
            orignalThreadMessage: ThreadOriginalMessage,
            threadPeople: [ThreadPeople],
            threadPeopleCount: Int,
            repliesCount: Int,
            lastReplyTimestamp: String
        ) {
            self.orignalThreadMessage = orignalThreadMessage
            self.threadPeople = threadPeople
            self.threadPeopleCount = threadPeopleCount
            self.repliesCount = repliesCount
            self.lastReplyTimestamp = lastReplyTimestamp
        }
    }
    
    struct ThreadOriginalMessage {
        var text: String
        var timestamp: String
        var senderInfo: (NSColor, String, String?)
        
        init(
            text: String,
            timestamp: String,
            senderInfo: (NSColor, String, String?)
        ) {
            self.text = text
            self.timestamp = timestamp
            self.senderInfo = senderInfo
        }
    }
    
    struct ThreadPeople {
        var senderIndo: (NSColor, String, String?)
        
        init(
            senderIndo: (NSColor, String, String?)
        ) {
            self.senderIndo = senderIndo
        }
    }
}
