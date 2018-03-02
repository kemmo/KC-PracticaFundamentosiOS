//
//  SeasonListViewController.swift
//  Westeros
//
//  Created by VINACHES LOPEZ JORGE on 02/03/2018.
//  Copyright © 2018 Jorge Vinaches. All rights reserved.
//

import UIKit

let SEASON_KEY = "SEASON_KEY"
let SEASON_DID_CHANGE_NOTIFICATION_NAME = "SEASON_DID_CHANGE_NOTIFICATION_NAME"
let LAST_SEASON = "LAST_SEASON"

protocol SeasonListViewControllerDelegate: class {
    func seasonListViewController(_ viewController: SeasonListViewController, didSelectSeason: Season)
}

class SeasonListViewController: UITableViewController {
    
    // Mark: - Properties
    let model: [Season]
    weak var delegate: SeasonListViewControllerDelegate?

    // Mark: - Initialization
    init(model: [Season]) {
        self.model = model
        super.init(style: .plain)
        title = "Seasons"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let lastRow = UserDefaults.standard.integer(forKey: LAST_SEASON)
        let indexPath = IndexPath(row: lastRow, section: 0)
        
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "SeasonCell"
        
        let season = model[indexPath.row]
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        cell?.textLabel?.text = season.name
        
        return cell!
    }
    
    // Mark: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let season = model[indexPath.row]
        
        delegate?.seasonListViewController(self, didSelectSeason: season)

        let notificationCenter = NotificationCenter.default
        
        let notification = Notification(name: Notification.Name(SEASON_DID_CHANGE_NOTIFICATION_NAME), object: self, userInfo: [SEASON_KEY : season])
        
        notificationCenter.post(notification)
        
        saveLastSelectedSeason(at: indexPath.row)
    }
}

extension SeasonListViewController {
    func saveLastSelectedSeason(at row: Int) {
        let defaults = UserDefaults.standard
        defaults.set(row, forKey: LAST_SEASON)

        defaults.synchronize()
    }
    
    func lastSelectedSeason() -> Season {
        let row = UserDefaults.standard.integer(forKey: LAST_SEASON)
        let season = model[row]
        return season
    }
}
