//
//  FinishViewController.swift
//  money20
//
//  Created by Kevin Soong on 11/2/14.
//  Copyright (c) 2014 Kevin Soong. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {
    @IBOutlet weak var moneyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        moneyLabel.text = "$" + String(Global.cashoutAmount)

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
