//
//  HMChatRoomsViewModel.swift
//  HelloMVVM
//
//  Created by Ranjith Kumar on 17/06/2017.
//  Copyright © 2017 F22Labs. All rights reserved.
//
import Firebase

struct ChatRoom { let id,name:String }

protocol HMChatRoomsViewProtocol:class {
    func didObserveChatRooms()
}

class HMChatRoomsViewModel: NSObject {
    
    lazy var chatRooms:[ChatRoom] = []
    lazy var chatRoomsRef: DatabaseReference = Database.database().reference().child("chatRooms")
    private var chatRoomRefHandle: DatabaseHandle?
    public weak var delegate:HMChatRoomsViewProtocol?
    
    // MARK: - Firebase related methods
    public func observeChatRooms() {
        chatRoomRefHandle = chatRoomsRef.observe(.childAdded, with: { (snapshot) -> Void in // 1
            let chatRoomsData = snapshot.value as! Dictionary<String, AnyObject> // 2
            let id = snapshot.key
            if let name = chatRoomsData["name"] as! String!, name.characters.count > 0 { // 3
                self.chatRooms.append(ChatRoom(id: id, name: name))
                self.delegate?.didObserveChatRooms()
            } else {
                print("Error! Could not decode channel data")
            }
        })
    }
    
    public func createRoom(with name:String) {
        let newChatRoomRef = chatRoomsRef.childByAutoId()
        let channelItem = [
            "name": name
        ]
        newChatRoomRef.setValue(channelItem)
    }
    
    public func ditchChatRoomObserver() {
        if let refHandle = chatRoomRefHandle {
            chatRoomsRef.removeObserver(withHandle: refHandle)
        }
    }
    
    public func numberOfSection()->Int {
        return 1
    }
    
    public func numberOfRows(in section:Int)->Int {
        return self.chatRooms.count
    }
    
    public func objectForRow(at indexpath:IndexPath)->ChatRoom {
        return self.chatRooms[indexpath.row]
    }
    
}
