//
//  ctaRequestModelTest.swift
//  dbPlay
//
//  Created by paul hawk on 5/18/15.
//  Copyright (c) 2015 DePaul University. All rights reserved.
//

import Foundation

 //------------ test arrivals ---------------//

   // let tr = ctaRequestModel()

    var mid     : Int?  = 40380
    var sid     : Int?      // map or stp reqired
    var maxRt   : Int?      // optional
    var rts     : Int?      // optional

    let arivalHttpActual = tr.trainRequest.arrivals(mapId: mid, stpId: sid, maxRet: maxRt, rt: rts)

    let arivalHttpExpected : String? = "lapi.transitchicago.com/api/1.0/ttarrivals.aspx?key=25924988075841f2970d3e7f95c8070c&mapid=40380"

// ------------Follow This Train API ---------------//

    var followRunNumber : Int?  = 209
    let followTestActual =  tr.followTrain(followRunNumber)
    let followTestExpected = "lapi.transitchicago.com/api/1.0/ttfollow.aspx?key=25924988075841f2970d3e7f95c8070c&runnumber=209"


// ------------Locations API ---------------//

    var locationsRt : String?  = "Red"         //required
    let locationsTestActual = tr.locations(locationsRt)
    let locationsTestExpected = "xx"


