//
//  DetailViewController.swift
//  StoreSearch
//
//  Created by Trainee on 2/22/19.
//  Copyright © 2019 Trainee. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController
{
    //__________ Outlet __________
    
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var kindLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var priceButton: UIButton!
    
    //__________ Variable __________
    
    
    var searchResult: SearchResult!
    var downloadTask: URLSessionDownloadTask?
    
    
    enum AnimationStyle
    {
        case slide
        case fade
    }
    
    var dismissStyle = AnimationStyle.fade
    
    //__________ Actions __________
    
    @IBAction func openInStore()
    {
        if let url = URL(string: searchResult.storeURL)
        {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func close()
    {
        dismissStyle = .slide
        dismiss(animated: true, completion: nil)
    }
    
    //__________ Load __________
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.tintColor = UIColor(red: 20/255, green: 160/255, blue:160/255, alpha: 1)
        popupView.layer.cornerRadius = 10
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(close))
        gestureRecognizer.cancelsTouchesInView = false
        gestureRecognizer.delegate = self
        view.addGestureRecognizer(gestureRecognizer)
        
        view.backgroundColor = UIColor.clear
        
        if searchResult != nil
        {
            updateUI()
        }
    }
    


    //__________ Init __________
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    //__________ Deinit __________
    
    deinit
    {
        print("deinit \(self)")
        downloadTask?.cancel()
    }
    
    
    //__________  __________
    
    func updateUI()
    {
        nameLabel.text = searchResult.name
        
        if searchResult.artist.isEmpty
        {
            artistNameLabel.text = "Unknown"
        }
        else
        {
            artistNameLabel.text = searchResult.artist
        }
        
        kindLabel.text = searchResult.type
        genreLabel.text = searchResult.genre
        
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = searchResult.currency
        
        let priceText: String
        if searchResult.price == 0
        {
            priceText = "Free"
        }
        else if let text = formatter.string(from: searchResult.price as NSNumber)
        {
            priceText = text
        }
        else
        {
            priceText = ""
        }
        
        priceButton.setTitle(priceText, for: .normal)
        
        if let largeUrl = URL(string: searchResult.imageLarge)
        {
            downloadTask = artworkImageView.loadImage(url: largeUrl)
        }
        
    }
    
    
    
    
}

//__________ Extension __________

extension DetailViewController: UIViewControllerTransitioningDelegate
{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?
    {
        return DimmingPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented:UIViewController, presenting: UIViewController,source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
            return BounceAnimationController()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        switch dismissStyle
        {
        case .slide:
            return SlideOutAnimationController()
        case .fade:
            return FadeOutAnimationController()
        }
    }
    
    
}


extension DetailViewController: UIGestureRecognizerDelegate
{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,shouldReceive touch: UITouch) -> Bool
    {
        return (touch.view === self.view)
    }
}
