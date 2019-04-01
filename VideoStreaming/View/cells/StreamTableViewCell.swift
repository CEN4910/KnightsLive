//
//  StreamTableViewCell.swift
//  VideoStreaming
//
//  Created by Emmanuel on 01/20/19.

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
