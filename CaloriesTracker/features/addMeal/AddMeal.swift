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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hideBar(false)
    }
    
    override func setupView() {
        title = "NEW MEAL"
        hidesBottomBarWhenPushed = true
        navigationController?.hideBar(false)
        
        let cartButton = UIMaker.makeButton(image: UIImage(named: "cart"))
        cartButton.addTarget(self, action: #selector(showCheckout))
        checkoutButton = knBarButtonNumber(view: cartButton)
        navigationItem.rightBarButtonItem = checkoutButton
        
        addBackButton(tintColor: .CT_25)

        layout = UICollectionViewFlowLayout()
        contentInset = UIEdgeInsets.zero
        lineSpacing = 0
        columnSpacing = 0
        let width = (screenWidth) / 2 - 8
        itemSize = CGSize(width: width, height: 250)
        super.setupView()
        collectionView.backgroundColor = UIColor.bg
        view.addSubviews(views: collectionView)
        collectionView.fill(toView: view)
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8,
                                                   bottom: sheetHeight - fitBottomHeight,
                                                   right: 8)
        addState()
        
        setupBottomView()
        fetchData()
        run({ [weak self] in
            self?.animateTransitionIfNeeded(to: .open, duration: 0.35)
            }, after: 0.1)
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
    
    // MARK: BOTTOM SHEET
    
    let blackView = UIMaker.makeButton(background: UIColor.black.alpha(0.5))
    let mealOptionView = CTMealOptionView()
    var popupOffset: CGFloat { return mealOptionView.frame.origin.y }
    private var animationProgress: CGFloat = 0
    private var bottomConstraint = NSLayoutConstraint()
    var transitionAnimator = UIViewPropertyAnimator()
    private var currentState: State = .closed
    let fitBottomHeight: CGFloat = screenHeight * 0.75 - 100
    let sheetHeight: CGFloat = screenHeight * 0.75
    lazy var tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(popupViewTapped))
    
    private func setupBottomView() {
        mealOptionView.delegate = self
        view.addSubview(mealOptionView)
        mealOptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mealOptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomConstraint = mealOptionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: fitBottomHeight)
        bottomConstraint.isActive = true
        mealOptionView.heightAnchor.constraint(equalToConstant: sheetHeight).isActive = true
        
        mealOptionView.panView.addGestureRecognizer(InstantPanGestureRecognizer(target: self, action: #selector(popupViewPanned)))
        mealOptionView.panView.addGestureRecognizer(tapRecognizer)
        
        
        view.insertSubview(blackView, belowSubview: mealOptionView)
        blackView.fill(toView: view)
        blackView.alpha = 0
        blackView.addTarget(self, action: #selector(hideSheet))
    }
    
    @objc private func popupViewTapped(recognizer: UITapGestureRecognizer) {
        animateTransitionIfNeeded(to: currentState.opposite, duration: 0.35)
    }
    
    private func animateTransitionIfNeeded(to state: State, duration: Double) {
        transitionAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1, animations: {
            [weak self] in
            guard let `self` = self else { return }
            switch state {
            case .open:
                self.mealOptionView.layer.cornerRadius = 20
                self.mealOptionView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
                self.bottomConstraint.constant = 0
                self.blackView.alpha = 1
                
            case .closed:
                self.mealOptionView.layer.cornerRadius = 0
                self.bottomConstraint.constant = self.fitBottomHeight
                self.blackView.alpha = 0
            }
            self.view.layoutIfNeeded()
        })
        transitionAnimator.addCompletion { [weak self] position in
            guard let `self` = self else { return }
            switch position {
            case .start:
                self.currentState = state.opposite
            case .end:
                self.currentState = state
            case .current:
                ()
            }
            switch self.currentState {
            case .open:
                self.bottomConstraint.constant = 0
                
            case .closed:
                self.bottomConstraint.constant = self.fitBottomHeight
            }
        }
        transitionAnimator.startAnimation()
    }
    
    @objc private func popupViewPanned(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            animationProgress = transitionAnimator.fractionComplete
            animateTransitionIfNeeded(to: currentState.opposite, duration: 0.35)
            transitionAnimator.pauseAnimation()
        case .changed:
            let translation = recognizer.translation(in: mealOptionView)
            var fraction = -translation.y / popupOffset
            if currentState == .open { fraction *= -1 }
            if transitionAnimator.isReversed { fraction *= -1 }
            transitionAnimator.fractionComplete = fraction + animationProgress
        case .ended:
            let yVelocity = recognizer.velocity(in: mealOptionView).y
            let shouldClose = yVelocity > 0
            if yVelocity == 0 {
                transitionAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                break
            }
            switch currentState {
            case .open:
                if !shouldClose && !transitionAnimator.isReversed { transitionAnimator.isReversed = !transitionAnimator.isReversed }
                if shouldClose && transitionAnimator.isReversed { transitionAnimator.isReversed = !transitionAnimator.isReversed }
            case .closed:
                if shouldClose && !transitionAnimator.isReversed { transitionAnimator.isReversed = !transitionAnimator.isReversed }
                if !shouldClose && transitionAnimator.isReversed { transitionAnimator.isReversed = !transitionAnimator.isReversed }
            }
            transitionAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        default:
            ()
        }
    }
    
    override func didSelectItem(at indexPath: IndexPath) {
        let ctr = CTFoodDetailCtr()
        ctr.data = datasource[indexPath.row]
        push(ctr)
    }
    
    override func getCell(at indexPath: IndexPath) -> CTFoodCell {
        let cell = super.getCell(at: indexPath)
        cell.parent = self
        cell.data = datasource[indexPath.row]
        return cell
    }
    
    func selectFood(_ food: CTFood) {
        mealOptionView.meal.foods.append(food)
        checkoutButton.increase(amount: 1)
        
        if let index = datasource.firstIndex(of: food) {
            let cell = collectionView.cellForItem(at: IndexPath(row: index, section: 0)) as? CTFoodCell
            cell?.removeButton.isHidden = false
        }
    }
    
    func removeFood(_ food: CTFood) {
        guard let index = mealOptionView.meal.foods.firstIndex(where: { return $0.id == food.id }) else { return }
        mealOptionView.meal.foods.remove(at: index)
        checkoutButton.descrease(amount: 1)
        
        if let index = datasource.firstIndex(of: food) {
            let cell = collectionView.cellForItem(at: IndexPath(row: index, section: 0)) as? CTFoodCell
            cell?.removeButton.isHidden = true
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.contentSize.height > 0 else { return }
        if scrollView.contentOffset.y > scrollView.contentSize.height - screenHeight - 100 {
            loadMore()
        }
    }
    
    @objc func hideSheet() {
        animateTransitionIfNeeded(to: .closed, duration: 0.35)
    }
}

class InstantPanGestureRecognizer: UIPanGestureRecognizer {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if (self.state == UIGestureRecognizer.State.began) { return }
        super.touchesBegan(touches, with: event)
        self.state = UIGestureRecognizer.State.began
    }
}

private enum State {
    case closed
    case open
}

extension State {
    var opposite: State {
        switch self {
        case .open: return .closed
        case .closed: return .open
        }
    }
}
