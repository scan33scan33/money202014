    # TODO: MUST fill these to make the code work.
    let bidder = ""
    let acct = ""


    func getMoney() -> Int {

        var money:Int!



        let urlPath: String =  "http://173.230.156.163:8080/get_money/"

        var url: NSURL = NSURL(string: urlPath)!

        var request: NSURLRequest = NSURLRequest(URL: url)

        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil

        var error: NSError? = nil

        var dataVal: NSData? =  NSURLConnection.sendSynchronousRequest(request,
returningResponse: response, error:&error)!

        var err: NSError? = nil

        var jsonDict: NSDictionary =
NSJSONSerialization.JSONObjectWithData(dataVal!,
options: NSJSONReadingOptions.MutableContainers, error:&err) as NSDictionary

        money = jsonDict["value"] as Int

        return money

    }



    func CanTransferMoney(handle:String) -> Bool {

        var win:Int!



        let urlPath: String =  "
http://173.230.156.163:8080/can_transfer_money/?handle=" + handle

        var url: NSURL = NSURL(string: urlPath)!

        var request: NSURLRequest = NSURLRequest(URL: url)

        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil

        var error: NSError? = nil

        var dataVal: NSData? =  NSURLConnection.sendSynchronousRequest(request,
returningResponse: response, error:&error)!

        var err: NSError? = nil

        var jsonDict: NSDictionary =
NSJSONSerialization.JSONObjectWithData(dataVal!,
options: NSJSONReadingOptions.MutableContainers, error:&err) as NSDictionary

        win = jsonDict["value"] as Int

        if win > 0 {

            return true

        }

        return false

    }



    func getCap() -> Int {

        var cap:Int!



        let urlPath: String =  "http://173.230.156.163:8080/get_cap/"

        var url: NSURL = NSURL(string: urlPath)!

        var request: NSURLRequest = NSURLRequest(URL: url)

        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil

        var error: NSError? = nil

        var dataVal: NSData? =  NSURLConnection.sendSynchronousRequest(request,
returningResponse: response, error:&error)!

        var err: NSError? = nil

        var jsonDict: NSDictionary =
NSJSONSerialization.JSONObjectWithData(dataVal!,
options: NSJSONReadingOptions.MutableContainers, error:&err) as NSDictionary

        cap = jsonDict["value"] as Int

        return cap

    }



    func getUSDToBTC() -> Float {

        var usd:Float!

        let urlPath: String =  "https://blockchain.info/ticker"

        var url: NSURL = NSURL(string: urlPath)!

        var request: NSURLRequest = NSURLRequest(URL: url)

        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil

        var error: NSError? = nil

        var dataVal: NSData? =  NSURLConnection.sendSynchronousRequest(request,
returningResponse: nil, error:&error)!

        var err: NSError? = nil

        var jsonDict:NSDictionary =
NSJSONSerialization.JSONObjectWithData(dataVal!,
options: NSJSONReadingOptions.MutableContainers, error:&err) as NSDictionary

        // usd = jsonDict["usd"] as Float

        // println((jsonDict["USD"] as NSDictionary)["buy"] as Float)

        // println(err)

        usd = ((jsonDict["USD"] as NSDictionary)["buy"]) as Float

        // usd = NSURLConnection.sendSynchronousRequest(request,
returningResponse: nil, error:&error)! as AnyObject? as? Float

        return usd

    }



    func getHandleAndMakeRequest(amount: Int) -> String {

        var handle:String!



        let urlPath: String =  "
http://173.230.156.163:8080/handle?receiver_acct_no=0000000000000&receiver_routing_no=0000000&amount=
" + String(amount)

        var url: NSURL = NSURL(string: urlPath)!

        var request: NSURLRequest = NSURLRequest(URL: url)

        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil

        var error: NSError? = nil

        var dataVal: NSData? =  NSURLConnection.sendSynchronousRequest(request,
returningResponse: response, error:&error)!

        var err: NSError? = nil

        var jsonDict: NSDictionary =
NSJSONSerialization.JSONObjectWithData(dataVal!,
options: NSJSONReadingOptions.MutableContainers, error:&err) as NSDictionary

        handle = jsonDict["handle"] as String

        return handle

    }



    func sendMoney(handle:NSString, amount:Int) {

        let url = NSURL(string: "https://blockchain.info/merchant/" + bidder
+ "/payment?password=&to=" + handle + "&amount=" + String(amount)
+ "&note=ios")

        println(url)

        let task = NSURLSession.sharedSession().dataTaskWithURL(url!)
{(data, response, error) in

            println(NSString(data: data, encoding: NSUTF8StringEncoding))

        }

        task.resume()

    }



    func getBalance() -> Int {

        var result:Int!



        let urlPath: String =  "https://blockchain.info/merchant/" + bidder
+ "/address_balance?password=&address=" + acct +
"&confirmations=10"

        var url: NSURL = NSURL(string: urlPath)!

        var request: NSURLRequest = NSURLRequest(URL: url)

        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil

        var error: NSError? = nil

        var dataVal: NSData? =  NSURLConnection.sendSynchronousRequest(request,
returningResponse: nil, error:&error)!

        var err: NSError? = nil

        var jsonDict: NSDictionary =
NSJSONSerialization.JSONObjectWithData(dataVal!,
options: NSJSONReadingOptions.MutableContainers, error:&err) as NSDictionary

        result = jsonDict["balance"] as Int

        return result

    }



    func getEstimatedBalance() -> Int {

        var result:Int!


        let urlPath: String =  "https://blockchain.info/merchant/" + bidder
+ "/address_balance?password=&address=" + acct +
"&confirmations=1"

        var url: NSURL = NSURL(string: urlPath)!

        var request: NSURLRequest = NSURLRequest(URL: url)

        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil

        var error: NSError? = nil

        var dataVal: NSData? =  NSURLConnection.sendSynchronousRequest(request,
returningResponse: nil, error:&error)!

        var err: NSError? = nil

        var jsonDict: NSDictionary =
NSJSONSerialization.JSONObjectWithData(dataVal!,
options: NSJSONReadingOptions.MutableContainers, error:&err) as NSDictionary

        result = jsonDict["balance"] as Int

        return result

    }
