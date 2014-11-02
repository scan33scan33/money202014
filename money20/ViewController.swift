//
//  ViewController.swift
//  money20
//
//  Created by Kevin Soong on 10/24/14.
//  Copyright (c) 2014 Kevin Soong. All rights reserved.
//
//import Globaly
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var usernameTextInput: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        usernameTextInput
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    func getEstimatedBalance() -> Int {
        var result:Int!
        
        let urlPath: String =  "https://blockchain.info/merchant/3b172fa8-8c69-45be-a8ee-f601c9a3667a/address_balance?password=jasper0215&address=1C6PYSNAzAit1AvNSQWKmB64vFqWaMJ6YU&confirmations=1"
        var url: NSURL = NSURL(string: urlPath)!
        var request: NSURLRequest = NSURLRequest(URL: url)
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
        var error: NSError? = nil
        var dataVal: NSData? =  NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error:&error)!
        var err: NSError? = nil
        var jsonDict: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataVal!, options: NSJSONReadingOptions.MutableContainers, error:&err) as NSDictionary
        result = jsonDict["balance"] as Int
        return result
    }
}

