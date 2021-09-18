//
//  PodTextsOnlyCell.swift
//  WereWolfram
//
//  Created by QUANG on 7/18/18.
//  Copyright © 2018 QUANG. All rights reserved.
//

import UIKit
import ChameleonFramework

class PodTextsOnlyCell: UITableViewCell {
    
    //MARK: Properties
    var contents: [String]! {
        didSet {
            self.updateUI()
        }
    }
    
    //MARK: Outlets
    @IBOutlet weak var backgroundCardView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var lblContent: PaddingLabel!
    

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
        lblContent.layer.masksToBounds = true
        lblContent.layer.cornerRadius = 10.0
        lblTitle.textColor = ContrastColorOf(backgroundCardView.backgroundColor!, returnFlat: true)
        lblContent.textColor = lblTitle.textColor!
        
        //For icon
        iconImage.tintColor = lblTitle.textColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateUI() {
        let startingPoint = lblContent.frame.origin.y
        
        lblContent.text = contents[0]
        lblContent.backgroundColor = RandomFlatColor()
        lblContent.font = UIFont.systemFont(ofSize: 16.0)
        lblContent.topInset = 4
        lblContent.bottomInset = 4
        lblContent.leftInset = 4
        lblContent.rightInset = 4
        lblContent.sizeToFit()
        
        if contents.count > 1 {
            for i in 1..<contents.count {
                let newComparisonLabel = PaddingLabel(frame: CGRect(x: lblContent.frame.origin.x, y: startingPoint + lblContent.frame.size.height + CGFloat(5 * i * 2), width: lblContent.frame.size.width, height: lblContent.frame.size.height))
                newComparisonLabel.numberOfLines = 0
                newComparisonLabel.text = contents[i]
                newComparisonLabel.layer.masksToBounds = true
                newComparisonLabel.layer.cornerRadius = 10.0
                newComparisonLabel.backgroundColor = RandomFlatColor()
                newComparisonLabel.font = UIFont.systemFont(ofSize: 16.0)
                newComparisonLabel.textColor = lblTitle.textColor!
                newComparisonLabel.topInset = 4
                newComparisonLabel.bottomInset = 4
                newComparisonLabel.leftInset = 4
                newComparisonLabel.rightInset = 4
                newComparisonLabel.sizeToFit()
                newComparisonLabel.frame = CGRect(x: newComparisonLabel.frame.origin.x, y: newComparisonLabel.frame.origin.y, width: lblContent.frame.size.width, height: newComparisonLabel.frame.size.height + 8)
                self.addSubview(newComparisonLabel)
            }
        }
    }
}
