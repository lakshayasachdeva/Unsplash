//
//  ImageTransitionController.swift
//  TSystemsHomeAssignment
//
//  Created by Shikhar Varshney on 5/7/18.
//  Copyright © 2018 Shikhar Varshney. All rights reserved.
//

import Foundation
import UIKit

protocol ImageTransitionProtocol {
    func tranisitionStarted()
    func tranisitionFinished()
    func imageFrame() -> CGRect
}


class ImageTransitionController: NSObject, UIViewControllerAnimatedTransitioning {
    
    private var image: UIImage?
    private var fromDelegate: ImageTransitionProtocol?
    private var toDelegate: ImageTransitionProtocol?
    private let kAnimationDuration = 0.7
    // MARK: Setup Methods
    
    func setupImageTransition(image: UIImage, fromDelegate: ImageTransitionProtocol, toDelegate: ImageTransitionProtocol){
        self.image = image
        self.fromDelegate = fromDelegate
        self.toDelegate = toDelegate
    }
    
    // MARK: UIViewControllerAnimatedTransitioning
    
    // 1: Set animation speed
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return kAnimationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to)
            else {
                return
        }
        let containerView = transitionContext.containerView
        
        let fromView = transitionContext.view(forKey: .from)
        let toView = transitionContext.view(forKey: .to)
        
        // 3: Set the destination view controllers frame
        toView!.frame = fromView!.frame
        
        // 4: Create transition image view
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = (fromDelegate == nil) ? CGRect.zero : fromDelegate!.imageFrame()
        imageView.clipsToBounds = true
        containerView.addSubview(imageView)
        
        fromDelegate!.tranisitionStarted()
        toDelegate!.tranisitionStarted()
        
        // 5: Create from screen snapshot
        let fromSnapshot = fromView!.snapshotView(afterScreenUpdates:true)!
        fromSnapshot.frame = fromView!.frame
        containerView.addSubview(fromSnapshot)
        
        // 6: Create to screen snapshot
        let toSnapshot = toView!.snapshotView(afterScreenUpdates: true)!
        toSnapshot.frame = fromView!.frame
        containerView.addSubview(toSnapshot)
        toSnapshot.alpha = 0
        
        // 7: Bring the image view to the front and get the final frame
        containerView.bringSubviewToFront(imageView)
        let toFrame = (self.toDelegate == nil) ? CGRect.zero : self.toDelegate!.imageFrame()
        
        // 8: Animate change
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.85, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
            toSnapshot.alpha = 1
            imageView.frame = toFrame
            
        }, completion:{ [weak self] (finished) in
            
            self?.toDelegate!.tranisitionFinished()
            self?.fromDelegate!.tranisitionFinished()
            
            // 9: Remove transition views
            imageView.removeFromSuperview()
            fromSnapshot.removeFromSuperview()
            toSnapshot.removeFromSuperview()
            
            
            // 10: Complete transition
            if !transitionContext.transitionWasCancelled {
                containerView.addSubview(toView!)
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}


