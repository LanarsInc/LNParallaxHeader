//
//  ViewController.swift
//  LNParallaxHeaderExample
//
//  Copyright © 2020 Lanars. All rights reserved.
//  https://lanars.com/
//

import UIKit
import LNParallaxHeader

final class ViewController: UIViewController {

    @IBOutlet weak private var collectionView: UICollectionView!
    
    private let dataSource = Array(repeating: "Title", count: 100)
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareCollectionView()
        prepareCollectionViewLayout()
    }
    
}

// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let title = dataSource[indexPath.row]
        let cell = collectionView.dequeueCell(LNCell.self, for: indexPath)
        cell.configureCell(title)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard
            LNParallaxHeaderFlowLayout.kind == kind,
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LNHeader.className, for: indexPath) as? LNHeader
        else { return UICollectionReusableView() }
        
        return cell
    }
    
}

// MARK: - Private

private extension ViewController {
    
    func prepareCollectionView() {
        collectionView.register(UINib(nibName: LNHeader.className, bundle: .main), forSupplementaryViewOfKind: LNParallaxHeaderFlowLayout.kind, withReuseIdentifier: LNHeader.className)
        collectionView.register(dataSource: self, cellIDs: [LNCell.className])
    }
    
    func prepareCollectionViewLayout() {
        guard let layout = collectionView.collectionViewLayout as? LNParallaxHeaderFlowLayout else { return }

        let width = UIScreen.main.bounds.size.width
        layout.minSize = CGSize(width: width, height: 64.0)
        layout.indicativeSize = CGSize(width: width, height: 180.0)
        layout.itemSize = CGSize(width: width, height: layout.itemSize.height)
        layout.isAlwaysOnTop = true

        collectionView.collectionViewLayout = layout
    }
    
}
