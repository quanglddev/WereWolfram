//
//  PodTextOnlyCell.swift
//  WereWolfram
//
//  Created by QUANG on 7/17/18.
//  Copyright © 2018 QUANG. All rights reserved.
//

import UIKit
import ChameleonFramework

class PodTextOnlyCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var backgroundCardView: UIView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //For card view
        let inside = RandomFlatColorWithShade(UIShadeStyle.dark)
        let outside = inside.lighten(byPercentage: 0.5)!
        backgroundCardView.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: CGRect(x: 0, y: 0, width: backgroundCardView.frame.size.width, height: backgroundCardView.frame.size.height), colors: [outside, inside])
        //contentView.backgroundColor = UIColor(displayP3Red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        backgroundCardView.layer.cornerRadius = 20.0
        backgroundCardView.layer.masksToBounds = false
        backgroundCardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        backgroundCardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundCardView.layer.shadowOpacity = 0.8

        //For label
        lblTitle.textColor = ContrastColorOf(backgroundCardView.backgroundColor!, returnFlat: true)
        lblContent.textColor = lblTitle.textColor!
        
        //For icon
        iconImage.tintColor = lblTitle.textColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
