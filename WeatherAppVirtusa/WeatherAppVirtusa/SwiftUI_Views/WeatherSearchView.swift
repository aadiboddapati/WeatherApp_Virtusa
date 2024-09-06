//
//  WeatherSearchView.swift
//  WeatherAppVirtusa
//
//  Created by Aadi on 9/5/24.
//

import SwiftUI

struct WeatherSearchView: View {
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    if let city = viewModel.savedCity,
                       let cityName = city.name {
                        List {
                            Section(header: Text(cityName)) {
                                Text(viewModel.savedCity?.name ?? "")
                                    .padding(.horizontal, 16)
                                    .onTapGesture {
                                        viewModel.fetchWeather(by: cityName)
                                    }
                            }
                        }
                        .listStyle(GroupedListStyle())
                    }
                    
                    if !viewModel.errorMessage.isEmpty{
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    Spacer()
                }
                
                if viewModel.showProgress {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5, anchor: .center)
                }
                
            }
            .navigationBarTitle("Weather Search")
            .searchable(text: $viewModel.cityName, prompt: "Search city name")
            .onSubmit(of: .search) {
                if !viewModel.cityName.isEmpty && viewModel.cityName.count >= 3 {
                    resignFirstResponder()
                    if let prevCityName = viewModel.weather?.name,
                       prevCityName.lowercased() == viewModel.cityName.lowercased() {
                        return
                    }
                    viewModel.fetchWeather(by: viewModel.cityName)
                }
            }
        }
    }
    
    private func resignFirstResponder() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


#Preview {
    WeatherSearchView()
}
