//
//  UIButtonExt.swift
//  post -app
//
//  Created by Sarthak Jha  on 26/04/20.
//  Copyright © 2020 Sarthak Jha . All rights reserved.
//

import UIKit

extension UIButton {
    func buttonSelectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.8615431328, blue: 0.1686274558, alpha: 1)
    }
    func unselectedButton() {
        self.backgroundColor = #colorLiteral(red: 0.5960784314, green: 1, blue: 0.5960784314, alpha: 1)
    }
}
