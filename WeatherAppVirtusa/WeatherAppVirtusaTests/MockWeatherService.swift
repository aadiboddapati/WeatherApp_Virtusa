//
//  MockWeatherService.swift
//  WeatherAppVirtusaTests
//
//  Created by Aadi on 9/5/24.
//

import Combine
@testable import WeatherAppVirtusa

class MockWeatherService: WeatherServiceInterface {
    var mockWeatherResponse: WeatherResponse?
    var mockError: NetworkError?
    
    func fetchData(_ api: WeatherAppVirtusa.WeatherAPI) -> AnyPublisher<WeatherAppVirtusa.WeatherResponse, WeatherAppVirtusa.NetworkError> {
        
        guard let url = api.url else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        if let response = mockWeatherResponse {
            return Just(response)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
        
        return Fail(error: NetworkError.dataParsing("failed to parse data"))
            .eraseToAnyPublisher()
    }
    
    
}
