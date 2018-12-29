//
//  AddMeal.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/21/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class CTAddMealCtr: knGridController<CTFoodCell, CTFood>, CTBottomSheetDelegate {
    lazy var output = Interactor(controller: self)
    var checkoutButton: knBarButtonNumber!
    lazy var bottomSheet = knBottomSheet(container: view)
    let mealOptionView = CTMealOptionView()
    
    override func setupView() {
        title = "NEW MEAL"
        navBarHidden = .show
        
        addCartButton()
        addBackButton(tintColor: .CT_25)

        layout = UICollectionViewFlowLayout()
        itemSize = CGSize(width: screenWidth / 2 - 8, height: 250)
        
        let fitBottomHeight: CGFloat = screenHeight * 0.75 - 100
        let sheetHeight: CGFloat = screenHeight * 0.75
        contentInset = UIEdgeInsets(top: 8, left: 8,
                                    bottom: sheetHeight - fitBottomHeight, right: 8)
        super.setupView()
        collectionView.backgroundColor = UIColor.bg
        view.addFill(collectionView)
        
        addState()
        
        bottomSheet.setupView()
        bottomSheet.containerView.addFill(mealOptionView)
        openSheetOnStart()
        
        fetchData()
    }
    
    func addCartButton() {
        let cartButton = UIMaker.makeButton(image: UIImage(named: "cart"))
        cartButton.addTarget(self, action: #selector(showCheckout))
        checkoutButton = knBarButtonNumber(view: cartButton)
        navigationItem.rightBarButtonItem = checkoutButton
    }

    override func fetchData() {
        stateView?.state = .loading
        output.getFoods()
    }
    
    func loadMore() {
        output.getMoreFoods()
    }
    
    @objc func showCheckout() {
        mealOptionView.saveMeal()
        let ctr = CTCheckoutCtr()
        ctr.meal = mealOptionView.meal
        ctr.addMealCtr = self
        present(wrap(ctr))
    }
    
    override func didSelectItem(at indexPath: IndexPath) {
        let ctr = CTFoodDetailCtr()
        ctr.foodList = self
        ctr.data = datasource[indexPath.row]
        push(ctr)
    }
    
    override func getCell(at indexPath: IndexPath) -> CTFoodCell {
        let cell = super.getCell(at: indexPath)
        cell.parent = self
        return cell
    }
    
    func selectFood(_ food: CTFood) {
        mealOptionView.meal.foods.append(food)
        checkoutButton.increase(amount: 1)
        guard let index = datasource.firstIndex(of: food) else { return }
        let cell = getCell(forItem: index)
        cell?.setSelected(true)
    }
    
    func removeFood(_ food: CTFood) {
        if let index = mealOptionView.meal.foods.firstIndex(of: food) {
            mealOptionView.meal.foods.remove(at: index)
            checkoutButton.descrease(amount: 1)
        }
        
        if let index = datasource.firstIndex(of: food) {
            let cell = getCell(forItem: index)
            cell?.setSelected(false)
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.contentSize.height > 0 else { return }
        if scrollView.contentOffset.y > scrollView.contentSize.height - screenHeight - 100 {
            loadMore()
        }
    }

    @objc func hideSheet() {
        bottomSheet.animateTransitionIfNeeded(to: .closed, duration: 0.35)
    }
    
    func openSheetOnStart() {
        run({ [weak self] in
            self?.bottomSheet.animateTransitionIfNeeded(to: .open, duration: 0.35)
            }, after: 0.1)
    }
}
