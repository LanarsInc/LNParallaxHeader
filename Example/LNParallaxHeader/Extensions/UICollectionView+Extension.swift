//
//  UICollectionView+Extension.swift
// 
//
//  Copyright © 2020 Lanars. All rights reserved.
//  https://lanars.com/
//

import UIKit

extension UICollectionView {
    
    func register(dataSource: UICollectionViewDataSource, delegate: UICollectionViewDelegate? = nil, cellIDs: [String]) {
        self.dataSource = dataSource
        self.delegate = delegate
        cellIDs.forEach { self.register(NSClassFromString($0), forCellWithReuseIdentifier: $0) }
        cellIDs.forEach { self.register(UINib(nibName: $0, bundle: nil), forCellWithReuseIdentifier: $0) }
    }
    
    func dequeueCell<T: UICollectionViewCell>(_ reusable: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath) as? T else {
            fatalError("Cell \(T.className) is not registered - call collectionView.register(Cell.Type) to register first before using.")
        }
        
        return cell
    }
    
}
