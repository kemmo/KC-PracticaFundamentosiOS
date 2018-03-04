//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by VINACHES LOPEZ JORGE on 02/03/2018.
//  Copyright © 2018 Jorge Vinaches. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    // Mark: - Outlets
    @IBOutlet weak var summaryTextView: UITextView!
    
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
        syncModelWithView()

        // Nos damos de alta ...
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(seasonDidChange), name: Notification.Name(SEASON_DID_CHANGE_NOTIFICATION_NAME), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Nos damos de baja ...
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    // MARK: - Notifications
    @objc func seasonDidChange(notification: Notification) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    // Mark: - Sync
    func syncModelWithView() {
        summaryTextView.text = model.summary
    }
}
