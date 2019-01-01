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
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add"), style: .done, target: self, action: #selector(addNewUser))
        navigationItem.title = "USERS"
        rowHeight = 72
        contentInset = UIEdgeInsets(top: padding, bottom: padding)
        super.setupView()
        view.addFill(tableView)
        
        addState()
    }
    
    override func fetchData() {
        if Reachability.isConnected == false {
            stateView?.state = .noInternet
            return
        }
        stateView?.state = .loading
        CTGetAllUsersWorker(successAction: didGetUsers, failAction: didGetUserFail).execute()
    }
    
    private func didGetUsers(_ users: [CTUser]) {
        if users.isEmpty {
            stateView?.state = .empty
        } else {
            datasource = users
            stateView?.state = .success
        }
    }
    
    private func didGetUserFail(_ err: knError) {
        stateView?.state = .error
    }
    
    override func didSelectRow(at indexPath: IndexPath) {
        let ctr = CTUserProfileCtr()
        ctr.hidesBottomBarWhenPushed = true
        let user = datasource[indexPath.row]
        ctr.data = user
        ctr.isMyProfile = user.userId == appSetting.userId
        push(ctr)
    }
    
    override func getCell(at index: IndexPath) -> UITableViewCell {
        let cell = super.getCell(at: index) as! CTUserCell
        cell.delegate = self
        return cell
    }
    
    @objc private func addNewUser() {
        let ctr = CTAddUserCtr()
        ctr.hidesBottomBarWhenPushed = true
        push(ctr)
    }
}

extension CTUserList: CTUserListDelegate {
    func deleteUser(_ user: CTUser) {
        guard let index = datasource.firstIndex(where:
            { $0.userId == user.userId }) else { return }
        datasource.remove(at: index)
    }
}

protocol CTUserListDelegate: class {
    func deleteUser(_ user: CTUser)
}

