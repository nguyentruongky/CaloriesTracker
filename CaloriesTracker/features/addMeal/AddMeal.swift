//
//  AddMeal.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/21/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class CTAddMealCtr: knGridController<CTFoodCell, CTFood> {
    lazy var output = Interactor(controller: self)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hideBar(false)
    }
    
    override func setupView() {
        title = "NEW MEAL"
        hidesBottomBarWhenPushed = true
        navigationController?.hideBar(false)
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
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 76, right: 8)
        setupBottomView()
        
        fetchData()
    }
    
    override func fetchData() {
        addState()
        stateView?.state = .loading
        output.getFoods()
    }
    
    func loadMore() {
        output.getMoreFoods()
    }
    
    // MARK: BOTTOM SHEET
    
    let blackView = UIMaker.makeView(background: UIColor.black.alpha(0.5))
    let bottomView = CTMealOptionView()
    var popupOffset: CGFloat { return bottomView.frame.origin.y }
    private var animationProgress: CGFloat = 0
    private var bottomConstraint = NSLayoutConstraint()
    var transitionAnimator = UIViewPropertyAnimator()
    private var currentState: State = .closed
    let fitBottomHeight: CGFloat = 400
    let sheetHeight: CGFloat = 500
    
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(popupViewTapped))
        return recognizer
    }()
    
    private func setupBottomView() {
        bottomView.delegate = self
        view.addSubview(bottomView)
        bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomConstraint = bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: fitBottomHeight)
        bottomConstraint.isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: sheetHeight).isActive = true
        
        bottomView.panView.addGestureRecognizer(InstantPanGestureRecognizer(target: self, action: #selector(popupViewPanned)))
        bottomView.panView.addGestureRecognizer(tapRecognizer)
        
        view.insertSubview(blackView, belowSubview: bottomView)
        blackView.fill(toView: view)
        blackView.alpha = 0
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
                self.bottomView.layer.cornerRadius = 20
                self.bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
                self.bottomConstraint.constant = 0
                self.blackView.alpha = 1
                
            case .closed:
                self.bottomView.layer.cornerRadius = 0
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
            let translation = recognizer.translation(in: bottomView)
            var fraction = -translation.y / popupOffset
            if currentState == .open { fraction *= -1 }
            if transitionAnimator.isReversed { fraction *= -1 }
            transitionAnimator.fractionComplete = fraction + animationProgress
        case .ended:
            let yVelocity = recognizer.velocity(in: bottomView).y
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
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.contentSize.height > 0 else { return }
        if scrollView.contentOffset.y > scrollView.contentSize.height - screenHeight - 100 {
            loadMore()
        }
    }
}

extension CTAddMealCtr: CTBottomSheetDelegate {
    func hideSheet() {
        animateTransitionIfNeeded(to: currentState.opposite, duration: 0.35)
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
