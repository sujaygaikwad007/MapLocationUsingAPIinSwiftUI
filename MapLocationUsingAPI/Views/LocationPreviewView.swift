//
//  LocationPreviewView.swift
//  MapLocationUsingAPI
//
//  Created by Aniket Patil on 21/05/24.
//

import SwiftUI

struct LocationPreviewView: View {
    @EnvironmentObject private var vm: LocationsViewModel
    let country: Country

    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16.0) {
                imageSection
                titleSection
            }
            VStack(spacing: 8) {
                nextButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        )
        .cornerRadius(10)
    }

    private var imageSection: some View {
        AsyncImage(url: URL(string: country.flags.png)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .scaledToFill()
        .frame(width: 100, height: 100)
        .cornerRadius(10)
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }

    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(country.name.common)
                .font(.headline)
                .fontWeight(.bold)
            Text(country.region)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var nextButton: some View {
        Button {
            vm.nextButtonPressed()
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)
    }
}

