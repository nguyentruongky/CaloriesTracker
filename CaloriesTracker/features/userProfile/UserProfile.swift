//
//  UserProfile.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/24/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit
class CTUserProfileCtr: knListController<CTMealCell, CTMeal>, UITextFieldDelegate {
    lazy var output = Interactor(controller: self)
    let ui = UI()
    var isMyProfile = false
    var data: CTUser?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hideBar(true)
        ui.calorieLimitTextField.text = String(appSetting.standardCalories)
    }
    
    override func setupView() {
        statusBarStyle = .default
        rowHeight = 265
        super.setupView()
        tableView.backgroundColor = .clear
        tableView.setHeader(ui.makeHeaderView(), height: 310)
        let whiteView = UIMaker.makeView(background: .white)
        view.addSubview(whiteView)
        whiteView.horizontal(toView: view)
        whiteView.top(toView: view)
        whiteView.height(screenHeight / 2)
        view.backgroundColor = .bg
        view.addFill(tableView)

        stateView = knStateView()
        stateView?.setStateContent(state: .empty, imageName: "no_meal",
                                   title: "You have no meal yet",
                                   content: "Tracking your calories everyday for your health")

        ui.backButton.addTarget(self, action: #selector(back))
        ui.avatarImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pickAvatar)))
        ui.editButton.addTarget(self, action: #selector(editName))
        ui.changeCaloriesButton.addTarget(self, action: #selector(changeCalories))
        fetchData()
    }
    
    @objc func changeCalories() {
        guard isMyProfile else { return }
        push(CTCaloriesCtr())
    }
    
    @objc func editName() {
        ui.nameTextField.isEnabled = true
        ui.nameTextField.becomeFirstResponder()
        ui.nameTextField.delegate = self
    }
    
    func setupEmptyView(visible: Bool) {
        if visible {
            stateView?.state = .empty
            ui.mealTitleView.isHidden = true
            tableView.setFooter(stateView!, height: 400)
            view.backgroundColor = .white
        } else {
            tableView.tableFooterView = nil
            ui.mealTitleView.isHidden = false
            view.backgroundColor = .bg
        }
    }
    
    override func fetchData() {
        addState()
        guard let user = data, let id = user.userId else {
            if Reachability.isConnected == false {
                let backButton = ui.makeBackButton()
                stateView!.addSubview(backButton)
                backButton.topLeft(toView: view, top: hasNotch() ? 48 : 32, left: 0)
                backButton.addTarget(self, action: #selector(back))
                stateView?.state = .noInternet
                return
            } else {
                stateView?.state = .error
            }
            
            if let id = appSetting.userId, isMyProfile == true {
                output.getUserProfile(id: id)
            }
            return
        }
        
        updateUI(user: user)
        output.getMeals(userId: id)
    }
    
    func updateUI(user: CTUser) {
        ui.editButton.isHidden = !isMyProfile
        ui.avatarImgView.downloadImage(from: user.avatar, placeholder: UIImage(named: "user_profile"))
        ui.nameTextField.text = user.name
        ui.emailLabel.text = user.email
        ui.calorieLimitTextField.text = String(user.calories)
        
        setupEmptyView(visible: true)
        stateView?.state = .loading
    }
    
    
    @objc func pickAvatar() {
        guard isMyProfile else { return }
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let name = ["name": textField.text!]
        CTUpdateMyProfileWorker(data: name, successAction: nil, failAction: nil).execute()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldDidEndEditing(textField)
        hideKeyboard()
        return true
    }
}
