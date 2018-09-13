//
//  WelcomeCard.swift
//  ProRevise:GCSE
//
//  Created by Jake Smith on 11/09/2018.
//  Copyright © 2018 Nebultek. All rights reserved.
//

import Foundation
import UIKit

class WelcomeCard: UICard {
    
    var title: UILabel
    var image: UIImageView
    var textView: UITextView
    var arrow: UIImageView
    var swipeText: UILabel
    
    
    override init(frame: CGRect) {
        title = UILabel()
        image = UIImageView()
        textView = UITextView()
        arrow = UIImageView()
        swipeText = UILabel()
        super.init(frame: frame)
        addSubview(title)
        addSubview(image)
        addSubview(textView)
        addSubview(arrow)
        addSubview(swipeText)
        performLayout()
    }
    
    func performLayout()
    {
        title.translatesAutoresizingMaskIntoConstraints = false
        let titleHoz = title.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let titleTop = title.topAnchor.constraint(equalTo: self.topAnchor, constant: 20)
        let titleWidth = title.widthAnchor.constraint(equalToConstant: 0.8*self.frame.width)
        self.addConstraints([titleHoz,titleTop,titleWidth])
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 40, weight: .medium)
        title.textColor = UIColor.white
        title.lineBreakMode = .byClipping
        title.adjustsFontSizeToFitWidth = true
        title.minimumScaleFactor = 0.5
        image.translatesAutoresizingMaskIntoConstraints = false
        let imgTop = image.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10)
        let imgHeight = image.heightAnchor.constraint(lessThanOrEqualToConstant: 100)
        let imgWidth = image.widthAnchor.constraint(equalTo: image.heightAnchor, multiplier: 1)
        let imgCenter = image.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)
        
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        self.addConstraints([imgTop,imgWidth,imgHeight,imgCenter])
        textView.translatesAutoresizingMaskIntoConstraints = false
        let tvHoz = textView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let tvTop = textView.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10)
        let tvWidth = textView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9)
        let tvBottom = textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50)
        self.addConstraints([tvHoz,tvTop,tvWidth,tvBottom])
        textView.backgroundColor = UIColor.clear
        textView.isEditable = false
        textView.isSelectable = false
        textView.isUserInteractionEnabled = false
        textView.textColor = UIColor.white
        textView.textAlignment = .center
        textView.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        arrow.translatesAutoresizingMaskIntoConstraints = false
        arrow.tintColor = UIColor.white
        arrow.image = #imageLiteral(resourceName: "arrow")
        let arrBottom = arrow.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        let arrRight = arrow.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10)
        let arrTop = arrow.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 10)
        let arrWidth = arrow.widthAnchor.constraint(equalTo: arrow.heightAnchor, multiplier: 1)
        self.addConstraints([arrBottom,arrRight,arrTop,arrWidth])
        swipeText.translatesAutoresizingMaskIntoConstraints = false
        swipeText.textAlignment = .right
        swipeText.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        swipeText.lineBreakMode = .byCharWrapping
        swipeText.minimumScaleFactor = 0.8
        swipeText.adjustsFontSizeToFitWidth = true
        swipeText.textColor = UIColor.white
        let swipeTop = swipeText.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 10)
        let swipeBottom = swipeText.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        let swipeRight = swipeText.rightAnchor.constraint(equalTo: arrow.leftAnchor, constant: -10)
        let swipeLeft = swipeText.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10)
        self.addConstraints([swipeTop,swipeBottom,swipeRight,swipeLeft])
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        UIView.transition(with: image, duration: 1, options: [], animations: {
            self.image.transform = CGAffineTransform.init(rotationAngle: 2*CGFloat.pi)
        }, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
    }
    
    
}

extension UITextView {
    func updateTextFont(maxSize: CGFloat?) {
        if (self.text.isEmpty || self.bounds.size.equalTo(CGSize.zero)) {
            return;
        }
        
        
        
        let textViewSize = self.frame.size;
        let fixedWidth = textViewSize.width;
        let expectSize = self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT)))
        print(font!.pointSize,self.text)
        
        var expectFont = self.font
        if (expectSize.height > textViewSize.height) {
            
            while (self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT))).height > textViewSize.height) {
                if self.font!.pointSize < 18 {
                    self.text = self.text.replacingOccurrences(of: "\n\n", with: " \n")
                }
                expectFont = self.font!.withSize(self.font!.pointSize - 1)
                self.font = expectFont
            }
        }
        else {
            while (self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT))).height < textViewSize.height && Int(self.font!.pointSize) < Int(maxSize ?? CGFloat.infinity)) {
                if self.font!.pointSize > 18 {
                    self.text = self.text.replacingOccurrences(of: " \n", with: "\n\n")
                }
                expectFont = self.font
                self.font = self.font!.withSize(self.font!.pointSize + 1)
            }
            self.font = expectFont
        }
    }
}
