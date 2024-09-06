//
//  WeatherDetailView.swift
//  WeatherAppVirtusa
//
//  Created by Aadi on 9/5/24.
//

import SwiftUI

struct WeatherDetailView: View {
    let weather: WeatherResponse
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Text("Weather in \"\(weather.name ?? "")\"")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(Color.primary)
                
                Text("\(weather.main?.temp ?? 0.0, specifier: "%.1f")°F")
                    .font(.system(size: 80))
                    .fontWeight(.heavy)
                    .padding()
                    .foregroundColor(Color.accentColor)
                
                if let condition = weather.weather?.first {
                    Text(condition.main ?? "")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.primary)
                    
                    if let iconURL = WeatherAPI.weatherIcon(iconName: condition.icon ?? "").url {
                        AsyncImage(url: iconURL) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 150, height: 150)
                    }
                    
                    Text(condition.description?.capitalized ?? "")
                        .font(.title2)
                        .foregroundColor(Color.secondary)
                        .padding(.bottom, 16)
                }
            }
            .padding(.horizontal, 16)
            .background(Color(UIColor.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 8)
        }
       
    }
}

