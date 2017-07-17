//
//  AboutVC.swift
//  Foodie
//
//  Created by Eduardo Pacheco on 14/07/17.
//  Copyright © 2017 Eduardo Pacheco. All rights reserved.
//

import UIKit
import SafariServices

class AboutVC: UITableViewController {

    // MARK: - Properties
    fileprivate let sectionTitles = ["Leave Feedback", "Follow Me"]
    fileprivate let sectionContent = [["Rate on App Store", "Leave your feedback"], ["Twitter", "GitHub"]]
    fileprivate let links = ["https://twitter.com/JuaneBaster", "https://github.com/edbaster"]

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionContent[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "aboutCell", for: indexPath)
        cell.textLabel?.text = sectionContent[indexPath.section][indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var linkString = ""
        switch indexPath.section {
            case 0: if indexPath.row == 0 { linkString = "http://www.apple.com/itunes/charts/paid-apps/" }
            case 1: linkString = links[indexPath.row]
            default: break
        }
        guard let linkURL = URL(string: linkString) else { return }
        let sfController = SFSafariViewController(url: linkURL)
        present(sfController, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
