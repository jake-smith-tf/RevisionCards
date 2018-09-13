//
//  ViewController.swift
//  ProRevise:GCSE
//
//  Created by Jake Smith on 11/09/2018.
//  Copyright © 2018 Nebultek. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController,UICardDelegate {
    
    
    var cards = [WelcomeCard]()
    var titles = ["Welcome to ProRevise","GCSE Mathematics","GCSE Physics","GCSE Chemistry","Good Luck with Your Revision!"]
    var images = [#imageLiteral(resourceName: "subjects"),#imageLiteral(resourceName: "graph"),#imageLiteral(resourceName: "physics"),#imageLiteral(resourceName: "chemistry"),#imageLiteral(resourceName: "crossedfingers")]
    var content = ["ProRevise is an award-winning educational toolkit to help promote rapid learning. \n\nThis app contains material relevant to Mathematics, Science and English GCSE.","We have a range of GCSE Mathematics topics including: \n\n➤ Geometry\n\n➤ Algebra\n\n➤ Graphing Techniques\n\n➤ Problem Solving","We have a range of GCSE Physics topics including: \n\n➤ Forces\n\n➤ Energy\n\n➤ Spring Constant\n\n➤ Cosmology","We have a range of GCSE Chemistry topics including: \n\n➤ Reactions\n\n➤ Rates of Reaction\n\n➤ Periodic Table\n\n➤ Electron Configurations","Good Luck! \n\nWe hope you find this application useful - we appreciate if you leave us a rating and feedback via the appstore, but in the meantime let's get revising!\n\n\nCopyright © 2018 DevSmith"]
    var swipeMessage = ["Swipe to continue","Our Physics Material","Our Chemistry Material","Credits","Go"]
    var bgColors = [#colorLiteral(red: 0.2851483822, green: 0.7824483514, blue: 0.9414985776, alpha: 1),#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1),#colorLiteral(red: 0.4083549986, green: 0.7647058964, blue: 0.3531913611, alpha: 1),#colorLiteral(red: 0.4383977661, green: 0.2796458125, blue: 1, alpha: 1)]
    var darkerColors = [UIColor]()
    var index = 0
    
    func swiped(sender: UICard, direction: UICard.Direction) {
        self.index += 1
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [.allowAnimatedContent,.allowUserInteraction], animations: {
            sender.animator.removeAllBehaviors()
            sender.center = CGPoint(x: self.view.frame.width + sender.frame.width, y: self.view.center.y)
            sender.layoutIfNeeded()
            self.view.backgroundColor = self.darkerColors[safe: self.index] ?? UIColor.white
            self.cards.forEach {
                $0.backgroundColor = self.bgColors[safe: self.index] ?? UIColor.white
            }
        }, completion: { completed in
            self.cards.removeFirst()
            sender.removeFromSuperview()
        })
        if self.index == self.titles.count {
            let navController = UINavigationController(rootViewController: SubjectsTBC(title: "Subjects", branch: nil))
            self.present(navController, animated: true, completion: nil)
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
        view.backgroundColor = bgColors.first?.darker() ?? UIColor.black
        bgColors.forEach { darkerColors.append($0.darker() ?? UIColor.white)}
        for i in 0..<titles.count {
            let newCard = WelcomeCard(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: sWidth*0.95, height: sHeight*0.9)))
            newCard.swipeRight = true
            newCard.delegate = self
            newCard.backgroundColor = bgColors.first
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

extension Collection {
    
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension UIColor {
    
    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }
    
    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }
    
    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
}


