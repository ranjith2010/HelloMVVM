//
//  HMHomeController.swift
//  HelloMVVM
//
//  Created by Ranjith Kumar on 05/06/2017.
//  Copyright © 2017 F22Labs. All rights reserved.
//

import UIKit
import Firebase

class HMHomeController: UIViewController {

    @IBOutlet weak var tableview_users: UITableView!
    var viewModel: HMHomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HMHomeViewModel()
//        tableview_users.delegate = self
//        tableview_users.dataSource = self
        
//        let db = Database.database().reference()
//        let storage = Storage.storage().reference()
//        let tempImageRef = storage.child("tmpDir/tmpImage.jpg")
//        
//        let metaData = StorageMetadata()
//        metaData.contentType = "image/jpg"
//        
//        
//        
//        tempImageRef.put(UIImageJPEGRepresentation(#imageLiteral(resourceName: "firebase-logo.png"), 0.8)!, metadata: metaData) { (data, error) in
//            if error != nil {
//                print(error?.localizedDescription ?? "")
//            }else {
//                print("upload successful")
//            }
//        }
    }
}

extension HMHomeController:UITableViewDelegate,UITableViewDataSource {

    //MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        configureCell(cell: cell, forRowAt: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.textLabel?.text = viewModel.objectForRow(at: indexPath)
    }
}
