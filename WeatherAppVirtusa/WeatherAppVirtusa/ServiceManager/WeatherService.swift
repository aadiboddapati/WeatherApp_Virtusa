//
//  WeatherService.swift
//  WeatherAppVirtusa
//
//  Created by Aadi on 9/5/24.
//

import Foundation
import Combine

protocol WeatherServiceInterface {
    func fetchData(_ api: WeatherAPI) -> AnyPublisher<WeatherResponse, NetworkError>
}

public enum NetworkError: Error {
    case invalidURL
    case serviceError
    case dataParsing(String)
    case unknown
}

class WeatherService: WeatherServiceInterface {
    
    func fetchData<T: Decodable>(_ api: WeatherAPI) -> AnyPublisher<T, NetworkError> {
        guard let url = api.url else {
            return Fail(error: NetworkError.invalidURL)
                    .eraseToAnyPublisher()
        }
        
       return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                guard let httpUrlResponse = output.response as? HTTPURLResponse,
                      httpUrlResponse.statusCode == 200 else {
                    throw NetworkError.invalidURL
                }
                
                guard let decodedData = try? JSONDecoder().decode(T.self, from: output.data) else {
                    throw NetworkError.dataParsing("failed to parse the data")
                }
                
                return decodedData
            }
            .mapError({ error -> NetworkError in
                if let parsedError = error as? NetworkError {
                    return parsedError
                }
                return NetworkError.unknown
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()

    }
    
}
