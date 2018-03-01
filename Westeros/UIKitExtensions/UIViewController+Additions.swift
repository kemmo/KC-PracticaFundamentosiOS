//
//  UIViewController+Additions.swift
//  Westeros
//
//  Created by Jorge Vinaches on 13/02/2018.
//  Copyright © 2018 Jorge Vinaches. All rights reserved.
//

import UIKit

extension UIViewController {
    func wrappedInNavigation() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}
