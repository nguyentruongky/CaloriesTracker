//
//  UserCell.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/24/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

class CTUserCell: knListCell<CTUser> {
    override var data: CTUser? { didSet {
        avatarImgView.downloadImage(from: data?.avatar)
        nameLabel.text = data?.name
        emailLabel.text = data?.email
        updateUIByRole(role: data?.role ?? .user)
    }}
    
    func updateUIByRole(role: UserRole) {
        roleView.isHidden = true
        optionButton.isHidden = false
        
        switch role {
        case .admin:
            roleLabel.text = data?.role.rawValue.capitalized
            roleView.backgroundColor = UIColor.main
            optionButton.isHidden = true
            roleView.isHidden = false
        case .manager:
            roleLabel.text = data?.role.rawValue.capitalized
            roleView.backgroundColor = UIColor.CT_163_169_175
            roleView.isHidden = false
        case .user: break
        }
    }
    
    let avatarImgView = UIMaker.makeImageView(image: UIImage(named: "user_profile"),
                                              contentMode: .scaleAspectFill)
    let nameLabel = UIMaker.makeLabel(font: UIFont.main(.bold, size: 14),
                                      color: UIColor.CT_25, alignment: .center)
    let emailLabel = UIMaker.makeLabel(font: UIFont.main(size: 12),
                                      color: UIColor.CT_105, alignment: .center)
    let optionButton = UIMaker.makeButton(image: UIImage(named: "more"))
    let roleLabel = UIMaker.makeLabel(font: UIFont.main(.bold, size: 10),
                                           color: UIColor.white, alignment: .center)
    let roleView = UIMaker.makeView(background: UIColor.main)

    override func setupView() {
        roleView.addSubviews(views: roleLabel)
        roleLabel.horizontal(toView: roleView, space: 8)
        roleLabel.centerY(toView: roleView)
        let roleHeight: CGFloat = 20
        roleView.height(roleHeight)
        roleView.setCorner(radius: roleHeight / 2)
        
        let view = UIMaker.makeView()
        view.addSubviews(views: avatarImgView, nameLabel, emailLabel, optionButton, roleView)
        avatarImgView.left(toView: view)
        avatarImgView.vertical(toView: view)
        let avatarHeight: CGFloat = 44
        avatarImgView.square(edge: avatarHeight)
        avatarImgView.setCorner(radius: avatarHeight / 2)
        
        nameLabel.bottom(toAnchor: view.centerYAnchor, space: -2)
        nameLabel.leftHorizontalSpacing(toView: avatarImgView, space: -16)
        
        emailLabel.left(toView: nameLabel)
        emailLabel.verticalSpacing(toView: nameLabel, space: 4)
        
        optionButton.right(toView: view)
        optionButton.centerY(toView: view)
        optionButton.square(edge: 44)
        optionButton.contentEdgeInsets = UIEdgeInsets(space: 8)
        optionButton.imageView?.contentMode = .scaleAspectFit
        
        roleView.leftHorizontalSpacing(toView: nameLabel, space: -12)
        roleView.centerY(toView: nameLabel)
        
        addSubviews(views: view)
        view.horizontal(toView: self, space: padding)
        view.top(toView: self)
        
        optionButton.addTarget(self, action: #selector(showOption))
    }
    
    @objc func showOption() {
        let ctr = UIAlertController(title: "More options", message: nil, preferredStyle: .actionSheet)
        guard let role = data?.role else { return }
        switch role {
        case .admin:
            break
        case .manager:
            ctr.addAction(UIAlertAction(title: "Promote to Admin", style: .default,
                                        handler: promoteToAdmin))
            
        case .user:
            ctr.addAction(UIAlertAction(title: "Promote to Manager", style: .default,
                                        handler: promoteToManager))
            
        }
        
        ctr.addAction(UIAlertAction(title: "Deactivate account", style: .default,
                                    handler: deactivateAccount))
        ctr.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        UIApplication.present(ctr)
    }
    var newRole: UserRole?
    func promoteToAdmin(_ action: UIAlertAction) {
        print("promoteToAdmin")
        guard let id = data?.userId else { return }
        newRole = .admin
        CTSetUserRoleWorker(role: .admin, userId: id, successAction: didChangeRole,
                            failAction: didChangeRoleFail).execute()
    }
    
    func didChangeRole() {
        guard let newRole = newRole else { return }
        data?.role = newRole
        updateUIByRole(role: newRole)
        layoutIfNeeded()
        CTMessage.showMessage("Updated")
        self.newRole = nil
    }
    
    func didChangeRoleFail(_ err: knError) {
        CTMessage.showError(err.message ?? "Can't update role at this time")
    }
    
    func promoteToManager(_ action: UIAlertAction) {
        print("promoteToManager")
        guard let id = data?.userId else { return }
        newRole = .manager
        CTSetUserRoleWorker(role: .manager, userId: id, successAction: didChangeRole,
                            failAction: didChangeRoleFail).execute()
    }

    func deactivateAccount(_ action: UIAlertAction) {
        print("deactivateAccount")
        
    }
}
