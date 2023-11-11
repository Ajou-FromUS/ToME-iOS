//
//  Message.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/09/26.
//

import Foundation

import MessageKit

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

struct Message: MessageType {
    let messageId: String
    let sentDate: Date
    let kind: MessageKind
    let sender: SenderType

    init(messageId: String, kind: MessageKind, sender: SenderType, sentDate: Date) {
        self.messageId = messageId
        self.kind = kind
        self.sender = sender
        self.sentDate = sentDate
    }
}

extension Message: Comparable {
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.messageId == rhs.messageId
    }

    static func < (lhs: Message, rhs: Message) -> Bool {
        return lhs.sentDate < rhs.sentDate
    }
}

// Create a text message using the 'MessageKind.text'
func createTextMessage(messageId: String, text: String, sender: SenderType, sentDate: Date) -> Message {
    let kind = MessageKind.text(text)
    return Message(messageId: messageId, kind: kind, sender: sender, sentDate: sentDate)
}
