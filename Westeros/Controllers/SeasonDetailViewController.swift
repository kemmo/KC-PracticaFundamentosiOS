//
//  SeasonDetailViewController.swift
//  Westeros
//
//  Created by VINACHES LOPEZ JORGE on 02/03/2018.
//  Copyright © 2018 Jorge Vinaches. All rights reserved.
//

import UIKit

class SeasonDetailViewController: UIViewController {

    // Mark: - Properties
    var model: Season
    
    // Mark: - Initialization
    init(model: Season) {
        self.model = model
        
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupUI()
        syncModelWithView()
    }
    
    // Mark: - Sync
    func syncModelWithView() {
        title = model.name

    }
    
    // Mark: - UI
    func setupUI() {
        let episodesButton = UIBarButtonItem(title: "Episodes", style: .plain, target: self, action: #selector(displayEpisodes))
        
        navigationItem.rightBarButtonItems = [episodesButton]
    }
    
    @objc func displayEpisodes() {
        // Creamos el VC
        let episodeListViewController = EpisodeListViewController(model: model.sortedEpisodes)
        
        // Hacemos Push
        navigationController?.pushViewController(episodeListViewController, animated: true)
    }
}

extension SeasonDetailViewController: SeasonListViewControllerDelegate {
    func seasonListViewController(_ viewController: SeasonListViewController, didSelectSeason season: Season) {
        self.model = season
        syncModelWithView()
    }
}
