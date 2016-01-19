//
//  Created by Dariusz Rybicki on 30/11/15.
//  Copyright © 2015 EL Passion. All rights reserved.
//

import UIKit

extension GameBoardView {
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.locationInView(self)
        guard let circleView = circleViewAtPoint(location) else { return }
        let dragger = CircleViewDragger(view: circleView, touch: touch)
        draggers.append(dragger)
        dragger.view.moveToSuperview(self)
        dragger.view.center = location
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        guard let dragger = draggerForTouch(touch) else { return }
        let location = touch.locationInView(self)
        dragger.view.center = location
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        guard let dragger = draggerForTouch(touch) else { return }
        draggers = draggers.filter { $0.view != dragger.view }
        guard let slotView = slotViewForCircleView(dragger.view) else { return }
        guard let slotSuperview = slotView.superview else { return }
        let targetCenter = slotSuperview.convertPoint(slotView.center, toView: self)
        UIView.animateWithDuration(0.2,
            animations: {
                dragger.view.center = targetCenter
                dragger.view.addBounceAnimation()
            },
            completion: { finished in
                dragger.view.moveToSuperview(slotView)
            }
        )
    }
    
    private func draggerForTouch(touch: UITouch) -> CircleViewDragger? {
        return draggers.filter({ $0.touch == touch }).first
    }
    
}
