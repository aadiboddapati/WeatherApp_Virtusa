//
//  WeatherAppVirtusaTests.swift
//  WeatherAppVirtusaTests
//
//  Created by Aadi on 9/5/24.
//

import XCTest
@testable import WeatherAppVirtusa

final class WeatherAppVirtusaTests: XCTestCase {

    var viewModel: WeatherViewModel!
    var mockService: MockWeatherService!
    var mockWeatherResponse: WeatherResponse!
    
    override func setUp() {
        super.setUp()
        mockService = MockWeatherService()
        viewModel = WeatherViewModel(with: mockService)
        mockWeatherResponse = WeatherResponse(
            coord: Coord(lon: -122.4194, lat: 37.7749),
            weather: [Weather(id: 801, main: "Clouds", description: "few clouds", icon: "02d")],
            base: "stations",
            main: Main(temp: 293.15, feelsLike: 293.15, tempMin: 293.15, tempMax: 293.15, pressure: 1012, humidity: 56, seaLevel: 1012, grndLevel: 1012),
            visibility: 10000,
            wind: Wind(speed: 5.66, deg: 290, gust: 6.96),
            clouds: Clouds(all: 20),
            dt: 1627485600,
            sys: Sys(type: 1, id: 5122, country: "US", sunrise: 1627465410, sunset: 1627519200),
            timezone: -25200,
            id: 5392171,
            name: "Grapevine",
            cod: 200
        )
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
        mockService = nil
        mockWeatherResponse = nil
    }
    
    func testAPISuccess() {
        var mockCity = "Grapevine"
        mockService.mockWeatherResponse = mockWeatherResponse
        
        let expectaion = self.expectation(description: "API success")
        viewModel.fetchWeather(by: mockCity) { isSuccess in
            XCTAssertTrue(isSuccess)
            XCTAssertEqual(mockCity, self.viewModel.weather?.name ?? "")
            expectaion.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
}
