//
//  DataModel.swift
//  task3
//
//  Created by Yura Vorontsov on 21.08.15.
//  Copyright (c) 2015 Yura Vorontsov. All rights reserved.
//

import Foundation

struct Data: Printable
{
    var localId: Int
    var id: Int?
    var name: String = ""
    var latitude: Double = 0
    var longitude: Double = 0
    var spnLatitude: Double = 0
    var spnLongitude: Double = 0
    init (a: Int){localId = a}
    var description: String{get{return "Город \(name), \(latitude), \(longitude), \(spnLatitude), \(spnLongitude)\n"}}
}


class DataModel
{
    let url = "http://beta.taxistock.ru/taxik/api/client/query_cities"
    var data = [Data]()
    
    func downloadData()
    {
        var theError: NSErrorPointer = nil
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: url)!, completionHandler: {(dataNw: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            if let results = NSJSONSerialization.JSONObjectWithData(dataNw, options: NSJSONReadingOptions.AllowFragments, error: theError) as? NSDictionary
            {
                if let cities = results["cities"] as? NSArray
                {
                    for var i = 0; i<cities.count; i++
                    {
                        var localData = Data(a: i)
                        if let city = cities[i] as? NSDictionary
                        {
                            if let name = city["city_name"] as? String
                            {
                                localData.name = name
                                if let longitude = city["city_longitude"] as? Double
                                {
                                    localData.longitude = longitude
                                    if let latitude = city["city_latitude"] as? Double
                                    {
                                        localData.latitude = latitude
                                        if let spnLongitude = city["city_spn_longitude"] as? Double
                                        {
                                            localData.spnLongitude = spnLongitude
                                            if let spnLatitude = city["city_spn_latitude"] as? Double
                                            {
                                                localData.spnLatitude = spnLatitude
                                                if let id = city["city_id"] as? Int
                                                {
                                                    localData.id = id
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        if localData.id == nil
                        {
                            break
                        }
                        self.data.append(localData)
                    }
                }
            }
            print("\(self.data)\n")
            dispatch_async(dispatch_get_main_queue())
            {
                NSNotificationCenter.defaultCenter().postNotificationName("dataReady", object: nil)
            }
        }).resume()
    }
}
