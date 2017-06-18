//
//  HMChatRoomViewModel.swift
//  HelloMVVM
//
//  Created by Ranjith Kumar on 17/06/2017.
//  Copyright © 2017 F22Labs. All rights reserved.
//

import Firebase
import JSQMessagesViewController

protocol HMChatRoomViewProtocol:class {
    func didObserveChatRoom()
    func didMessageSend()
    func isAnyone(Typing:Bool)
}

class HMChatRoomViewModel: NSObject {
    
    public weak var delegate:HMChatRoomViewProtocol?
    
    public var chatRoomsRef: FIRDatabaseReference?
    public var ref_url:String?
    public var chatRoom: ChatRoom? {
        didSet {
            if let url = ref_url {
                self.chatRoomsRef = FIRDatabase.database().reference().child(url)
            }
        }
    }
    
    //To recognise user is typing
    private lazy var userIsTypingRef: FIRDatabaseReference =
        self.chatRoomsRef!.child("typingIndicator").child(HMUserStore.shared.uid)
    private var localTyping = false
    var isTyping: Bool {
        get {
            return localTyping
        }
        set {
            localTyping = newValue
            userIsTypingRef.setValue(newValue)
        }
    }
    private lazy var usersTypingQuery: FIRDatabaseQuery =
        self.chatRoomsRef!.child("typingIndicator").queryOrderedByValue().queryEqual(toValue: true)
    
    //Message fetch and send Handling
    private lazy var messageRef: FIRDatabaseReference = self.chatRoomsRef!.child("messages")
    private var newMessageRefHandle: FIRDatabaseHandle?
    
    var messages = [JSQMessage]()
    
    public func observeChatRoom() {
        let messageQuery = messageRef.queryLimited(toLast:100)
        newMessageRefHandle = messageQuery.observe(.childAdded, with: { (snapshot) -> Void in
            let messageData = snapshot.value as! Dictionary<String, String>
            
            if let id = messageData["senderId"] as String!, let name = messageData["senderName"] as String!, let text = messageData["text"] as String!, text.characters.count > 0 {
                if let message = JSQMessage(senderId: id, displayName: name, text: text) {
                    self.messages.append(message)
                }
                self.delegate?.didObserveChatRoom()
            } else {
                print("Error! Could not decode message data")
            }
        })
    }
    
    public func observeTyping() {
        let typingIndicatorRef = chatRoomsRef!.child("typingIndicator")
        userIsTypingRef = typingIndicatorRef.child(HMUserStore.shared.uid)
        userIsTypingRef.onDisconnectRemoveValue()
        
        usersTypingQuery.observe(.value) { (data: FIRDataSnapshot) in
            // You're the only one typing, don't show the indicator
            if data.childrenCount == 1 && self.isTyping {
                return
            }
            self.delegate?.isAnyone(Typing: data.childrenCount > 0)
        }
    }
    
    
    public func didPressSendButton(with text:String) {
        let itemRef = messageRef.childByAutoId()
        let messageItem = [
            "senderId": HMUserStore.shared.uid,
            "senderName": HMUserStore.shared.email,
            "text": text,
            ]
        
        itemRef.setValue(messageItem)
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        self.delegate?.didMessageSend()
        isTyping = false
    }
    
    //DataSource
    public func numberOfSection()->Int {
        return 1
    }
    
    public func numberOfRows(in section:Int)->Int {
        return self.messages.count
    }
    
    public func objectForRow(at indexpath:IndexPath)->JSQMessage {
        return self.messages[indexpath.row]
    }
    
}
