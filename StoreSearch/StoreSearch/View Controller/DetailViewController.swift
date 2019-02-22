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

    
    //__________ Load __________
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    //__________ Actions __________
    
    @IBAction func close()
    {
        dismiss(animated: true, completion: nil)
    }

    //__________ Init __________
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
}

//__________ Extension __________

extension DetailViewController: UIViewControllerTransitioningDelegate
{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?
    {
        return DimmingPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
