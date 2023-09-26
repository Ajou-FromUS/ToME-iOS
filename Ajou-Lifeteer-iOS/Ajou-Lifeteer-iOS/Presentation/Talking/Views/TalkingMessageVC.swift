//
//  TalkingMessageView.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/09/26.
//

import UIKit

import SnapKit
import Then
import MessageKit
import InputBarAccessoryView

class CustomMessageCell: MessageContentCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 여기에서 회전 변환을 적용합니다.
        self.transform = CGAffineTransform(rotationAngle: .pi)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class TalkingMessageVC: MessagesViewController {
    var sender = Sender(senderId: "any_unique_id", displayName: "몽이누나")
    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        // MessagesCollectionView에 사용자 지정 셀 등록
        messagesCollectionView.register(CustomMessageCell.self)

        // MessagesFlowLayout에서도 회전 적용
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
            layout.setMessageOutgoingAvatarSize(.zero)
            layout.setMessageIncomingAvatarSize(.zero)
            layout.setMessageOutgoingMessageTopLabelAlignment(LabelAlignment(textAlignment: .right, textInsets: .zero))
            layout.setMessageIncomingMessageTopLabelAlignment(LabelAlignment(textAlignment: .left, textInsets: .zero))
            }
        view.backgroundColor = .green
        
    }
}

extension TalkingMessageVC {
    private func setDelegate() {
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        messageInputBar.delegate = self
    }
    
    private func insertNewMessage(_ message: Message) {
        messages.append(message)
        messagesCollectionView.reloadData()
    }
}

extension TalkingMessageVC: MessagesDataSource {
    var currentSender: MessageKit.SenderType {
        return sender
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages.reversed()[indexPath.section]
    }
    
//    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
//        let name = message.sender.displayName
//        return NSAttributedString(string: name, attributes: [.font: UIFont.body2,
//                                                             .foregroundColor: UIColor(white: 0.3, alpha: 1)])
//    }
}

extension TalkingMessageVC: MessagesLayoutDelegate {
    // 아래 여백
    func footerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    // 말풍선 위 이름 나오는 곳의 height
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 10
    }
}

extension TalkingMessageVC: MessagesDisplayDelegate {
    // 말풍선의 배경 색상
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .disabled2 : .gray
    }
    
    // 말풍선 오른쪽에
    func isFromCurrentSender(message: MessageType) -> Bool {
        // 여기에서 != 로 하면 왼쪽에서 나오고, == 로 하면 오른쪽에서 나온다
        return message.sender.senderId == currentSender.senderId
    }
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .font1 : .white
    }
    
    // 말풍선의 꼬리 모양 방향
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let cornerDirection: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(cornerDirection, .curved)
    }
}

extension TalkingMessageVC: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        let message = Message(content: text, sender: currentSender)
        
        insertNewMessage(message)
        inputBar.inputTextView.text.removeAll()
    }
}
