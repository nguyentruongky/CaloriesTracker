//
//  Checkout.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/25/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

class CTCheckoutItemCell: knListCell<CTFood> {
    override var data: CTFood? { didSet {
        imgView.downloadImage(from: data?.image)
        nameLabel.text = data?.name
    }}
    
    let imgView = UIMaker.makeImageView(contentMode: .scaleAspectFill)
    let nameLabel = UIMaker.makeLabel(font: UIFont.main(size: 13),
                                      color: UIColor.CT_25, numberOfLines: 2)
    
    override func setupView() {
        let view = UIMaker.makeView()
        view.addSubviews(views: imgView, nameLabel)
        view.addConstraints(withFormat: "H:|-\(padding)-[v0]-16-[v1]-\(padding)-|",
            views: imgView, nameLabel)
        let imgHeight: CGFloat = 48
        imgView.square(edge: imgHeight)
        imgView.setCorner(radius: imgHeight / 2)
        imgView.centerY(toView: view)
        nameLabel.centerY(toView: imgView)
        
        addSubviews(views: view)
        view.horizontal(toView: self)
        view.centerY(toView: self)
    }
}

class CTCheckoutCtr: knListController<CTCheckoutItemCell, CTFood> {
    var meal: CTMeal?
    
    let confirmButton = UIMaker.makeMainButton(title: "Confirm")
    override func setupView() {
        title = "CHOSEN FOODS"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "close"), style: .done, target: self, action: #selector(dismissBack))
        rowHeight = 72
        contentInset = UIEdgeInsets(top: 16)
        super.setupView()
        view.addSubviews(views: tableView, confirmButton)
        view.addConstraints(withFormat: "V:|[v0]-24-[v1]-32-|", views: tableView, confirmButton)
        tableView.horizontal(toView: view)
        confirmButton.horizontal(toView: view, space: padding)
        
        addState()
        stateView?.setStateContent(state: .empty, imageName: nil, title: nil, content: "You didn't choose any foods")
        
        fetchData()
    }
    
    override func fetchData() {
        guard let foods = meal?.foods else { return }
        datasource = foods
        stateView?.state = foods.isEmpty ? .empty : .success
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            datasource.remove(at: indexPath.row)
        }
    }
}
