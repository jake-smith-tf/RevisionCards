//
//  SubjectsTBC.swift
//  ProRevise:GCSE
//
//  Created by Jake Smith on 11/09/2018.
//  Copyright © 2018 Nebultek. All rights reserved.
//

import UIKit

class SubjectsTBC: UITableViewController {

    var subjectIcons = [#imageLiteral(resourceName: "graph"),#imageLiteral(resourceName: "physics"),#imageLiteral(resourceName: "chemistry")]
    var iconColors = [#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1),#colorLiteral(red: 0.4083549986, green: 0.7647058964, blue: 0.3531913611, alpha: 1)]
    var branchData = [String:Any]()
    var currentBranch = [String]()
    var subjectColor = UIColor()
    var endReached = false
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    init(title: String, branch: [String]?) {
        super.init(style: .plain)
        if let newBranch = branch {
            currentBranch = newBranch
            getBranchData()
        } else {
            loadFiles()
        }
        self.title = title
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SubjectCell.self, forCellReuseIdentifier: "subjectCell")
        tableView.rowHeight = 44
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension SubjectsTBC {
    
    func getBranchData() {
        branchData = LearnData.jsonTree
        currentBranch.forEach {
            if let nextBranch = branchData[$0] as? [String:Any] {
                branchData = nextBranch
            }
        }
        tableView.reloadData()
    }
    
    func loadFiles() {
        if !LearnData.jsonTree.isEmpty {
            return
        }
        if let path = Bundle.main.path(forResource: "revision", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                    LearnData.jsonTree = jsonResult
                    getBranchData()
                    tableView.reloadData()
                }
            } catch {
                print("Error parsing JSON to tree \(error)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return branchData.keys.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        let selectedCell = tableView.cellForRow(at: indexPath) as! SubjectCell
        if let cellText = selectedCell.subjectName.text {
            // Check if no cards are presents in next view
            if let cardsParent = branchData[cellText] as? [String:Any], let cards = cardsParent["cards"] as? [String:Any]
            {
                // MARK: Append cards and display card controller
                let revisionCards = RevisionCards()
                revisionCards.subjectColor = subjectColor
                cards.forEach { (key:String,val:Any) in
                    revisionCards.titles.append(key)
                    if let vals = val as? [String:String], let content = vals["content"], let image = UIImage(named: (vals["image"])!) {
                        revisionCards.content.append(content)
                        revisionCards.images.append(image)
                    }
                    
                }
                self.present(revisionCards, animated: true, completion: nil)
                
                
            } else {
                
                currentBranch.append(cellText)
                let nextVC = SubjectsTBC(title: cellText, branch: currentBranch)
                currentBranch.removeLast()
                if let parent = branchData[cellText] as? [String:Any], let color = parent["color"] as? String {
                    nextVC.subjectColor = UIColor(hex: color)
                } else {
                    nextVC.subjectColor = subjectColor
                }
                navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subjectCell", for: indexPath) as! SubjectCell
        cell.accessoryType = .disclosureIndicator
        cell.icon.image = #imageLiteral(resourceName: "physics") // TODO: Custom icons
        cell.icon.tintColor = UIColor.black // TODO: Custom colors
        
        cell.subjectName.text = Array(branchData.keys)[indexPath.item]
        
        return cell
    }
}

extension UIColor {
    convenience init (hex:String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: 1.0)
    }
}
