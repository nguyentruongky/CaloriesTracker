//
//  BottomSheet.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/29/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

class knBottomSheet: UIView {
    private let blackView = UIMaker.makeButton(background: UIColor.black.alpha(0.5))
    private let mainView = UIMaker.makeView(background: .white)
    private var popupOffset: CGFloat { return mainView.frame.origin.y }
    private var animationProgress: CGFloat = 0
    private var bottomConstraint = NSLayoutConstraint()
    private var transitionAnimator = UIViewPropertyAnimator()
    private var currentState: State = .closed
    private lazy var panView = makePanView()
    private lazy var tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(popupViewTapped))
    private var view = UIView()
    private let panHeight: CGFloat = 24
    
    let notchHeight: CGFloat = screenHeight * 0.75 - 100
    let sheetHeight: CGFloat = screenHeight * 0.75
    let containerView = UIMaker.makeView()
    
    convenience init(container: UIView) {
        self.init(frame: .zero)
        view = container
    }
    
    func setupView() {
        mainView.addSubviews(views: panView, containerView)
        panView.horizontal(toView: mainView)
        panView.top(toView: mainView)
        panView.height(panHeight)
        
        containerView.horizontal(toView: mainView)
        containerView.bottom(toView: mainView)
        containerView.height(sheetHeight)
        
        view.addSubviews(views: mainView)
        mainView.horizontal(toView: view)
        bottomConstraint = mainView.bottom(toView: view, space: notchHeight)
        mainView.height(sheetHeight + panHeight)
        
        panView.addGestureRecognizer(InstantPanGestureRecognizer(target: self, action: #selector(popupViewPanned)))
        panView.addGestureRecognizer(tapRecognizer)
        
        view.insertSubview(blackView, belowSubview: mainView)
        blackView.fill(toView: view)
        blackView.alpha = 0
        blackView.addTarget(self, action: #selector(hideSheet))
    }
    
    @objc private func popupViewTapped(recognizer: UITapGestureRecognizer) {
        animateTransitionIfNeeded(to: currentState.opposite, duration: 0.35)
    }
    
    func animateTransitionIfNeeded(to state: State, duration: Double) {
        transitionAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1, animations: {
            [weak self] in
            guard let `self` = self else { return }
            switch state {
            case .open:
                self.mainView.layer.cornerRadius = 20
                self.mainView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
                self.bottomConstraint.constant = 0
                self.blackView.alpha = 1
                
            case .closed:
                self.mainView.layer.cornerRadius = 0
                self.bottomConstraint.constant = self.notchHeight
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
                self.bottomConstraint.constant = self.notchHeight
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
            let translation = recognizer.translation(in: mainView)
            var fraction = -translation.y / popupOffset
            if currentState == .open { fraction *= -1 }
            if transitionAnimator.isReversed { fraction *= -1 }
            transitionAnimator.fractionComplete = fraction + animationProgress
        case .ended:
            let yVelocity = recognizer.velocity(in: mainView).y
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
    
    @objc func hideSheet() {
        animateTransitionIfNeeded(to: .closed, duration: 0.35)
    }
    
    func makePanView() -> UIView {
        let view = UIMaker.makeView(background: UIColor(value: 200))
        let panIndicator = UIMaker.makeView(background: UIColor.lightGray.alpha(0.5))
        view.addSubviews(views: panIndicator)
        panIndicator.size(CGSize(width: 75, height: 5))
        panIndicator.setCorner(radius: 2.5)
        panIndicator.center(toView: view)
        return view
    }
    
}

class InstantPanGestureRecognizer: UIPanGestureRecognizer {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if (self.state == UIGestureRecognizer.State.began) { return }
        super.touchesBegan(touches, with: event)
        self.state = UIGestureRecognizer.State.began
    }
}

extension knBottomSheet {
    enum State {
        case closed
        case open
    }
}

extension knBottomSheet.State {
    var opposite: knBottomSheet.State {
        switch self {
        case .open: return .closed
        case .closed: return .open
        }
    }
}
