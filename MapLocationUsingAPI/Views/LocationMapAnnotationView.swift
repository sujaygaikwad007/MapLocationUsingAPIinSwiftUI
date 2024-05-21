//
//  LocationMapAnnotationView.swift
//  MapLocationUsingAPI
//
//  Created by Aniket Patil on 21/05/24.
//

import SwiftUI

struct LocationMapAnnotationView: View {
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(.red)
                .background(Color.white)
                .clipShape(Circle())
            
            Image(systemName: "arrowtriangle.down.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 10, height: 10)
                .foregroundColor(.red)
                .offset(y: -5)
        }
    }
}

