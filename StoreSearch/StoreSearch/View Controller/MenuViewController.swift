//
//  MenuViewController.swift
//  StoreSearch
//
//  Created by Trainee on 2/28/19.
//  Copyright © 2019 Trainee. All rights reserved.
//
//**
import UIKit

protocol MenuViewControllerDelegate: class
{
    func menuViewControllerSendEmail(_ controller: MenuViewController)
}



class MenuViewController: UITableViewController
{
    weak var delegate: MenuViewControllerDelegate?
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.row == 0
        {
            delegate?.menuViewControllerSendEmail(self)
        }
    }



}
