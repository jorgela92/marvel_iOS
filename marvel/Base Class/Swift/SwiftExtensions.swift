//
//  SwiftExtensions.swift
//  marvel
//
//  Created by Jorge Lapeña Antón on 28/10/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import Foundation
import UIKit

// MARK: - String
extension String {
    var localized: String {
        get {
            return NSLocalizedString(self, comment: "")
        }
    }
    var htmlToAttributedString: NSAttributedString? {
           guard let data = data(using: .utf8) else { return nil }
           do {
               return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
           } catch {
               return nil
           }
       }
}

// MARK: - UIImage
extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

// MARK: - UIView
extension UIView {
    func addRoundCornersView(corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            var maskedCorners = CACornerMask()
            if corners.contains(.bottomLeft) {
                maskedCorners.insert(.layerMinXMaxYCorner)
            }
            if corners.contains(.bottomRight) {
                maskedCorners.insert(.layerMaxXMaxYCorner)
            }
            if corners.contains(.topLeft) {
                maskedCorners.insert(.layerMinXMinYCorner)
            }
            if corners.contains(.topRight) {
                maskedCorners.insert(.layerMaxXMinYCorner)
            }
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = maskedCorners
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.frame = bounds
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
}

// MARK: - StructDecodable
protocol StructDecodable: Decodable {
    static func getModelFrom(_ data: Data) -> Self?
}

extension StructDecodable {
    static func getModelFrom(_ data: Data) -> Self? {
        do {
            return try JSONDecoder().decode(Self.self, from: data)
        } catch {
            return nil
        }
    }
}

//MARK: - UIViewController
extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return UIStoryboard.init(name: String(describing: T.self), bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: T.self)) as! T
        }
        return instantiateFromNib()
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
