//
//  PlanetListView.swift
//  Planets
//
//  Created by Vibha Mangrulkar on 2021/11/19.
//

import SwiftUI

struct PlanetListView: View {
    @ObservedObject private var viewModel = PlanetListViewModel(client: APIClient(),
                                                                dataManager: CoreDataManager())
    @State private var selection: Set<Results> = []
    @State private var searchQuery: String = ""
    
    var body: some View {
        /// Display navigation view
        NavigationView {
            ///Display loading when api call
            if viewModel.isLoading {
                VStack {
                    Text("planets.activity.indicator.title".localized())
                        .bold()
                    ActivityIndicatorView(isAnimating: .constant(true), style: .large)
                }
                .frame(width: Constants.activityIndicatorWidth, height: Constants.activityIndicatorHeight, alignment: .center)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(Constants.activityIndicatorCornerRadius)
                .opacity(viewModel.isLoading ? 1 : 0)
                
            } else {
                /// Display planet list when receive response
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        Section(header: SearchBar(text: self.$searchQuery)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: Constants.searchBarCornerRadius)
                                            .stroke(Color.secondary, lineWidth: 1.0)
                                    )
                                    .padding()) {
                            ForEach(viewModel.planets.filter {
                                self.searchQuery.isEmpty ?
                                    true :
                                    "\($0.name)".contains(self.searchQuery)
                            } , id: \.self) { planet in
                                PlanetCell(details: planet, isExpanded: self.selection.contains(planet))
                                    .onTapGesture { self.selectDeselectExpandableCell(planet) }
                            }
                                    }.accessibility(identifier: "SearchBar")
                    }
                }
                .accessibility(identifier: "ScrollView")
                .padding(.leading, 5)
                .padding(.trailing, 5)
                .animation(.easeOut)
                .navigationBarTitle(Text("planets.screen.title".localized()), displayMode: .inline)
                .background(
                        Image("PlanetSplash")
                            .resizable()
                            .scaledToFill()
                    )
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            viewModel.fetchPlanets()
        }
    }
    
    /// Expand / collapse the cell
    /// - Parameter planetDetails: model object
    private func selectDeselectExpandableCell(_ planetDetails: Results) {
        if selection.contains(planetDetails) {
            selection.remove(planetDetails)
        } else {
            selection.insert(planetDetails)
        }
    }
}
