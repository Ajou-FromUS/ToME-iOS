//
//  TalkingWithToVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/8/23.
//

import UIKit
import MessageKit

class TalkingWithToVC: MessagesViewController {
    
    var sender = Sender(senderId: "any_unique_id", displayName: "몽이누나")
    var messages: [Message] = [] // 채팅 메시지를 저장할 배열
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MessageKit 설정
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        // 더미 데이터 생성
        // 여기에서는 두 가짜 사용자로 시작합니다.
        let sender = Sender(senderId: "1", displayName: "User 1")
        let otherSender = Sender(senderId: "2", displayName: "User 2")
        
        // 더미 메시지 생성
        let message1 = createTextMessage(messageId: "1", text: "Hello, how are you?", sender: sender, sentDate: Date())
        let message2 = createTextMessage(messageId: "2", text: "ThankYou", sender: sender, sentDate: Date())
        
        // 메시지 배열에 추가
        messages.append(message1)
        messages.append(message2)
        
        // 메시지 전송 버튼 설정
        messageInputBar.sendButton.setTitle("Send", for: .normal)
        messageInputBar.sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        
        // 입력 텍스트 필드 설정
        messageInputBar.inputTextView.placeholder = "Type a message..."
    }
    
    @objc func sendButtonTapped() {
        // 메시지 전송 로직을 여기에 추가
        // 입력 텍스트 필드의 텍스트를 가져와서 메시지로 만들어 배열에 추가하면 됩니다.
        if let text = messageInputBar.inputTextView.text, !text.isEmpty {
            let newMessage = createTextMessage(messageId: UUID().uuidString, text: text, sender: currentSender, sentDate: Date())
            messages.append(newMessage)
            messagesCollectionView.reloadData() // 업데이트된 메시지를 표시하려면 테이블을 다시 로드합니다.
            messageInputBar.inputTextView.text = "" // 메시지 입력 필드 지움
        }
    }
}

extension TalkingWithToVC: MessagesDataSource {
    var currentSender: MessageKit.SenderType {
        return sender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
}

extension TalkingWithToVC: MessagesLayoutDelegate {
    func headerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: messagesCollectionView.bounds.width, height: 10)
    }
    
    // Implement other methods as needed for layout customization.
}

extension TalkingWithToVC: MessagesDisplayDelegate {
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .blue : .lightGray
    }

    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .white : .black
    }

    // Implement other methods as needed for message display customization.
}
