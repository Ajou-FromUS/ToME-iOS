//
//  Message.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/09/26.
//

import UIKit

import MessageKit

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

struct Message: MessageType {
    let id: String?
    var messageId: String {
        return id ?? UUID().uuidString
    }
    let content: String
    let sentDate: Date
    let sender: SenderType
    var kind: MessageKind {
        return .text(content)
    }
    init(content: String, sender: SenderType) {
        self.sender = sender
        self.content = content
        sentDate = Date()
        id = nil
    }
}

extension Message: Comparable {
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: Message, rhs: Message) -> Bool {
        return lhs.sentDate < rhs.sentDate
    }
}

