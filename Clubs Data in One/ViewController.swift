//
//  ViewController.swift
//  Clubs Data in One
//
//  Created by HAYATO OI on 2023/05/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var KuradetaLabel: UILabel!
    @IBOutlet var ClubsDataLabel: UILabel!
    @IBOutlet var inLabel: UILabel!
    @IBOutlet var OneLabel: UILabel!
    @IBOutlet var EnterDataButton: UIButton!
    @IBOutlet var GraphButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        EnterDataButton.layer.cornerRadius = 10
        GraphButton.layer.cornerRadius = 10
        EnterDataButton.clipsToBounds = true
        GraphButton.clipsToBounds = true
        
    }
    
    @IBAction func tappedEnterDataButton(){
        
    }
    @IBAction func tappedGraphButton(){
        
    }

}

