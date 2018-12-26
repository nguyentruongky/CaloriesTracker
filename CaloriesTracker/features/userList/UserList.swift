//
//  UserList.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/24/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit
class CTUserList: knListController<CTUserCell, CTUser> {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hideBar(false)
        fetchData()
    }
    override func setupView() {
        navigationItem.title = "USERS"
        rowHeight = 72
        contentInset = UIEdgeInsets(top: padding, bottom: padding)
        super.setupView()
        view.addFill(tableView)
        
        addState()
        stateView?.state = .loading
    }
    
    override func fetchData() {
        CTGetAllUsersWorker(successAction: didGetUsers, failAction: didGetUserFail).execute()
    }
    
    func didGetUsers(_ users: [CTUser]) {
        if users.isEmpty {
            stateView?.state = .empty
        } else {
            datasource = users
            stateView?.state = .success
        }
    }
    
    func didGetUserFail(_ err: knError) {
        stateView?.state = .error
    }
    
    override func didSelectRow(at indexPath: IndexPath) {
        let ctr = CTUserProfileCtr()
        ctr.data = datasource[indexPath.row]
        push(ctr)
    }
}



