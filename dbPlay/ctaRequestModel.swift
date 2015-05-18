//
//  ctaRequestModel.swift
//  dbPlay
//
//  Created by paul hawk on 5/18/15.
//  Copyright (c) 2015 DePaul University. All rights reserved.
//

import Foundation
import UIKit

class ctaRequestModel {
    
    let Trainkey : String? = "25924988075841f2970d3e7f95c8070c"

    let baseUrlArivals : String?   =    "lapi.transitchicago.com/api/1.0/ttarrivals.aspx"
    let baseUrlLocations :String?  =    "api.transitchicago.com/api/1.0/ttpositions.aspx"
    let baseUrlFollowTrain:String? =    "http://lapi.transitchicago.com/api/1.0/ttfollow.aspx"

    var mid     : Int?  // map or stp reqired
    var sid     : Int?  // map or stp reqired
    var maxRt   : Int?   // optional
    var rts     : Int?    // optional
    
    
    init () {} 

    // ------------Arivals API ---------------//
    //This API produces a list of arrival predictions for all platforms at a given train station in a well-formed XML document. 
    // Registration and receipt of an API key is required for use of this API.
    // Requirments input
    //      base url
    //      mapID or stpID

    func arrivals (mapId:Int?, stpId:Int?, maxRet:Int?, rt:Int?) -> String? {
        if mapId == nil && stpId == nil { return nil } // one required
        if self.baseUrlArivals == nil || self.Trainkey == nil { return nil } // from class
        
        var http = "\(self.baseUrlArivals)?key=\(self.Trainkey)"
        
        //get one of the mapid (pref) or stpID
        if let m = mapId { http += "&mapid=\(m)" }
        else{ if let s = stpId { http += "&stpid=\(s)" } }
        
        //fill in optional items if found
        if let m = maxRet  { http += "&smax=\(m)" }
        if let r = rt { http += "&rt=\(r)" }

        return http
    }


    // ------------Follow This Train API ---------------//

    //This API produces a list of arrival predictions for a given train at all subsequent stations for which that train is estimated to arrive, up to 20 minutes in the future or to the end of its trip.

    func followTrain(runNumber:Int?) -> String? {
        if (self.baseUrlFollowTrain == nil || self.Trainkey == nil || runNumber == nil) {return nil}
        return "\(baseUrlFollowTrain)?key=\(Trainkey)&runnumber=\(runNumber!)"
    }


    // ------------Locations API ---------------//

    // This API produces a list of in-service trains and basic info and their locations for one or more specified ‘L’ routes.

    func locations(rt:String?) -> String? {
        if (self.baseUrlLocations == nil || rt == nil || self.Trainkey == nil) { return nil }
        return ("\(self.baseUrlLocations)?key=\(key)&rt=\(rt)")
        
    }


}


