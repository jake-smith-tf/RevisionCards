//
//  UICard.swift
//  CardSimulator2
//
//  Created by Jake Smith on 10/09/2018.
//  Copyright © 2018 Nebultek. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class UICard: UIView,UIDynamicAnimatorDelegate {
    
    var animator:UIDynamicAnimator!
    var pan:UIPanGestureRecognizer!
    var attachment:UIAttachmentBehavior!
    var initialCenter: CGPoint!
    var delegate: UICardDelegate?
    
    @IBInspectable var cornerRadius: CGFloat = 10 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var flippable: Bool = false
    @IBInspectable var swipeLeft: Bool = false
    @IBInspectable var swipeRight: Bool = false
    @IBInspectable var swipeUp: Bool = false
    @IBInspectable var swipeDown: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = cornerRadius
    }
    
    enum Direction {
        case up
        case down
        case left
        case right
    }
    
    override func didMoveToSuperview() {
        layer.masksToBounds = false
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0.1
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.75
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 1
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        initialCenter = self.center
        if let superView = self.superview {
            animator = UIDynamicAnimator(referenceView: superView)
            animator.delegate = self
            pan = UIPanGestureRecognizer(target: self, action: #selector(self.panning))
            pan.maximumNumberOfTouches = 1
            self.addGestureRecognizer(pan)
        }
    }
    
    
    @objc func panning(panGesture:UIPanGestureRecognizer)
    {
        let panLocationInView = panGesture.location(in: self.superview!)
        let panLocationInCard = panGesture.location(in: self)
        let superWidth = self.superview!.frame.width
        let superHeight = self.superview!.frame.height
        switch (panGesture.state)
        {
            case UIGestureRecognizerState.began:
                animator.removeAllBehaviors()
                let offset = UIOffsetMake(panLocationInCard.x - self.bounds.midX, panLocationInCard.y - self.bounds.midY);
                attachment = UIAttachmentBehavior(item: self, offsetFromCenter: offset, attachedToAnchor: panLocationInView)
                animator.addBehavior(attachment)
            case UIGestureRecognizerState.changed:
                //alpha = 1 - (abs(panLocationInView.x-superWidth/2))/(superWidth/2)
                attachment.anchorPoint = panLocationInView
            default:
                if self.center.x < superWidth*0.25 && swipeLeft {
                    delegate?.swiped(sender: self, direction: .left)
                }
                else if self.center.x > superWidth*0.75 && swipeRight {
                    delegate?.swiped(sender: self, direction: .right)
                }
                else if self.center.y < superHeight*0.25 && swipeUp{
                    delegate?.swiped(sender: self, direction: .up)
                }
                else if self.center.y > superHeight*0.75 && swipeDown{
                    delegate?.swiped(sender: self, direction: .down)
                }
                else {
                    UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
                        self.animator.removeAllBehaviors()
                        self.transform = CGAffineTransform.init(rotationAngle: 0)
                        self.layoutIfNeeded()
                        if self.translatesAutoresizingMaskIntoConstraints == true
                        {
                            self.center = self.initialCenter
                        }
                    }, completion: nil)
                }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if flippable {
            UIView.transition(with: self, duration: 1, options: [.transitionFlipFromLeft], animations: {
                if let label = self.viewWithTag(1) as? UILabel
                {
                    switch(label.text)
                    {
                        default:
                            break
                    }
                }
            }, completion: nil)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}

protocol UICardDelegate {
    func swiped(sender: UICard, direction: UICard.Direction)
}


