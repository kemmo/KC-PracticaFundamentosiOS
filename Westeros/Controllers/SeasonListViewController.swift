//
//  SeasonListViewController.swift
//  Westeros
//
//  Created by VINACHES LOPEZ JORGE on 02/03/2018.
//  Copyright © 2018 Jorge Vinaches. All rights reserved.
//

import UIKit

class SeasonListViewController: UITableViewController {
    
    // Mark: - Properties
    let model: [Season]

    // Mark: - Initialization
    init(model: [Season]) {
        self.model = model
        super.init(style: .plain)
        title = "Seasons"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        let seasonDetailViewController = SeasonDetailViewController(model: season)
        navigationController?.pushViewController(seasonDetailViewController, animated: true)
    }
}
