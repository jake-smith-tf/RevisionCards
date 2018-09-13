//
//  ViewController.swift
//  ProRevise:GCSE
//
//  Created by Jake Smith on 11/09/2018.
//  Copyright © 2018 Nebultek. All rights reserved.
//

import UIKit

class RevisionCards: UIViewController,UICardDelegate {
    
    
    var cards = [WelcomeCard]()
    var titles = [String]()
    var images = [UIImage]()
    var content = [String]()
    var swipeMessage = [String]()
    var bgColors = [UIColor]()
    var index = 0
    var subjectColor = UIColor()
    
    func swiped(sender: UICard, direction: UICard.Direction) {
        self.index += 1
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [.allowAnimatedContent], animations: {
            sender.animator.removeAllBehaviors()
            sender.center = CGPoint(x: self.view.frame.width + sender.frame.width, y: self.view.center.y)
            sender.layoutIfNeeded()
        }, completion: { completed in
            self.cards.removeFirst()
            sender.removeFromSuperview()
        })
        if self.index == self.titles.count {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (context) in
            self.cards.forEach {
                $0.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: coordinator.containerView.frame.width*0.95, height: coordinator.containerView.frame.height*0.9))
                $0.center = context.containerView.center
                $0.initialCenter = $0.center
                $0.updateConstraints()
                $0.layoutIfNeeded()
                $0.textView.updateTextFont(maxSize: 20)
                
            }
        }, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sWidth = view.frame.width
        let sHeight = view.frame.height
        view.backgroundColor = subjectColor.darker() ?? UIColor.black
        for i in 0..<titles.count {
            let newCard = WelcomeCard(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: sWidth*0.95, height: sHeight*0.9)))
            newCard.swipeRight = true
            newCard.delegate = self
            newCard.backgroundColor = subjectColor
            let spacing: CGFloat = CGFloat(i)
            newCard.title.sizeToFit()
            newCard.title.updateConstraints()
            newCard.center.x = view.center.x
            newCard.center.y = view.center.y - spacing + sHeight*0.0225
            newCard.cornerRadius = 20
            newCard.layer.zPosition = CGFloat(-i)
            newCard.title.text = titles[safe: i] ?? ""
            newCard.image.image = images[safe: i] ?? UIImage()
            newCard.image.tintColor = UIColor.white
            newCard.textView.text = content[safe: i] ?? ""
            newCard.swipeText.text = swipeMessage[safe: i] ?? "Next"
            cards.append(newCard)
            view.addSubview(newCard)
            view.sendSubview(toBack: newCard)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}


