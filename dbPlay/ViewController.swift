//
//  ViewController.swift
//  dbPlay
//
//  Created by ntgroos on 5/10/15.
//  Copyright (c) 2015 DePaul University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dbOutput: UILabel!
    
    let databasePath = "/Users/ntgroos/ctaapp/cta.sqlite"
    

    // sends a request to cta REST api
    @IBAction func getSomeXML(sender: AnyObject){
        let ctaURL = "http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx?key=a8456dcbhf8475683cf7818bca81&mapid=40380&max=5"
        
        let url = NSURL(string: ctaURL)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            self.dbOutput.text = NSString(data: data, encoding: NSUTF8StringEncoding)
        }
        
        task.resume()
    }
    
    // example of db query example
    @IBAction func findContact(sender: AnyObject) {
        let contactDB = FMDatabase(path: databasePath as String)
        
        if contactDB.open() {
            let querySQL = "SELECT route_long_name FROM ROUTES WHERE route_id = 1"
            
            let results:FMResultSet? = contactDB.executeQuery(querySQL,
                withArgumentsInArray: nil)
            
            if results?.next() == true {
                dbOutput.text = results?.stringForColumn("route_long_name")
            } else {
                dbOutput.text = "no results"
            }
            contactDB.close()
        } else {
            println("Error: \(contactDB.lastErrorMessage())")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let filemgr = NSFileManager.defaultManager()
        let dirPaths =
        NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        
        let docsDir = dirPaths[0] as String
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

