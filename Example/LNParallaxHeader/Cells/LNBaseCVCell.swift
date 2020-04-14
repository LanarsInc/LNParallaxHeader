//
//  LNBaseCVCell.swift
//
//
//  Copyright © 2020 Lanars. All rights reserved.
//  https://lanars.com/
//

import UIKit

class LNBaseCVCell: UICollectionViewCell {

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()

        clearCell()
        prepareUI()
        prepareLocalization()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        clearCell()
    }

    // MARK: - Clear

    func clearCell() {}

    // MARK: - UI

    func prepareUI() {}

    // MAKR: - Localization

    func prepareLocalization() {}

}
