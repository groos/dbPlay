//
//  ViewController.swift
//  dbPlay
//
//  Created by ntgroos on 5/10/15.
//  Copyright (c) 2015 DePaul University. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSXMLParserDelegate {
    
    @IBOutlet weak var dbOutput: UILabel!
    
    let databasePath = "/Users/ntgroos/ctaapp/cta.sqlite"
    let ctaURL = "http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx?key=25924988075841f2970d3e7f95c8070c&mapid=40380&max=5"
    
    let url = NSURL(string: "http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx?key=25924988075841f2970d3e7f95c8070c&mapid=40380&max=5")
    
    @IBAction func myParse(){
        var xmlParser = NSXMLParser(contentsOfURL: url)
        xmlParser?.delegate = self
        xmlParser?.parse()
    }
    
    // This gets called throughout the parsing, can add elements/attributes to a dictionary
    // need to figure out how to manage nesting of elements vs attributes
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: NSDictionary!) {
        dbOutput.text = elementName
    }
    
    // sends a request to cta REST api
    @IBAction func getSomeXML(sender: AnyObject){
        
        let url = NSURL(string: "http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx?key=25924988075841f2970d3e7f95c8070c&mapid=40380&max=5")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            self.dbOutput.text = NSString(data: data, encoding: NSUTF8StringEncoding)
        }
        
        // uncomment this for standard http request
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

