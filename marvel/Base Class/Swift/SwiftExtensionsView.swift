//
//  SwiftExtensionsView.swift
//  marvel
//
//  Created by Jorge Lapeña Antón on 29/10/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import UIKit

//MARK: - RounedTextField
@IBDesignable
open class RounedTextField: UITextField {

    fileprivate let padding = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    
    @IBInspectable open var borderColor: UIColor = UIColor.black {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable open var borderWidth: CGFloat = 1 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable open var placeholderColor: UIColor = UIColor.gray {
        didSet {
            attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: placeholderColor])
        }
    }
    
    @IBInspectable open var cornerRadius: CGFloat = 10 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupUI()
    }
    
    private func setupUI() {
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: placeholderColor])
        clipsToBounds = true
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

//MARK: - RounedButton
@IBDesignable
open class RounedButton: UIButton {
    @IBInspectable open var background: UIColor = Color.colorText {
        didSet {
            backgroundColor = background
        }
    }
    
    @IBInspectable open var borderColor: UIColor = Color.colorText {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable open var cornerRadius: CGFloat = 10 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable open var borderWidth: CGFloat = 1 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable open var titleEdge: UIEdgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5) {
        didSet {
            contentEdgeInsets = titleEdge
        }
    }
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = background
        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        contentEdgeInsets = titleEdge
        clipsToBounds = true
    }
}


//MARK: - RounedShadowView
@IBDesignable
open class RounedShadowView: UIView {
    fileprivate let rectCorner: UIRectCorner = [UIRectCorner.topLeft, UIRectCorner.bottomLeft, UIRectCorner.topRight, UIRectCorner.bottomRight]
    
    @IBInspectable open var cornerRadius: CGFloat = 10 {
        didSet {
            addRoundCornersView(corners: rectCorner, radius: cornerRadius)
        }
    }
    
    @IBInspectable open var background: UIColor = Color.colorShadowView {
        didSet {
            backgroundColor = background
        }
    }
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupUI()
    }
    
    private func setupUI() {
        addRoundCornersView(corners: rectCorner, radius: cornerRadius)
        backgroundColor = background
    }
}

//MARK: - RounedBorderView
@IBDesignable
open class RounedBorderView: UIView {
    fileprivate let rectCorner: UIRectCorner = [UIRectCorner.topLeft, UIRectCorner.bottomLeft, UIRectCorner.topRight, UIRectCorner.bottomRight]
    
    @IBInspectable open var cornerRadius: CGFloat = 10 {
        didSet {
            addRoundCornersView(corners: rectCorner, radius: cornerRadius)
        }
    }
    
    @IBInspectable open var background: UIColor = Color.colorBorderView {
        didSet {
            backgroundColor = background
        }
    }
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupUI()
    }
    
    private func setupUI() {
        addRoundCornersView(corners: rectCorner, radius: cornerRadius)
        backgroundColor = background
    }
}

//MARK: - RounedContainerView
@IBDesignable
open class RounedContainerView: UIView {
    fileprivate let rectCorner: UIRectCorner = [UIRectCorner.topLeft, UIRectCorner.bottomLeft, UIRectCorner.topRight, UIRectCorner.bottomRight]
    
    @IBInspectable open var cornerRadius: CGFloat = 10 {
        didSet {
            addRoundCornersView(corners: rectCorner, radius: cornerRadius)
        }
    }
    
    @IBInspectable open var background: UIColor = UIColor.white {
        didSet {
            backgroundColor = background
        }
    }
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupUI()
    }
    
    private func setupUI() {
        addRoundCornersView(corners: rectCorner, radius: cornerRadius)
        backgroundColor = background
    }
}

