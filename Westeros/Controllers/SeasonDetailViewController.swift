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
        title = model.name
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


