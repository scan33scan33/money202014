//
//  BidViewController.swift
//  money20
//
//  Created by Kevin Soong on 11/2/14.
//  Copyright (c) 2014 Kevin Soong. All rights reserved.
//
import UIKit

class BidViewController: UIViewController {
//    let appDelegate = UIApplication.sharedApplication().delegate as UIApplicationDelegate?
//    let bidHandle = appDelegate!.bidHandle as String?

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var hiddenButton: UIButton!
    @IBOutlet weak var transactionFeeLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!

    @IBOutlet weak var cashoutTitleLabel: UILabel!
    var timer:NSTimer!
    var bidEndDate:NSDate!
    var isSent:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //        FIXME
//        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
//        var bidHandle = appDelegate.data["bidHandle"] as NSString
//        NSLog("____________BID___HANDLE____IN NEW VIEW________")
//        
//        NSLog(bidHandle)
//        timerLabel.text = bidHandle!
        startTimer()
        transactionFeeLabel.text = String(Global.transactionFee) + "%"
        totalLabel.text = "$" + String(Global.cashoutTotalAmount)
        cashoutTitleLabel.text = "CASHOUT $" + String(Global.cashoutAmount)
    }

    @IBAction func onHiddenHit(sender: UIButton) {
        bidEndDate = NSDate()
        bidEndDate = bidEndDate.dateByAddingTimeInterval(6)

                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "h:mm:ss"
        NSLog(dateFormatter.stringFromDate(bidEndDate))
    }
    
    func updateTimer(dt:NSTimer) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "h:mm:ss"
//        let now = NSDate()
        let interval = bidEndDate.timeIntervalSinceNow
        var min = Int64(interval) / 60;    // divide two longs, truncates
        var sec = Int64(interval) % 60;    // remainder of long divide
//        let time = dateFormatter.stringFromDate()
//        NSLog(time)
        //        timerLabel.text = str
        if (((min == 0) && (sec == 0)) && (!isSent)) {
            //DO Transaction
                       NSLog("_______bidHandle_________")
//            NSLog(Global.bidHandle)
            println(Global.bidHandle)
            sendMoney(Global.bidHandle, amount: Global.transactionFee)
            performSegueWithIdentifier("showFeedback", sender: self)
            isSent = true;
        }
        if ((min >= 0) && (sec >= 0)) {
            timerLabel.text = NSString(format:"%02d:%02d", min, sec)
        }

    }
    
    func sendMoney(handle:NSString, amount:Int) {
        let url = NSURL(string: "https://blockchain.info/merchant/3b172fa8-8c69-45be-a8ee-f601c9a3667a/payment?password=jasper0215&to=" + handle + "&amount=" + String(amount) + "&note=ios")
        println(url)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
        }
        task.resume()
    }
    
    func startTimer() {
        bidEndDate = NSDate()
        bidEndDate = bidEndDate.dateByAddingTimeInterval(600)
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateTimer:"), userInfo: nil, repeats: true)
        updateTimer(timer)
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}


