//
//  ConnectionsManager.swift
//  marvel
//
//  Created by Jorge Lapeña Antón on 28/10/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import Alamofire

class ConnectionsManager {
    
    fileprivate var HUD: HUDView!
    fileprivate var shadow: UIView!
    
    static let shared: ConnectionsManager = {
        return ConnectionsManager()
    }()
}

//MARK: - public methods -
extension ConnectionsManager {
    func request(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters? = nil, encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders? = nil, completion: @escaping(ResultResponse<Data>) -> ()) {
        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).response { (response) in
            switch response.result {
            case .success(let data):
                guard let data = data else {
                    completion(ResultResponse.error(ErrorModel(code: "", message: "generic_error".localized.capitalized)))
                    return
                }
                completion(ResultResponse.success(data))
                break
            case .failure(let error):
                completion(ResultResponse.error(ErrorModel(code: error.responseContentType ?? "", message: error.errorDescription ?? "")))
                break
            }
        }
    }
    
    func showHUD(_ text: String? = nil) {
        if !UIApplication.shared.isIgnoringInteractionEvents {
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
        
        DispatchQueue.main.async {
            if let window = UIApplication.shared.delegate?.window {
                if let text = text, let _ = self.HUD {
                    self.updateHUDText(text: text)
                    return
                }
                
                if let text = text, self.HUD == nil {
                    self.HUD = HUDView.init(text: text)
                    
                } else if self.HUD == nil {
                    self.HUD = HUDView.init()
                }
                
                if self.shadow == nil {
                    self.shadow = UIView()
                }
                
                window?.addSubview(self.shadow)
                self.shadow.translatesAutoresizingMaskIntoConstraints = false
                self.shadow.backgroundColor = .clear
                NSLayoutConstraint.activate([NSLayoutConstraint(item: self.shadow!, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: window, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0), NSLayoutConstraint(item: self.shadow!, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: window, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0), NSLayoutConstraint(item: self.shadow!, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: window, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0), NSLayoutConstraint(item: self.shadow!, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: window, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)])
                
                self.HUD.activityIndicator.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                window?.addSubview(self.HUD)
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.HUD?.activityIndicator.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                }, completion: { (completed) in
                    UIView.animate(withDuration: 0.2, animations: {
                        self.HUD?.activityIndicator.transform = CGAffineTransform.identity
                    })
                })
            }
        }
    }
    
    func hideHUD() {
        if UIApplication.shared.isIgnoringInteractionEvents {
            UIApplication.shared.endIgnoringInteractionEvents()
        }
        
        DispatchQueue.main.async {
            if let shadow = self.shadow {
                shadow.removeFromSuperview()
                self.shadow = nil
            }
            if let hud = self.HUD {
                hud.hide()
                self.HUD = nil
            }
        }
    }
    
    func updateHUDText(text: String) {
        if let hud = self.HUD {
            hud.label.text = text
        } else {
            self.showHUD(text)
        }
    }
}
