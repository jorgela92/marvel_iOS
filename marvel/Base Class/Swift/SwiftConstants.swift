//
//  SwiftConstants.swift
//  marvel
//
//  Created by Jorge Lapeña Antón on 28/10/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import UIKit

// MARK - Color
struct Color {
    static let colorNavigationBar = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
    static let colorPrivateBackgraund = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    static let colorText = UIColor(red: 24/255, green: 24/255, blue: 24/255, alpha: 1)
    static let colorTextRed = UIColor(red: 240/255, green: 20/255, blue: 30/255, alpha: 1)
    static let colorShadowView = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
    static let colorBorderView = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
    static let colorContainerView = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    static let colorShadowViewSearch = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
}

// MARK - Storyboard
struct Storyboard {
    static let main = "Main"
}

// MARK - Screen
struct Screen {
    static var height: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    static var width: CGFloat {
        return UIScreen.main.bounds.size.width
    }
}
