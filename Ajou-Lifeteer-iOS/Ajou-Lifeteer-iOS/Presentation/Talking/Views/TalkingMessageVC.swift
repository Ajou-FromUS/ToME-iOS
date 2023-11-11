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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class TalkingMessageVC: MessagesViewController {
    // MARK: - Properties
    
    var messages = [Message]()
    
    let toSender = Sender(senderId: "To", displayName: "To")
    let meSender = Sender(senderId: "ME", displayName: "ME")
    
    private lazy var toFirstMessage = createTextMessage(messageId: "To", text: "안녕, 재현 님. 오늘 하루는 어떠셨는지 제게 알려주세요.",
                                                        sender: self.toSender, sentDate: Date())
    
    private let typingBubble = TypingBubble()
    
    // MARK: - UI Components
    
    let layout = MessagesCollectionViewFlowLayout()
    private lazy var messageCollectionView = MessagesCollectionView(frame: .zero, collectionViewLayout: self.layout)

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 각 셀 설정
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
            layout.setMessageOutgoingAvatarSize(.zero)
            layout.setMessageIncomingAvatarSize(CGSize(width: 24, height: 24))
            layout.sectionInset = UIEdgeInsets(top: 1, left: 10, bottom: 1, right: 8)
            layout.setMessageOutgoingMessageTopLabelAlignment(LabelAlignment(textAlignment: .right, textInsets: .zero))
            layout.setMessageIncomingMessageTopLabelAlignment(LabelAlignment(textAlignment: .left, textInsets: .zero))
            layout.sectionHeadersPinToVisibleBounds = true
        }
        
        configureMessagesCollectionView()
        configureMessageInputBar()
        
            // MessagesCollectionView에 사용자 지정 셀 등록
        self.messagesCollectionView.backgroundColor = .clear
        self.messagesCollectionView.register(CustomMessageCell.self)
        
        // MessagesFlowLayout에서도 회전 적용
    
        view.backgroundColor = .clear
        
        firstToDefaultMessage()
        showTypingIndicator()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}

extension TalkingMessageVC {
    private func configureMessagesCollectionView() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        scrollsToLastItemOnKeyboardBeginsEditing = true // default false
        maintainPositionOnInputBarHeightChanged = true // default false
        showMessageTimestampOnSwipeLeft = true // default false
    }
    
    private func configureMessageInputBar() {
        inputBarType = .custom(messageInputBar)
        messageInputBar.delegate = self
        messageInputBar.setRightStackViewWidthConstant(to: 36, animated: false)

        messageInputBar.isTranslucent = true
        messageInputBar.inputTextView.tintColor = .blue

        messageInputBar.topStackView.layer.borderWidth = 30

        messageInputBar.inputTextView.textContainerInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 36)
        messageInputBar.inputTextView.placeholderLabelInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 36)

        messageInputBar.inputTextView.font = .body1
        messageInputBar.inputTextView.placeholder = "티오에게 메세지 보내기"

        messageInputBar.sendButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        messageInputBar.sendButton.setSize(CGSize(width: 45, height: 45), animated: false)
        messageInputBar.sendButton.image = ImageLiterals.archiveIcStart
        messageInputBar.sendButton.title = nil
        
        // This just adds some more flare
        messageInputBar.sendButton
          .onEnabled { item in
            UIView.animate(withDuration: 0.3, animations: {
                item.imageView?.image = ImageLiterals.archiveIcStartFill
            })
          }.onDisabled { item in
            UIView.animate(withDuration: 0.3, animations: {
                item.imageView?.image = ImageLiterals.archiveIcStart
            })
          }
    }
    
    func showTypingIndicator() {
        self.setTypingIndicatorViewHidden(false, animated: true)
        
    }
    
    private func firstToDefaultMessage() {
        let text = "안녕, 재현 님. 오늘 하루는 어떠셨는지 제게 알려주세요."
        
        // 메시지를 만들고 추가하는 로직을 수행합니다.
        let attributedText = NSAttributedString(
            string: text,
            attributes: [
                NSAttributedString.Key.font: UIFont(name: "Pretendard-Medium", size: 12),
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]
        )
        
        let message = Message(messageId: "To", kind: .attributedText(attributedText), sender: toSender, sentDate: Date())
        
        insertNewMessage(message)
    }
    
    private func insertNewMessage(_ message: Message) {
        // Append the new message to your data source
        self.messages.append(message)

        // Calculate the index path for the new section
        let indexPath = IndexPath(item: 0, section: messages.count - 1)
        
        // Perform batch updates to insert the new section
        self.messagesCollectionView.performBatchUpdates({
            self.messagesCollectionView.insertSections(IndexSet(integer: indexPath.section))
        }) { (_) in
            // Scroll to the last item with animation
            self.messagesCollectionView.scrollToLastItem(animated: true)
        }
    }
    func isLastSectionVisible() -> Bool {
      guard !messages.isEmpty else { return false }

      let lastIndexPath = IndexPath(item: 0, section: messages.count - 1)

      return messagesCollectionView.indexPathsForVisibleItems.contains(lastIndexPath)
    }
}

extension TalkingMessageVC: MessagesDataSource {
    var currentSender: MessageKit.SenderType {
        return meSender
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        let dateString = dateFormatter.string(from: message.sentDate)
        
        if indexPath.section == 0 {
          return NSAttributedString(
            string: dateString,
            attributes: [
                NSAttributedString.Key.font: UIFont.body3,
                NSAttributedString.Key.foregroundColor: UIColor.font2
            ]
          )
        }
        return nil
    }
    
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
    
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 10
    }
    
    // 타이핑 인디케이터의 크기 조정
    func typingIndicatorViewSize(for layout: MessagesCollectionViewFlowLayout) -> CGSize {
        return CGSize(width: 45, height: 45)
    }
}

extension TalkingMessageVC: MessagesDisplayDelegate {
    // 말풍선의 배경 색상
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .font4 : .mainColor
    }
    
    // 말풍선 오른쪽에
    func isFromCurrentSender(message: MessageType) -> Bool {
        // 여기에서 != 로 하면 왼쪽에서 나오고, == 로 하면 오른쪽에서 나온다
        return message.sender.senderId == currentSender.senderId
    }
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .white : .white
    }
    
    // 말풍선의 꼬리 모양 방향
    func messageStyle(for message: MessageType, at _: IndexPath, in _: MessagesCollectionView) -> MessageStyle {
      let tail: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(tail, .pointedEdge)
    }
}

// MARK: - InputBarAccessoryViewDelegate

extension TalkingMessageVC: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        // 메시지를 만들고 추가하는 로직을 수행합니다.
        let attributedText = NSAttributedString(
            string: text,
            attributes: [
                NSAttributedString.Key.font: UIFont(name: "Pretendard-Medium", size: 12),
                NSAttributedString.Key.foregroundColor: UIColor.font2
            ]
        )
        
        let message = Message(messageId: "To", kind: .attributedText(attributedText), sender: currentSender, sentDate: Date())
        
        insertNewMessage(message)
        messageInputBar.inputTextView.text = String()
    }
}
