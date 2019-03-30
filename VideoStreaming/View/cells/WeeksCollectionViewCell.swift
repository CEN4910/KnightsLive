//
//  WeeksCollectionViewCell.swift
//  VideoStreaming
//
//  Created by Nikil on 11/01/18.
//  Copyright © 2018 Nikil. All rights reserved.
//

import UIKit

class WeeksCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var labelWeekName: UILabel!
    
    @IBOutlet weak var viewWeekSelection: UIView!
    
    override func awakeFromNib() {
        
        viewWeekSelection.layer.cornerRadius = 10
    }
}
