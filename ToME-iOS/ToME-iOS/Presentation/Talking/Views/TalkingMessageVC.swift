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
import Moya

class CustomMessageCell: MessageContentCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class TalkingMessageVC: MessagesViewController {
    
    // MARK: - Providers
    
    private let chatbotProvider = Providers.chatbotProvider
    
    // MARK: - Properties
    
    var messages = [Message]()
    
    let toSender = Sender(senderId: "To", displayName: "To")
    let meSender = Sender(senderId: "ME", displayName: "ME")
    
    private lazy var toFirstMessage = createTextMessage(messageId: "To", text: "안녕, 재현 님. 오늘 하루는 어떠셨는지 제게 알려주세요.",
                                                        sender: self.toSender, sentDate: Date())
    
    private let typingBubble = TypingBubble()
    
    let layout = MessagesCollectionViewFlowLayout()

    var missionCount = Int()

    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .singleTitleWithPopButton).setTitle("티오랑 대화하기")
    private lazy var messageCollectionView = MessagesCollectionView(frame: .zero, collectionViewLayout: self.layout)
    
    private lazy var missionProgressImageView = UIImageView().then {
        $0.image = ImageLiterals.missionCount0
    }

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideTabBar(wantsToHide: true)
        view.backgroundColor = .white
        
        view.addSubviews(naviBar, missionProgressImageView)
        
        naviBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
        missionProgressImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(90)
            make.width.equalTo(140)
            make.height.equalTo(32)
        }
            
        // 각 셀 설정
            if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
                layout.setMessageOutgoingAvatarSize(.zero)
                layout.setMessageIncomingAvatarSize(CGSize(width: 35, height: 35))
                layout.setMessageIncomingAvatarPosition(.init(horizontal: .cellLeading, vertical: .messageBottom))
                layout.setMessageOutgoingMessageTopLabelAlignment(LabelAlignment(textAlignment: .right, textInsets: .zero))
                layout.setMessageIncomingMessageTopLabelAlignment(LabelAlignment(textAlignment: .left, textInsets: .zero))
                layout.sectionHeadersPinToVisibleBounds = true
                
                // 1. 아이템의 크기 설정
//                layout.itemSize = CGSize(width: messagesCollectionView.bounds.width - 20, height: 100)

                // 2. 콘텐츠와 인셋 고려
                let contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
                layout.sectionInset = contentInset
                layout.minimumLineSpacing = 10
            }

        configureMessagesCollectionView()
        configureMessageInputBar()
        
            // MessagesCollectionView에 사용자 지정 셀 등록
        self.messagesCollectionView.backgroundColor = .clear
        self.messagesCollectionView.register(CustomMessageCell.self)
                
        view.backgroundColor = .white
        
        firstToDefaultMessage()
        addTapGesture()
    }
}

// MARK: - Methods

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
    
    func setTypingIndicator(isHidden: Bool) {
        self.setTypingIndicatorViewHidden(isHidden, animated: true)
    }
    
    private func firstToDefaultMessage() {
        let text = "안녕, 재현 님.\n오늘 하루는 어떠셨는지 제게 알려주세요."
        
        insertToMessage(text: text)
        postUsersContent(message: nil)
    }
    
    private func insertToMessage(text: String) {
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
    
    
    private func setMissionCountImageView(missionCount: Int) {
        if self.missionCount != missionCount {
            
            switch missionCount {
            case 0:
                self.missionProgressImageView.image = ImageLiterals.missionCount0
            case 1:
                self.missionProgressImageView.image = ImageLiterals.missionCount1
            case 2:
                self.missionProgressImageView.image = ImageLiterals.missionCount2
            default:
                self.missionProgressImageView.image = ImageLiterals.missionCount3
            }
        }
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
    
    func cellBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"

        let dateString = dateFormatter.string(from: message.sentDate)

        return NSAttributedString(
            string: dateString,
            attributes: [
                NSAttributedString.Key.font: UIFont.body3,
                NSAttributedString.Key.foregroundColor: UIColor.font2
            ]
        )
    }
}

extension TalkingMessageVC: MessagesLayoutDelegate {
    // 아래 여백
    func footerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: 10, height: 10)
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
        return .bubbleTailOutline(.font1, tail, .pointedEdge)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            // 첫 번째 섹션에 대한 inset 설정
            return UIEdgeInsets(top: 150, left: 8, bottom: 0, right: 8)
        } else {
            // 나머지 섹션에 대한 inset 설정
            return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        }
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at _: IndexPath, in _: MessagesCollectionView) {
        let avatar = Avatar(image: ImageLiterals.tomeIcon)
        avatarView.set(avatar: avatar)
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
        print(text)
        postUsersContent(message: text)

        messageInputBar.inputTextView.text = String()
    }
}

// MARK: - Networks

extension TalkingMessageVC {
    private func postUsersContent(message: String?) {
        setTypingIndicator(isHidden: false)
        self.messageInputBar.isUserInteractionEnabled = false
        chatbotProvider.request(.sendMessage(content: message ?? nil)) { [weak self] response in
            guard let self = self else { return }
            setTypingIndicator(isHidden: true)
            self.messageInputBar.isUserInteractionEnabled = true
            switch response {
            case .success(let result):
                let status = result.statusCode
                if 200..<300 ~= status {
                    do {
                        let responseDto = try result.map(PostUsersContentResponseDto.self)
                        guard let message = responseDto.message else {
                            setMissionCountImageView(missionCount: responseDto.missionCount)
                            self.missionCount = responseDto.missionCount
                            return
                        }
                        insertToMessage(text: message)
                        setMissionCountImageView(missionCount: responseDto.missionCount)
                        self.missionCount = responseDto.missionCount
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                if status >= 400 {
                    print("400 error")
                    self.showNetworkFailureToast()
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.showNetworkFailureToast()
            }
        }
    }
}
