//
//  ctaBusReqest.swift
//  dbPlay
//
//  Created by paul hawk on 5/19/15.
//  Copyright (c) 2015 DePaul University. All rights reserved.
//

import Foundation

class ctaTrainRequesHttp {
    let busKey : String? = "E3bHdi46tLzpWHgXH9GY5kQF8"
    
    let timeBaseUrl : String? = "http://www.ctabustracker.com/bustime/api/v1/gettime"
    let vehiclesBaseUrl : String? = "http://www.ctabustracker.com/bustime/api/v1/getvehicles"
    let routesBaseUrl : String? = "http://www.ctabustracker.com/bustime/api/v1/getroutes"
    let routesDirectionsBaseUrl: String? = "http://www.ctabustracker.com/bustime/api/v1/getdirections"
    let stopsBaseUrl : String? = "http://www.ctabustracker.com/bustime/api/v1/getstops"
    let patternsBaseUrl : String? = "http://www.ctabustracker.com/bustime/api/v1/getpatterns"
    let predictionsBaseUrl : String? = "http://www.ctabustracker.com/bustime/api/v1/getpredictions"
    let serviceBulletinsBaseUrl : String? = "http://www.ctabustracker.com/bustime/api/v1/getservicebulletins"
    
    // time -- gets cta offical time
    func busTime() -> String? {
        if let bk = busKey, tu = timeBaseUrl {
            return "\(tu)?key=\(bk)"
        }
        return nil
    }
    
    //  vehicles retrieve vehicle information (i.e., locations) of all or a subset of vehicles currently being tracked by BusTime
    //  rt or vid required but not both
    func vehicles (vid:String?, rt:String?) -> String?  {
        if vid == nil && rt == nil { return nil }
        if vid != nil && rt != nil { return nil }
        
        if let bk = busKey, u = vehiclesBaseUrl {
            let url = "\(u)?key=\(bk)"
            
            if let v = vid{
                return (url + "&vid=\(v)")
            }
            if let r = rt{
                return (url + "&rt=\(r)")
            }
        }
        return nil
    }
    
    // routes -- gets all the routes
    func routes () -> String? {
        if let bk = busKey, u = routesBaseUrl {
            return "\(u)?key=\(bk)"
        }
        return nil
    }
    
    // routesDirection -- gets the direction strings for the rts
    // should be put in the db?
    func routesDirection(route:String?) -> String? {
        if let bk = busKey, u = routesDirectionsBaseUrl, rt = route {
            return "\(u)?key=\(bk)&rt=\(rt)"
        }
        return nil
    }
    
    // stops gets the stops
    // rt and direction required
    func stops (route:String?, direction:String?) -> String? {
        if let bk = busKey, u = stopsBaseUrl,rt = route, dir = direction  {
            return "\(u)?key=\(bk)&rt=\(rt)&dir=\(dir)"
        }
        return nil
    }
    
    // patterns - request to retrieve the set of geo-positional points and stops that when connected
    //   can be used to construct the geo-positional layout of a pattern (i.e., route variation).
    // patterns (pid, rt)
    
    func patterns (patternIds:String?, route:String?) -> String? {
        if (patternIds == nil && route == nil) || (patternIds != nil && route != nil) { return nil }
        if let bk = busKey, u = patternsBaseUrl{
            let url = "\(u)?key=\(bk)"
            if let pid = patternIds {
                return  (url + "&pid=\(pid)")
            }
            if let r = route {
                return (url + "&rt=\(r)")
            }
        }
        return nil
    }
    // Predictions - times of busses by
    // vid or stpid required but not both
    // rt only with vid - optional
    // top - optional
    
    func predictions (stpid:String?, rt:String?,vid:String?,top:String?) -> String? {
        if (stpid != nil && vid != nil) || (stpid == nil && vid == nil) || (stpid != nil && rt != nil) { return nil }
        if let bk = busKey, u = predictionsBaseUrl {
            var url = "\(u)?key=\(bk)"
            if let s = stpid {
                url = "\(url)&stpid=\(s)"
            }
            if let v = vid {
                url  = "\(url)&vid=\(v)"
            }
            if let r = rt {
                url  = "\(url)&rt=\(r)"
            }
            if let t = top {
                url = "\(url)&top=\(t)"
            }
            return url
        }
        return nil
    }
    
    // serviceBulletins - list of service bulletins that are in effect for a route(s) (rt), route &
    //    direction (rt & rtdir), route & direction & stop (rt & rtdir & stpid), or stop(s) (stpid).
    
    // rt or stpid required but not both
    // rtdir - optional
    
    func serviceBulletins (rt:String?, rtDir: String?, stpid:String? ) -> String? {
        if (rt == nil && stpid == nil) || (rt != nil && stpid != nil) { return nil }
        if let u = serviceBulletinsBaseUrl, bk = busKey {
        var url = "\(u)?key=\(bk)"
        if let r = rt {
            url = "\(url)&rt=\(r)"
        }
        if let s = stpid {
                url = "\(url)&stpid=\(s)"
        }
        if let rd = rtDir {
                    url = "\(url)&Rtdir=\(rd)"
        }
        return url
        }
        return nil
    }
}
