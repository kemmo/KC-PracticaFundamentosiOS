//
//  MemberDetailViewController.swift
//  Westeros
//
//  Created by VINACHES LOPEZ JORGE on 04/03/2018.
//  Copyright © 2018 Jorge Vinaches. All rights reserved.
//

import UIKit

class MemberDetailViewController: UIViewController {

    // Mark: - Properties
    let model: Person
    
    init(model: Person) {
        self.model = model
        
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = model.fullName
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Nos damos de alta ...
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(houseDidChange), name: Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Nos damos de baja ...
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    // MARK: - Notifications
    @objc func houseDidChange(notification: Notification) {
        navigationController?.popToRootViewController(animated: true)
    }
}
