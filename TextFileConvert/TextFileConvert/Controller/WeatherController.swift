//
//  WeatherController.swift
//  TextFileConvert
//
//  Created by Lilianna Kinakh on 2/27/19.
//  Copyright © 2019 Lilianna Kinakh. All rights reserved.
//

import Foundation

class WeatherController {
    
    // MARK: Properties
    
    var dictWeather = [String:String]()
    var arrayWeathers = [Dictionary<String, String>]()
    
    var description = ""
    var currentStation = ""
    
    let stations = ["armaghdata","aberporthdata","ballypatrickdata","bradforddata","braemardata"]
    
    func findStartWord(strArray:[String])-> Int {
        var row = 0
        
        for j in 0..<strArray.count {
            if "yyyy" == strArray[j].split(separator: " ").first.map(String.init) {
                row = (j+2)
                break
            }
        }
        return row
    }
    
    func setupInfoInTableView(station: String) {
        
        var returnedString: String
        arrayWeathers.removeAll()
        
        let urlString = "https://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/"+"\(station)"+".txt"
        guard let url = URL(string: urlString) else { return }
        
        do {
            let result = try! String(contentsOf: url, encoding: String.Encoding.utf8)
            returnedString = result
        } catch let error {
            print(error)
        }
        
        var readings = returnedString.components(separatedBy: "\n") as [String]
        let start = findStartWord(strArray: readings)
        for i in start..<readings.count {
            
            let filterData = readings[i].condensingWhitespace()
            var currentData = filterData.components(separatedBy: " ")
            
            dictWeather["yyyy"] = "\(currentData[0])"
            dictWeather["mm"] = "\(currentData[1])"
            dictWeather["tmax"] = "\(currentData[2])"
            dictWeather["tmin"] = "\(currentData[3])"
            dictWeather["af"] = "\(currentData[4])"
            dictWeather["rain"] = "\(currentData[5])"
            dictWeather["sun"] = "\(currentData[6])"
            
            arrayWeathers.append(dictWeather)
            
        }
        
        description = readings[1]
        currentStation = readings[0]
    
    }
    
}
