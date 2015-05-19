//
//  ctaBusReqest.swift
//  dbPlay
//
//  Created by paul hawk on 5/19/15.
//  Copyright (c) 2015 DePaul University. All rights reserved.
//

import Foundation

class ctaBusReqest {

    let busKey : String? = "E3bHdi46tLzpWHgXH9GY5kQF8"

    let timeBaseUrl : String? = "http://www.ctabustracker.com/bustime/api/v1/gettime"
    let vehiclesBaseUrl : String? = "http://www.ctabustracker.com/bustime/api/v1/getvehicles"
    let routesBaseUrl : String? = "http://www.ctabustracker.com/bustime/api/v1/getroutes"
    let routesDirectionsBaseUrl: String? = "http://www.ctabustracker.com/bustime/api/v1/getdirections"
    let stopsBaseUrl : String? = "http://www.ctabustracker.com/bustime/api/v1/getstops"
    let patternsBaseUrl : String? = "http://www.ctabustracker.com/bustime/api/v1/getpatterns"
    let predictionsBaseUrl : String? = "http://www.ctabustracker.com/bustime/api/v1/getpredictions"
    let serviceBulletinsBaseUrl : String? = "http://www.ctabustracker.com/bustime/api/v1/getservicebulletins"

    init(){}

    func busTime() -> String? {
        if busKey == nil || timeBaseUrl == nil { return nil}
        return "\(timeBaseUrl)?key=\(busKey)"
    }

    func vehicles (vid:String?, rt:String?) -> String?  {
        if self.busKey == nil || self.vehiclesBaseUrl == nil { return nil }
        if (vid == nil && rt == nil) || (vid != nil && rt != nil) { return nil }
        
        let retAddress = "\(timeBaseUrl)?key=\(busKey)"
        return vid != nil ?  (retAddress + "&vid=\(vid)") : (retAddress + "&rt=\(rt)")
        
    }

    func routes () -> String? {
        if self.busKey == nil || self.routesBaseUrl == nil { return nil }
        return "\(routesBaseUrl)?key=\(busKey)"
    }

    func routesDirection(route:String?) -> String? {
        if self.busKey == nil || self.routesDirectionsBaseUrl == nil { return nil }
        
        if let rt = route {
            let url = "\(self.routesDirectionsBaseUrl)?key=\(self.busKey)&rt=\(rt)"
            return url
        }
        return nil
    }

    func stops (route:String?, direction:String?) -> String? {
        if self.busKey == nil || self.stopsBaseUrl == nil { return nil }
        if let rt = route, dir = direction {
            return "\(self.routesDirectionsBaseUrl)?key=\(self.busKey)&rt=\(rt)&dir=\(dir)"
        }
        return nil
    }

    func patterns (patternIds:String?, route:String?) -> String? {
        if self.busKey == nil || self.patternsBaseUrl == nil { return nil }
        if (patternIds == nil && route == nil) || (patternIds != nil && route != nil) { return nil }
        if rt != nil && vid != nil { return nil }
        let url = "\(self.patternsBaseUrl)?key=\(self.busKey)"
        return (patternIds != nil) ?  (url + "&pid=\(patternIds)") : (url + "&rt=\(route)")
    }

    func predictions (stpid:String?, rt:String?,vid:String?,top:String?) -> String? {
        if self.busKey == nil || self.predictionsBaseUrl == nil { return nil }
        if (stpid != nil && vid != nil) { return nil }
        var url = "\(self.predictionsBaseUrl)?key=\(self.busKey)"
        
        if stpid != nil { url = "\(url)&stpid=\(stpid)" }
        
        if rt != nil {url  = "\(url)&rt=\(rt)" }
        if vid != nil {url  = "\(url)&vid=\(vid)"}
        if top != nil { url = "\(url)&top=\(top)" }
        
        return url
    }

    func serviceBulletins (rt:String?, rtDir: String?, stpid:String? ) -> String? {
        if self.busKey == nil || self.serviceBulletinsBaseUrl == nil { return nil }
        if rt == nil && stpid == nil { return nil }
        
        var url = "\(serviceBulletinsBaseUrl)?key=\(busKey)"
        if rt != nil { url = "\(url)&rt=\(rt)" }
        
        if rtDir != nil { url = "\(url)&Rtdir=\(rtDir)" }
        if stpid != nil { url = "\(url)&stpid=\(stpid)"}
        
        return url
    }
}
