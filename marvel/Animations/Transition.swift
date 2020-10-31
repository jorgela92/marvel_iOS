//
//  Transition.swift
//  marvel
//
//  Created by Jorge Lapeña Antón on 30/10/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import UIKit

enum AnimationCase {
    case peekAndPop
}

class Transition: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {
    
    fileprivate var isPresenting: Bool!
    fileprivate var maxWidth: CGFloat = UIScreen.main.bounds.width
    fileprivate var interactionInProgress = false
    fileprivate let backgroundView = UIView()
    var animationType: AnimationCase?
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: .from)
        let toViewController = transitionContext.viewController(forKey: .to)
        if isPresenting == true {
            backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            backgroundView.alpha = 0
            backgroundView.frame = CGRect(x: 0, y: 0, width: fromViewController!.view.frame.width, height: fromViewController!.view.frame.height)
            switch animationType {
            case .peekAndPop:
                transitionContext.containerView.addSubview((toViewController?.view)!)
                toViewController?.view.frame = (fromViewController?.view.frame)!
                toViewController?.view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                UIView.animate(withDuration: 0.2, animations: {
                    toViewController?.view.transform = CGAffineTransform(scaleX: 1, y: 1)
                    self.backgroundView.alpha = 1
                }) { (completed) in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                }
                break
            default:
                break
            }
        } else {
            if animationType == .peekAndPop {
                transitionContext.containerView.addSubview((fromViewController?.view)!)
                fromViewController?.view.superview?.bringSubviewToFront((fromViewController?.view)!)
                UIView.animate(withDuration: 0.2, animations: {
                    self.backgroundView.alpha = 0
                    fromViewController?.view.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
                }, completion: { (Bool) in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                })
            }
        }
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionInProgress ? self : nil
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionInProgress ? self : nil
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(0.5)
    }
}

//MARK: - UIViewControllerTransitioningDelegate
extension Transition: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
}
