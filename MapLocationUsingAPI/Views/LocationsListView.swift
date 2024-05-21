//
//  LocationsListView.swift
//  MapLocationUsingAPI
//
//  Created by Aniket Patil on 21/05/24.
//

import SwiftUI

struct LocationsListView: View {
    @EnvironmentObject private var vm: LocationsViewModel

    var body: some View {
        List {
            ForEach(vm.countries) { country in
                Button(action: {
                    vm.showNextCountry(country: country)
                }) {
                    listRowView(country: country)
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(PlainListStyle())
    }

    private func listRowView(country: Country) -> some View {
        HStack {
            AsyncImage(url: URL(string: country.flags.png)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .scaledToFill()
            .frame(width: 45, height: 45)
            .cornerRadius(10)

            VStack(alignment: .leading) {
                Text(country.name.common)
                    .font(.headline)
                Text(country.region)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

