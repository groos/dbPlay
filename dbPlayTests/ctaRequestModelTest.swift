//
//  CTAhttpRequestTest.swift
//  dbPlay
//
//  Created by paul hawk on 5/18/15.
//  Copyright (c) 2015 DePaul University. All rights reserved.
//

import UIKit
import XCTest

class CTAhttpRequestTest: XCTestCase {
    //  XCTAssertEqual(expected[0], sorted[0], "the array should be sorted properly")
    override func setUp() {
        //super.setUp()
        let tr = ctaRequestModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
    //------------ test arrivals ---------------//
    
    func testArrivals () {
        let tr = ctaRequestModel()
        var mid     : Int?  = 40380
        var sid     : Int?      // map or stp reqired
        var maxRt   : Int?      // optional
        var rts     : Int?      // optional
        
        let arivalHttpActual = tr.arrivals(mid, stpId: sid, maxRet: maxRt, rt: rts)
        
        let arivalHttpExpected : String? = "lapi.transitchicago.com/api/1.0/ttarrivals.aspx?key=25924988075841f2970d3e7f95c8070c&mapid=40380"
        
        XCTAssert(arivalHttpExpected == arivalHttpActual)
        
    }
    // ------------Follow This Train API ---------------//
    func testTrainApi () {
        let tr = ctaRequestModel()
        var followRunNumber : Int?  = 209
        let followTestActual =  tr.followTrain(followRunNumber)
        let followTestExpected = "lapi.transitchicago.com/api/1.0/ttfollow.aspx?key=25924988075841f2970d3e7f95c8070c&runnumber=209"
        
        XCTAssert(followTestExpected == followTestActual)
    }
    
    // ------------Locations API ---------------//
    func testLocation () {
        let tr = ctaRequestModel()
        var locationsRt : String?  = "Red"         //required
        let locationsTestActual = tr.locations(locationsRt)
        let locationsTestExpected = "xx"
        XCTAssertEqual(locationsTestExpected, locationsTestExpected )
    }
    
    
    
    
}
