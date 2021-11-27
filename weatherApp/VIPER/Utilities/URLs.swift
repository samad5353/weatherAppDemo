//
//  URLs.swift
//  weatherApp
//
//  Created by Abdul Samad on 11/26/21.
//

import Foundation

struct APPURL {
    static let BaseURL                  = "https://api.openweathermap.org/data/2.5/onecall?"
    
    struct Weather {
        static let oneLoginForForcast = "lat=%f&lon=%f&exclude=alerts,minutely&appid=%@&units=metric"
    }
}
