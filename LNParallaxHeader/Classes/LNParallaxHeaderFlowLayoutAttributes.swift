//
//  LNParallaxHeaderFlowLayoutAttributes.swift
//
//
//  Copyright © 2020 Lanars. All rights reserved.
//  https://lanars.com/
//

import UIKit

final class LNParallaxHeaderFlowLayoutAttributes: UICollectionViewLayoutAttributes {
    
    var offset: CGFloat = 1.0
    
    override var zIndex: Int{
        didSet{
            transform3D = CATransform3DMakeTranslation(.zero, .zero, zIndex == 1 ? -1 : .zero)
        }
    }
    
    override func copy(with zone: NSZone? = nil) -> Any {
        guard let copy = super.copy(with: zone) as? LNParallaxHeaderFlowLayoutAttributes else {
            return self
        }
        
        copy.offset = offset
        
        return copy
    }
}
