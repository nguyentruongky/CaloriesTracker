//
//  UserProfile.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/24/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit
class CTUserProfileCtr: knListController<CTMealCell, CTMeal> {
    lazy var output = Interactor(controller: self)
    let ui = UI()
    var data: CTUser?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hideBar(true)
    }
    
    override func setupView() {
        statusBarStyle = .default
        rowHeight = 265
        super.setupView()
        tableView.backgroundColor = .white
        tableView.setHeader(ui.makeHeaderView(), height: 310)
        view.addFill(tableView)

        stateView = knStateView()
        stateView?.setStateContent(state: .empty, imageName: "no_meal", title: "You have no meal yet", content: "Tracking your calories everyday for your health")

        ui.backButton.addTarget(self, action: #selector(back))
        ui.avatarImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pickAvatar)))
        fetchData()
    }
    
    func setupEmptyView(visible: Bool) {
        if visible {
            stateView?.state = .empty
            ui.mealTitleView.isHidden = true
            tableView.setFooter(stateView!, height: 400)
        } else {
            tableView.tableFooterView = nil
            ui.mealTitleView.isHidden = false
        }
    }
    
    override func fetchData() {
        guard let user = data, let id = user.userId else { return }
        ui.editButton.isHidden = id != appSetting.userId
        
        ui.avatarImgView.downloadImage(from: user.avatar, placeholder: UIImage(named: "user_profile"))
        ui.nameTextField.text = user.name
        ui.emailTextField.text = user.email
        ui.calorieLimitTextField.text = String(user.calories)
        
        setupEmptyView(visible: true)
        stateView?.state = .loading
        output.getMeals(userId: id)
    }
    
    @objc func pickAvatar() {
        func didSelectImage(_ image: UIImage) {
            DispatchQueue.main.async { [weak self] in
                self?.ui.avatarImgView.image = image
                let name = appSetting.userId ?? Date().toISO8601String()
                CTUploadAvatarWorker(image: image, fileName: name, complete: nil).execute()
            }
        }
        knPhotoSelectorWorker(finishSelection: didSelectImage).execute()
    }
    
    override func didSelectRow(at indexPath: IndexPath) {
        let ctr = CTMealDetailCtr()
        ctr.data = datasource[indexPath.row]
        push(ctr)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        statusBarHidden = scrollView.contentOffset.y > 0
    }
    
}
