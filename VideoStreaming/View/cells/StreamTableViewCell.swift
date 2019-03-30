//
//  StreamTableViewCell.swift
//  VideoStreaming
//
//  Created by Nikil on 11/01/18.
//  Copyright © 2018 Nikil. All rights reserved.
//

import UIKit

class StreamTableViewCell: UITableViewCell {

    @IBOutlet weak var labelProgramName: UILabel!
    
    @IBOutlet weak var labelProgramTime: UILabel!
    
    @IBOutlet weak var secondaryLabel: UILabel!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        labelProgramName.textColor = hexToUiColor().hexStringToUIColor(hex: tableTextColor)
        labelProgramTime.textColor = hexToUiColor().hexStringToUIColor(hex: tableTextColor)
        secondaryLabel.textColor = hexToUiColor().hexStringToUIColor(hex: tableTextColor)
        self.contentView.backgroundColor = hexToUiColor().hexStringToUIColor(hex: daySelectionColor)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
