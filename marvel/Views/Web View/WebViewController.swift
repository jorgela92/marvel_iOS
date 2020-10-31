//
//  WebViewController.swift
//  marvel
//
//  Created by Jorge Lapeña Antón on 31/10/2020.
//  Copyright © 2020 qpple. All rights reserved.
//

import UIKit
import WebKit
import Lottie

class WebViewController: UIViewController {
    
    @IBOutlet fileprivate weak var animationView: AnimationView! {
        didSet {
            animationView.animation = Animation.named("loading_animation")
            animationView.loopMode = .loop
            animationView.contentMode = .scaleAspectFit
            animationView.play()
        }
    }
    
    fileprivate let webV = WKWebView(frame: .zero)
    fileprivate var alert: CustomAlertViewController?
    fileprivate var url: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

//MARK: - public methods -
extension WebViewController {
    func loadUrl(_ url: String) {
        self.url = url
    }
}

//MARK: - private methods -
private extension WebViewController {
    func configureUI() {
        webV.navigationDelegate = self
        webV.accessibilityIdentifier = "webV"
        webV.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webV)
        NSLayoutConstraint.activate([
            webV.leftAnchor.constraint(equalTo: view.leftAnchor),
            webV.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webV.rightAnchor.constraint(equalTo: view.rightAnchor),
            webV.topAnchor.constraint(equalTo: view.topAnchor)])
        webV.isHidden = true
        view.setNeedsLayout()
        guard let url = URL(string: url ?? ""), UIApplication.shared.canOpenURL(url) else {
            alert = CustomAlertViewController(imageViewName: nil, animationName: "error_animation", titleText: "error".localized.uppercased(), descriptionText: "error_web".localized, leftButtonTitle: nil, rightButtonTitle: "accept".localized.uppercased())
            alert?.delegate = self
            present(alert!, animated: true)
            return
        }
        webV.load(URLRequest(url: url))
    }
}

//MARK: - WKNavigationDelegate
extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        animationView.isHidden = true
        animationView.stop()
        webView.isHidden = false
    }
}

//MARK: - CustomAlertViewDelegate
extension WebViewController: CustomAlertViewDelegate {
    func leftAlertButtonClicked(tag: Int) {
        
    }
    
    func rightAlertButtonClicked(tag: Int) {
        alert?.dismiss(animated: true, completion: { [weak self] in
            guard let weakself = self else { return }
            weakself.dismiss(animated: true)
        })
    }
}
