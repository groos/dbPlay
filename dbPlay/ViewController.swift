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
    
    //let databasePath = "/Users/ntgroos/ctaapp/cta.sqlite"
    let databasePath:String? = "/Users/phawk/Documents/dbPlay/cta.sqlite"
    
    let url = NSURL(string: "http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx?key=25924988075841f2970d3e7f95c8070c&mapid=40380&max=5")
    
    
    // these will be used throughout parsing
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var staID = NSMutableString() // basically used as a stringbuilder for this attribute
    var arrT = NSMutableString() // basically used as a stringbuilder for this attribute
    
    
    // custom function to set up and call superclass parser methods (below)
    @IBAction func myParse(){
        let posts = []
        var xmlParser = NSXMLParser(contentsOfURL: url)
        xmlParser?.delegate = self
        xmlParser?.parse()
        showParsedResults()
    }
    
    // gets parsed data and puts it on screen
    // call this once the parsing is finished, and access dictionaries of data
    func showParsedResults(){
        if posts.count > 0{
            var obj = posts[0] as! NSMutableDictionary
            var arrival = obj["arrT"] as! NSString
            dbOutput.text = arrival as String
        }
    }
    
    /* Here is the xml object we want.
    or paste this in browser: http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx?key=25924988075841f2970d3e7f95c8070c&mapid=40380&max=5
    
    <eta>
    <staId>40380</staId>
    <stpId>30074</stpId>
    <staNm>Clark/Lake</staNm>
    <stpDe>Service at Inner Loop platform</stpDe>
    <rn>015</rn>
    <rt>G</rt>
    <destSt>30057</destSt>
    <destNm>Ashland/63rd</destNm>
    <trDr>5</trDr>
    <prdt>20150517 17:20:12</prdt>
    <arrT>20150517 17:23:12</arrT>
    <isApp>0</isApp>
    <isSch>0</isSch>
    <isDly>0</isDly>
    <isFlt>0</isFlt>
    <flags/>
    <lat>41.88556</lat>
    <lon>-87.65292</lon>
    <heading>89</heading>
    </eta>
    */
    
    // First superclass parser function that gets called. Stop it on the object name you want (eta object is below)
    func parser4(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName:String!, attributes attributeDict: NSDictionary!) {
        
        // store current element name in outer class
        // so it can referenced from other parser method
        element = elementName
        
        if (elementName as NSString).isEqualToString("eta"){
            elements = NSMutableDictionary.alloc()
            elements = [:]
            staID = NSMutableString.alloc()
            staID = ""
            arrT = NSMutableString.alloc()
            arrT = ""
        }
    }
    
    // Second parser func that gets called throughout.
    // gets actual data inside tags
    func parser2(parser: NSXMLParser!, foundCharacters string: String!) {
        if element.isEqualToString("staID"){
            staID.appendString(string)
        } else if element.isEqualToString("arrT"){
            arrT.appendString(string)
        }
    }
    
    // the last parser fun that gets called.
    // called when finding a closing element. Adds the finished strings to dictionary
    func parser3(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!)
    {
        if (elementName as NSString).isEqualToString("eta") {
            if !staID.isEqual(nil) {
                elements.setObject(staID, forKey: "staID")
            }
            if !arrT.isEqual(nil) {
                elements.setObject(arrT, forKey: "arrT")
            }
            
            posts.addObject(elements)
        }
    }
    
    
    // sends a request to cta REST api
    @IBAction func getSomeXML(sender: AnyObject){
        let urlPath: String = "http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx?key=25924988075841f2970d3e7f95c8070c&mapid=40380&max=5"
        let url:NSURL = NSURL(string: urlPath)!
        
        
        //let task = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) in self.dbOutput.text = NSString(data: data, encoding: NSUTF8StringEncoding)
        //}
        
        // uncomment this for standard http request
        //  task.resume()
    }
    
    // example of db query example
    @IBAction func findContact(sender: AnyObject) {
        let contactDB = FMDatabase(path: databasePath)
        
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
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        let docsDir = dirPaths[0] as! String
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

