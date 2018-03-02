//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by VINACHES LOPEZ JORGE on 02/03/2018.
//  Copyright © 2018 Jorge Vinaches. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    // Mark: - Properties
    var model: Episode
    
    // Mark: - Initialization
    init(model: Episode) {
        self.model = model
        
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        title = model.title
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
        
    }
    
    // Mark: - UI
    func setupUI() {
        
    }
    
}
