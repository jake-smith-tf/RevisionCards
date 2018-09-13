//
//  SubjectCell.swift
//  ProRevise:GCSE
//
//  Created by Jake Smith on 11/09/2018.
//  Copyright © 2018 Nebultek. All rights reserved.
//

import UIKit

class SubjectCell: UITableViewCell {

    let subjectName = UILabel()
    let icon = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        subjectName.translatesAutoresizingMaskIntoConstraints = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(subjectName)
        contentView.addSubview(icon)
        let iLeft = icon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10)
        let iCenter = icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0)
        let iHeight = icon.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9)
        let iWidth = icon.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9)
        contentView.addConstraints([iLeft,iCenter,iHeight,iWidth])
        let sLeft = subjectName.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 5)
        let sRight = subjectName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10)
        let sCenter = subjectName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0)
        let sHeight = subjectName.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9)
        
        self.separatorInset = UIEdgeInsets(top: 0, left: 54, bottom: 0, right: 0)
        contentView.addConstraints([sLeft,sCenter,sHeight,sRight])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
