//
//  LNCell.swift
//  LNParallaxHeaderExample
//
//  Copyright © 2020 Lanars. All rights reserved.
//  https://lanars.com/
//

import UIKit

final class LNCell: LNBaseCVCell {
    
    @IBOutlet weak private var lbTitle: UILabel!
    
    // MARK: - Clear
    
    override func prepareForReuse() {
        super.prepareForReuse()

        lbTitle.text = nil
    }
    
    // MARK: - Config
    
    func configureCell(_ title: String) {
        lbTitle.text = title
    }
    
}
