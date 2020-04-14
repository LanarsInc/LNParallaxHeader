//
//  LNParallaxHeaderFlowLayout.swift
//
//
//  Copyright © 2020 Lanars. All rights reserved.
//  https://lanars.com/
//

import UIKit

private enum Constants {
    
    enum Height {
        static let min: CGFloat = 64.0
        static let indicative: CGFloat = 180.0
    }
    
    enum zIndex {
        static let `default` = 1024
        static let min = 1
        static let max = 2000
    }
    
}

public final class LNParallaxHeaderFlowLayout: UICollectionViewFlowLayout {
    
    static public let kind = String(describing: LNParallaxHeaderFlowLayout.self)

    /// Determine header behavior when resizing
    public var isAlwaysOnTop = true
    
    /// Mini size of the header when header always on top
    public var minSize = CGSize(width: UIScreen.main.bounds.size.width,
                                height: Constants.Height.min)
    
    /// Header size without scroll
    public var indicativeSize = CGSize(width: UIScreen.main.bounds.size.width,
                                       height: Constants.Height.indicative) {
        didSet{
            invalidateLayout()
        }
    }
    
    // MARK: - Lifecycle
    
    convenience public init(minSize: CGSize, size: CGSize) {
        self.init()
        self.minSize = minSize
        self.indicativeSize = size
    }
    
    override public func initialLayoutAttributesForAppearingSupplementaryElement(ofKind elementKind: String, at elementIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.initialLayoutAttributesForAppearingSupplementaryElement(ofKind: elementKind, at: elementIndexPath)
        guard var frame = attributes?.frame else { return attributes }
        
        frame.origin.y += indicativeSize.height
        attributes?.frame = frame
        
        itemSize = .zero
        
        return attributes
    }
    
    override public func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath)
        
        return attributes != nil && elementKind == LNParallaxHeaderFlowLayout.kind ?
            LNParallaxHeaderFlowLayoutAttributes(forSupplementaryViewOfKind: elementKind, with: indexPath) :
            attributes
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let layoutCollectionView = collectionView else { return nil }
        
        let height = indicativeSize.height
        var adjustedRec = rect
        adjustedRec.origin.y -= height
        
        let attributes = super.layoutAttributesForElements(in: adjustedRec)
        var allItems: [UICollectionViewLayoutAttributes] = []
        
        attributes?
            .compactMap({ $0.copy() as? UICollectionViewLayoutAttributes })
            .forEach { allItems.append($0) }
        
        var headers: [Int: UICollectionViewLayoutAttributes] = [:]
        var lastCells: [Int: UICollectionViewLayoutAttributes] = [:]
        var isVisible = false
        
        allItems.forEach { attribute in
            var frame = attribute.frame
            frame.origin.y += height
            attribute.frame = frame
            
            guard
                attribute.representedElementKind != UICollectionView.elementKindSectionHeader
            else {
                headers[attribute.indexPath.section] = attribute
                attribute.zIndex = Constants.zIndex.min
                return
            }
            
            let currentAttribute = lastCells[attribute.indexPath.section]
            
            if currentAttribute == nil || currentAttribute?.indexPath != nil && attribute.indexPath.row > (currentAttribute as AnyObject).indexPath.row {
                lastCells[attribute.indexPath.section] = attribute
            }
            
            if attribute.indexPath.item == .zero && attribute.indexPath.section == .zero {
                isVisible = true
            }
            
            attribute.zIndex = Constants.zIndex.min
        }
        
        isVisible = rect.minY <= .zero ? true : isVisible
        isVisible = isAlwaysOnTop ? true : isVisible
        
        if isVisible && !CGSize.zero.equalTo(indicativeSize) {
            let currentAttribute = LNParallaxHeaderFlowLayoutAttributes(forSupplementaryViewOfKind: LNParallaxHeaderFlowLayout.kind, with: IndexPath(index: .zero))
            var frame = currentAttribute.frame
            frame.size.width = indicativeSize.width
            frame.size.height = height
            
            let maxY = frame.maxY
            
            var y = min(maxY - minSize.height, layoutCollectionView.bounds.origin.y + layoutCollectionView.contentInset.top)
            
            let height = max(.zero, -y + maxY)
            let maxHeight = indicativeSize.height
            let minHeight = minSize.height
            let offset = (height - minHeight) / (maxHeight - minHeight)
            
            currentAttribute.offset = offset
            currentAttribute.zIndex = .zero
            
            if isAlwaysOnTop && height <= minSize.height {
                collectionView.map { y = $0.contentOffset.y + $0.contentInset.top }
                currentAttribute.zIndex = Constants.zIndex.max
            }
            
            currentAttribute.frame = CGRect(x: frame.origin.x,
                                            y: y,
                                            width: frame.size.width,
                                            height: height)
            
            allItems.append(currentAttribute)
        }
        
        lastCells.forEach { cell in
            let numberOfSection = cell.value.indexPath.section
            var header = headers[numberOfSection]
            
            if header == nil {
                header = layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: .zero, section: numberOfSection))
                
                header.map { allItems.append($0) }
            }
            
            guard
                let attributes = header,
                let lastAttributes = lastCells[numberOfSection]
            else { return }
            
            update(attributes: attributes, lastAttributes: lastAttributes)
        }
        
        return allItems
    }
    
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes else {
            return nil
        }
 
        var frame = attributes.frame
        frame.origin.y += indicativeSize.height
        attributes.frame = frame
        return attributes
    }
    
    override public var collectionViewContentSize: CGSize {
        guard collectionView?.superview != nil else { return .zero }

        var size = super.collectionViewContentSize
        size.height += indicativeSize.height
        return size
    }
    
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}

// MARK: - Private

private extension LNParallaxHeaderFlowLayout {
        
    func update(attributes: UICollectionViewLayoutAttributes, lastAttributes: UICollectionViewLayoutAttributes) {
        guard let collectionView = collectionView else { return }
        
        var origin = attributes.frame.origin
        attributes.zIndex = Constants.zIndex.default
        attributes.isHidden = false
        
        let sectionMaxY = lastAttributes.frame.maxY - attributes.frame.size.height
        let bounds = collectionView.bounds
        var y = bounds.maxY - bounds.height + collectionView.contentInset.top
        
        if isAlwaysOnTop {
            y += minSize.height
        }
        
        let maxY = min(max(y, attributes.frame.origin.y), sectionMaxY)
        origin.y = maxY
        
        let attributesSize = attributes.frame.size
        attributes.frame = CGRect(x: origin.x,
                                  y: origin.y,
                                  width: attributesSize.width,
                                  height: attributesSize.height)
    }

}
