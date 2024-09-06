//
//  WeatherAPI.swift
//  WeatherAppVirtusa
//
//  Created by Aadi on 9/5/24.
//

import Foundation

enum WeatherAPI {
    case weather(city: String)
    case weatherIcon(iconName: String)
    case generic(path: String, queryItems: [URLQueryItem])

    private var baseURL: String {
        return "https://api.openweathermap.org/data/2.5/"
    }

    private var iconBaseURL: String {
        return "https://openweathermap.org/img/wn/"
    }

    private var apiKey: String {
        return "c516d8afc7e3ce0fc92646d27c66d2c0"
    }

    var url: URL? {
        switch self {
        case .weather(let city):
            var components = URLComponents(string: "\(baseURL)weather")
            components?.queryItems = [
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "appid", value: apiKey),
                URLQueryItem(name: "units", value: "imperial")
            ]
            return components?.url
            
        case .weatherIcon(let iconName):
            return URL(string: "\(iconBaseURL)\(iconName)@2x.png")

        case .generic(let path, let queryItems):
            var components = URLComponents(string: "\(baseURL)\(path)")
            var items = queryItems
            items.append(URLQueryItem(name: "appid", value: apiKey))
            components?.queryItems = items
            return components?.url
        }
    }
}
