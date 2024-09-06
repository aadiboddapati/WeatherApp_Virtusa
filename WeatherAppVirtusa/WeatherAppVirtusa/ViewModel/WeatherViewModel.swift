//
//  WeatherViewModel.swift
//  WeatherAppVirtusa
//
//  Created by Aadi on 9/5/24.
//

import Combine
import CoreLocation

class WeatherViewModel: ObservableObject {
    private var weatherService: WeatherServiceInterface
    private var coredataManager: CoreDataManager
    private var locationHandler: LocationPermissionHandler
    private var cancellables = Set<AnyCancellable>()
    
    var weather: WeatherResponse?
    @Published var cityName: String = ""
    @Published var errorMessage: String = ""
    @Published var showProgress: Bool = false
    @Published var savedCity: City?
    
    init(with service: WeatherServiceInterface = WeatherService(),
         coreDataManager: CoreDataManager = .shared,
         locationHandler: LocationPermissionHandler = .shared) {
        self.weatherService = service
        self.coredataManager = coreDataManager
        self.locationHandler = locationHandler
        fetchSavedLocation()
    }
    
    func fetchWeather(by city: String) {
        guard LocationPermissionHandler.shared.checkLocationPermissionAccess() else {
            self.showProgress = false
            return
        }
        errorMessage = ""
        showProgress = true
        weatherService.fetchData(WeatherAPI.weather(city: city))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = "Failed to fetch weather: \(error.localizedDescription)"
                    self.showProgress = false
                case .finished:
                    break
                }
            }, receiveValue: { [self] weatherResponse in
                self.weather = weatherResponse
                self.showProgress = false
                self.coredataManager.insertCity(city)
                fetchSavedLocation()
                navigateToDetailView()
            })
            .store(in: &cancellables)
    }
    
    func fetchSavedLocation() {
        let objects = CoreDataManager.shared.fetch(City.self)
        if let object = objects.first {
            self.savedCity = object
        }
    }
    
    func navigateToDetailView() {
        guard let wrappedWeather = weather else {
            return
        }
        
        AppRoutuer.shared.navigate(to: WeatherDetailView(weather: wrappedWeather),
                                       navigationType: .push)
    }
}

