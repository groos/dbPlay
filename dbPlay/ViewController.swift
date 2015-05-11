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

