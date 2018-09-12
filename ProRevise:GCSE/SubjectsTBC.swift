//
//  SubjectsTBC.swift
//  ProRevise:GCSE
//
//  Created by Jake Smith on 11/09/2018.
//  Copyright © 2018 Nebultek. All rights reserved.
//

import UIKit

class SubjectsTBC: UITableViewController {

    var subjects = ["GCSE Mathematics","GCSE Physics","GCSE Chemistry"]
    var subjectIcons = [#imageLiteral(resourceName: "graph"),#imageLiteral(resourceName: "physics"),#imageLiteral(resourceName: "chemistry")]
    var iconColors = [#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1),#colorLiteral(red: 0.4083549986, green: 0.7647058964, blue: 0.3531913611, alpha: 1)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Subjects"
        tableView.register(SubjectCell.self, forCellReuseIdentifier: "subjectCell")
        tableView.rowHeight = 44
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        let topicVC = TopicsTBC(selectedName: subjects[indexPath.item],isSubject: true)
        topicVC.subjectColor = iconColors[indexPath.item]
        navigationController?.pushViewController(topicVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subjectCell", for: indexPath) as! SubjectCell
        cell.accessoryType = .disclosureIndicator
        cell.icon.image = subjectIcons[indexPath.item]
        cell.icon.tintColor = iconColors[indexPath.item]
        cell.subjectName.text = subjects[indexPath.item]

        return cell
    }

}
