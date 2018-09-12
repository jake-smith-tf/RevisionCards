//
//  SubjectsTBC.swift
//  ProRevise:GCSE
//
//  Created by Jake Smith on 11/09/2018.
//  Copyright © 2018 Nebultek. All rights reserved.
//

import UIKit

class TopicsTBC: UITableViewController {
    
    var selectedName: String!
    var isSubject: Bool!
    var topics = ["GCSE Mathematics":["Number","Algebra","Ratio, proportion and rates","Geometry and measures","Probability","Statistics"],
                  "GCSE Physics":["Energy","Electricity","Particle model of matter","Atomic Structure","Forces","Waves","Magnetism and electromagnetism","Space physics","Key ideas"],
                  "GCSE Chemistry":["Atomic structure and the periodic table","Bonding, structure & properties of matter","Quantitatve chemistry","Chemical changes","Energy changes","The rate and extent of chemical change","Organic chemistry","Chemical analysis","Chemistry of the atmosphere","Using resources","Key ideas"]]
    var subtopics = ["Number":["Structure and calculation","Fractions, decimals and percentages","Measures and accuracy"]]
    
    var subjectColor: UIColor?
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(selectedName: String,isSubject:Bool) {
        self.selectedName = selectedName
        self.isSubject = isSubject
        super.init(style: .plain)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedName
        tableView.separatorColor = subjectColor?.darker()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "subjectCell")
        tableView.rowHeight = 44
        tableView.tableFooterView = UIView()
        self.view.backgroundColor = subjectColor?.darker()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count: Int
        if isSubject {
            count = topics[selectedName]?.count ?? 0
        }
        else {
            count = subtopics[selectedName]?.count ?? 0
        }
        return count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        let subtopicsVC = TopicsTBC(selectedName: topics[selectedName]?[indexPath.item] ?? "", isSubject: false)
        subtopicsVC.subjectColor = self.subjectColor
        navigationController?.pushViewController(subtopicsVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subjectCell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        if isSubject {
            cell.textLabel?.text = topics[selectedName]?[indexPath.item]
        }
        else {
            cell.textLabel?.text = subtopics[selectedName]?[indexPath.item]
        }
        cell.textLabel?.textColor = UIColor.white
        cell.separatorInset = UIEdgeInsets.zero
        cell.backgroundColor = subjectColor?.darker(by: CGFloat(2*indexPath.item).truncatingRemainder(dividingBy: 100)) ?? UIColor.white
        
        return cell
    }
    
}
