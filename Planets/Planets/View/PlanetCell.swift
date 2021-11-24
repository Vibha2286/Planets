//
//  PlanetCell.swift
//  Planets
//
//  Created by Vibha Mangrulkar on 2021/11/19.
//

import SwiftUI

/// Planet cell to display the list of planet
struct PlanetCell: View {
    let details: Results
    var isExpanded: Bool
    
    var body: some View {
        VStack {
            Spacer()
            content
            Spacer()
        }
        .contentShape(Rectangle())
    }
    
    /// Display the data in the cell
    private var content: some View {
        VStack(alignment: .leading, spacing: Constants.spacing5) {
            HStack {
                Text(details.name )
                    .font(.headline)
                    .lineLimit(2)
                Spacer()
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: Constants.listTilteCornerRadius))
            
            if isExpanded {
                VStack(alignment: .leading, spacing: Constants.spacing5) {
                    Spacer()
                    Text("Population: \(details.population)")
                    Text("Climate: \(details.climate)")
                    Text("Gravity: \(details.gravity)")
                    Text("Diameter: \(details.diameter)")
                    Text("Terrain: \(details.terrain)")
                    Spacer()
                }
                .padding(.leading, Constants.spacing10)
            }
        }
        .background(Color.white)
    }
}
