//
//  SendViewController.swift
//  money20
//
//  Created by Kevin Soong on 11/2/14.
//  Copyright (c) 2014 Kevin Soong. All rights reserved.
//

import UIKit

class SendViewController: UIViewController {
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var transacationLabel: UILabel!
    @IBOutlet weak var inputMoneyAmount: UITextField!
    
//    var app = UIApplication.sharedApplication().delegate as UIApplicationDelegate?
//    var bidHandle = app.bidHandle as String?

    @IBOutlet weak var transactionFeeSlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //        usernameTextInput
        var balance = getBalance();
        if (Global.cashoutAmount != nil) {
            balance -= Global.cashoutAmount
        }
        inputMoneyAmount.placeholder = "$" + String(balance)
    }
    
    @IBAction func onInputMoneyChanged(sender: UITextField) {
        updateTotal()
    }

    func updateTotal() {
        let val = Int(transactionFeeSlider.value)
        Global.transactionFee = val
        let sendAmount = inputMoneyAmount.text.toInt() as Int?
        let v = Double(val)
        var senda = 0
        if (sendAmount != nil) {
            senda = Int(sendAmount!);
        }
        else {
            inputMoneyAmount.text = "0"
        }
        Global.cashoutAmount = senda
        let v2 = (1+v/Double(100))*Double(senda)
        Global.cashoutTotalAmount = Int(v2)
        totalLabel.text = "$" + String(Global.cashoutTotalAmount)
    }
    
    @IBAction func onBidTapped(sender: UIButton) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
//        var bidHandle = appDelegate.data["bidHandle"] as String
        Global.bidHandle = getHandleAndMakeRequest(Int(transactionFeeSlider.value))
        println(Global.bidHandle)
//        NSLog(bidHandle)
    }

    @IBAction func onTransactionFeeChanged(sender: UISlider) {
        let val = Int(sender.value)
        transacationLabel.text = String(val) + "%"
        updateTotal()
    }
    
    func getBalance() -> Int {
//        return 10000
        var result:Int!
        
        let urlPath: String =  "https://blockchain.info/merchant//address_balance?password=&address=1C6PYSNAzAit1AvNSQWKmB64vFqWaMJ6YU&confirmations=10"
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
    
    func getHandleAndMakeRequest(amount: Int) -> String {
        var handle:String!
        
        let urlPath: String =  "http://173.230.156.163:8080/handle?receiver_acct_no=0000000000000&receiver_routing_no=0000000&amount=" + String(amount)
        var url: NSURL = NSURL(string: urlPath)!
        var request: NSURLRequest = NSURLRequest(URL: url)
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
        var error: NSError? = nil
        var dataVal: NSData? =  NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error:&error)!
        var err: NSError? = nil
        var jsonDict: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataVal!, options: NSJSONReadingOptions.MutableContainers, error:&err) as NSDictionary
        handle = jsonDict["handle"] as String
        return handle
    }
}
