//
//  SearchResultCell.swift
//  StoreSearch
//
//  Created by Trainee on 2/21/19.
//  Copyright © 2019 Trainee. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell
{

    //__________ Outlet __________
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var artworkImageView: UIImageView!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        let selectedView = UIView(frame: CGRect.zero)
        selectedView.backgroundColor = UIColor(red: 20/255, green: 160/255, blue: 160/255, alpha: 0.7)
        selectedBackgroundView = selectedView;
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
