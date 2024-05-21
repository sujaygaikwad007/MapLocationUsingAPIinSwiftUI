//
//  LocationView.swift
//  MapLocationUsingAPI
//
//  Created by Aniket Patil on 21/05/24.
//

import SwiftUI
import MapKit

struct LocationView: View {
    @EnvironmentObject private var vm: LocationsViewModel

    let maxWidthForIpad: CGFloat = 700

    var body: some View {
        ZStack {
            mapLayer
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header
                    .padding()
                    .frame(maxWidth: maxWidthForIpad)
                Spacer()
                locationPreviewStack
            }
        }
    }
}

extension LocationView {
    
    
    private var mapLayer: some View {
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: vm.countries,
            annotationContent: { country in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: country.latlng[0], longitude: country.latlng[1])) {
                LocationMapAnnotationView()
                    .scaleEffect(vm.mapCountry?.id == country.id ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        vm.showNextCountry(country: country)
                    }
            }
        })
    }

    private var header: some View {
        VStack {
            Button {
                vm.toggleCountryList()
            } label: {
                Text((vm.mapCountry?.name.common ?? "") + ", " + (vm.mapCountry?.region ?? ""))
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapCountry)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showCountriesList ? 180 : 0))
                    }
            }

            if vm.showCountriesList {
                LocationsListView()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }

    private var locationPreviewStack: some View {
        ZStack {
            if let mapCountry = vm.mapCountry {
                LocationPreviewView(country: mapCountry)
                    .shadow(color: Color.black.opacity(0.3), radius: 20)
                    .padding()
                    .frame(maxWidth: maxWidthForIpad)
                    .frame(maxWidth: .infinity)
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading))
                    )
            }
        }
    }
}


