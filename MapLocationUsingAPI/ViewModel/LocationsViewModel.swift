//
//  LocationsViewModel.swift
//  MapLocationUsingAPI
//
//  Created by Aniket Patil on 21/05/24.
//

import Foundation
import MapKit
import SwiftUI
import Combine

class LocationsViewModel: ObservableObject {
    
    let apiURl = "https://restcountries.com/v3.1/all"
    @Published var countries: [Country] = []
    @Published var mapCountry: Country? {
        didSet {
            if let country = mapCountry {
                updateMapRegion(country: country)
            }
        }
    }
    
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
    
    @Published var showCountriesList: Bool = false
    @Published var sheetCountry: Country? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchCountries()
    }
    
    func fetchCountries() {
        if let savedCountriesData = UserDefaults.standard.data(forKey: "countriesData"),
           let savedCountries = try? JSONDecoder().decode([Country].self, from: savedCountriesData) {
            print("Loading countries from UserDefaults:")
            savedCountries.forEach { print($0.name.common) }
            
            self.countries = savedCountries
            if let firstCountry = self.countries.first {
                self.mapCountry = firstCountry
            }
        } else {
            guard let url = URL(string: apiURl) else { return }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .map(\.data)
                .decode(type: [Country].self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Error fetching countries: \(error)")
                    }
                }, receiveValue: { [weak self] countries in
                    // Sort countries alphabetically
                    let sortedCountries = countries.sorted { $0.name.common < $1.name.common }
                    print("Fetched countries from API:")
                    sortedCountries.forEach { print($0.name.common) }
                    
                    self?.countries = sortedCountries
                    if let firstCountry = sortedCountries.first {
                        self?.mapCountry = firstCountry
                    }
                    
                    // Save sorted countries data to UserDefaults
                    if let encodedData = try? JSONEncoder().encode(sortedCountries) {
                        UserDefaults.standard.set(encodedData, forKey: "countriesData")
                    }
                })
                .store(in: &cancellables)
        }
    }
    
    
    
    private func updateMapRegion(country: Country) {
        withAnimation(.easeInOut) {
            if country.latlng.count == 2 {
                mapRegion = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: country.latlng[0], longitude: country.latlng[1]),
                    span: mapSpan)
            }
        }
    }
    
    func toggleCountryList() {
        withAnimation(.easeInOut) {
            showCountriesList.toggle()
        }
    }
    
    func showNextCountry(country: Country) {
        withAnimation(.easeInOut) {
            mapCountry = country
            showCountriesList = false
        }
    }
    
    
    func nextButtonPressed() {
        guard let currentIndex = countries.firstIndex(where: { $0.id == mapCountry?.id }) else { return }
        let nextIndex = currentIndex + 1
        if countries.indices.contains(nextIndex) {
            showNextCountry(country: countries[nextIndex])
        } else {
            showNextCountry(country: countries.first!)
        }
    }
    
    
}
