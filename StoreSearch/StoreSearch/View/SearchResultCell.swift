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
    
    //__________ Variable __________
    
    var downloadTask: URLSessionDownloadTask?
    
    
    //__________ Nib __________
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        let selectedView = UIView(frame: CGRect.zero)
        selectedView.backgroundColor = UIColor(red: 20/255, green: 160/255, blue: 160/255, alpha: 0.5)
        selectedBackgroundView = selectedView;
    }
    
     //__________ Prepare __________
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        downloadTask?.cancel()
        downloadTask = nil
    }
    
    //__________  __________
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //__________ Public Methods __________

    func configure(for result: SearchResult)
    {
        nameLabel.text = result.name
        
        if result.artist.isEmpty
        {
            artistNameLabel.text = "Unknown"
        }
        else
        {
            artistNameLabel.text = String(format: "%@ (%@)", result.artist, result.type)
        }
        
        artworkImageView.image = UIImage(named: "Placeholder")
        if let smallURL = URL(string: result.imageSmall)
        {
            downloadTask = artworkImageView.loadImage(url: smallURL)
        }
    }
}
