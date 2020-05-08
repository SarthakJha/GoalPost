//
//  UIViewControllerExt.swift
//  post -app
//
//  Created by Sarthak Jha  on 24/04/20.
//  Copyright © 2020 Sarthak Jha . All rights reserved.
//

import UIKit

extension UIViewController {
    //this extension handles transition animation of a viewController
    
    //func to present a new screen
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false , completion: nil)
        
    }
    //func when the screen is to be dismissed
    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.3
               transition.type = CATransitionType.push
               transition.subtype = CATransitionSubtype.fromLeft
               self.view.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
    }
    
}
