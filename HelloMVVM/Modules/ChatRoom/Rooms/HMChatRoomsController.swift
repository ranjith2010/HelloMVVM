//
//  HMChatRoomsController.swift
//  HelloMVVM
//
//  Created by Ranjith Kumar on 15/06/2017.
//  Copyright © 2017 F22Labs. All rights reserved.
//

import UIKit

class HMChatRoomsController: UIViewController,HMChatRoomsViewProtocol {
    
    @IBOutlet weak var txtField_channelName: UITextField!
    @IBOutlet weak var tableView_chatRooms: UITableView! {
        didSet {
            self.tableView_chatRooms.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            self.tableView_chatRooms.delegate = self
            self.tableView_chatRooms.dataSource = self
        }
    }
    
    var senderDisplayName: String?
    var newChannelTextField: UITextField?
    
    lazy var viewModel: HMChatRoomsViewModel = {
        let view = HMChatRoomsViewModel()
        view.delegate = self
        view.observeChatRooms()
        return view
    }()
    
    
    // MARK: - ViewLife cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chat Rooms"
    }
    
    deinit {
        self.viewModel.ditchChatRoomObserver()
    }
    
    //MARK: - Button Actions
    @IBAction func didTapCreateChannel(_ sender: Any) {
        self.view.endEditing(true)
        if let name = txtField_channelName?.text {
            self.viewModel.createRoom(with:name)
        }
        self.txtField_channelName.text = ""
    }
    
}

// MARK: - UITableViewDelegates & DataSources
extension HMChatRoomsController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView_chatRooms.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
        cell.textLabel?.text = self.viewModel.objectForRow(at: indexPath).name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatRoom = self.viewModel.objectForRow(at: indexPath)
        //users/<uid>/conversations/<conversationid>
        let chatvc = HMChatRoomController()
        let chatVCViewModel = HMChatRoomViewModel()
        chatVCViewModel.delegate = chatvc
        chatVCViewModel.ref_url = "chatRooms/\(chatRoom.id)/"
        chatVCViewModel.chatRoom = chatRoom
        chatvc.title = chatRoom.name
        chatvc.senderId = HMUserStore.shared.uid
        chatvc.senderDisplayName = HMUserStore.shared.email
        chatvc.viewModel = chatVCViewModel
        
        self.navigationController?.pushViewController(chatvc, animated: true)
    }
    
    //MARK: - HMChatRoomsViewProtocol functions
    func didObserveChatRooms() {
        self.tableView_chatRooms.reloadData()
    }
}
