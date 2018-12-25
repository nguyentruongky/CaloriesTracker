//
//  BarButtonBadge.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/25/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

class knBarButtonNumber: UIBarButtonItem {
    var badgeValue: String = "" {
        didSet {
            if (badgeValue == "" || badgeValue == "0") {
                removeBadge()
            } else {
                badgeLabel.isHidden = false
                updateBadgeValueAnimated(true)
            }
        }
    }
    
    convenience init(view: UIView) {
        self.init()
        customView = view
        setupView()
    }
    
    func setupView() {
        badgeLabel.frame = CGRect(x: badgeOriX, y: badgeOriY, width: 20, height: 20)
        badgeLabel.textColor = badgeTextColor
        badgeLabel.backgroundColor = badgeColor
        badgeLabel.font = badgeFont
        badgeLabel.textAlignment = .center
        badgeLabel.isHidden = true
        
        customView?.addSubview(badgeLabel)
    }
    
    var badgeColor = UIColor.red { didSet { refreshBadge() }}
    var badgeTextColor = UIColor.white { didSet { refreshBadge() }}
    var badgeFont = UIFont.systemFont(ofSize: 12) { didSet { refreshBadge() }}
    var badgePadding: CGFloat = 3 { didSet { refreshBadge() }}
    var badgeMinSize: CGFloat = 0 { didSet { refreshBadge() }}
    var badgeOriX: CGFloat = 13 { didSet { updateBadgeFrame() }}
    var badgeOriY: CGFloat = -9 { didSet { updateBadgeFrame() }}
    var shouldHideBadgeAtZero = true
    var shouldAnimateBadge = true
    private let badgeLabel = UILabel()
    
    private func updateBadgeFrame() {
        let frameLabel = badgeLabel
        frameLabel.sizeToFit()
        
        let expectedLabelSize = frameLabel.frame.size
        var minHeight = expectedLabelSize.height
        minHeight = minHeight < self.badgeMinSize ? self.badgeMinSize : minHeight
        var minWidth = expectedLabelSize.width
        minWidth = minWidth < minHeight ? minHeight : minWidth
        
        let padding = badgePadding
        badgeLabel.frame = CGRect(x: self.badgeOriX, y: self.badgeOriY, width: minWidth + padding, height: minHeight + padding)
        
        badgeLabel.layer.cornerRadius = (minHeight + padding) / 2
        badgeLabel.layer.masksToBounds = true
    }
    
    private func refreshBadge() {
        badgeLabel.textColor = self.badgeTextColor
        badgeLabel.backgroundColor = self.badgeColor
        badgeLabel.font = self.badgeFont
    }
    
    private func resetBadge() {
        badgeValue = "0"
    }
    
    private func updateBadgeValueAnimated(_ animated: Bool) {
        if (animated && shouldAnimateBadge && !(badgeLabel.text == badgeValue)) {
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.fromValue = 1.5
            animation.toValue = 1.0
            animation.duration = 0.2
            animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 1.3, 1, 1)
            badgeLabel.layer.add(animation, forKey: "bounceAnimation")
        }
        badgeLabel.text = self.badgeValue
        updateBadgeFrame()
    }
    
    func increase(amount: Int) {
        guard let value = Int(badgeValue) else { badgeValue = "1"; return }
        badgeValue = String(amount + value)
    }
    
    func descrease(amount: Int) {
        guard let value = Int(badgeValue) else { return }
        badgeValue = String(amount - value)
    }
    
    private func removeBadge() {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.badgeLabel.isHidden = true
        })
    }
}

