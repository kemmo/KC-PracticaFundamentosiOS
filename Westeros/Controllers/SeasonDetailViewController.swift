//
//  SeasonDetailViewController.swift
//  Westeros
//
//  Created by VINACHES LOPEZ JORGE on 02/03/2018.
//  Copyright © 2018 Jorge Vinaches. All rights reserved.
//

import UIKit

class SeasonDetailViewController: UIViewController {

    // Mark: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var episodesView: UIView!
    
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

        syncModelWithView()
    }
    
    // Mark: - Sync
    func syncModelWithView() {
        title = model.name
        titleLabel.text = model.name
        subtitleLabel.text = model.description
        
        let episodeListViewController = EpisodeListViewController(model: model.sortedEpisodes)
        
        addChildViewController(episodeListViewController)
        episodeListViewController.view.translatesAutoresizingMaskIntoConstraints = false
        episodesView.addSubview(episodeListViewController.view)
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

