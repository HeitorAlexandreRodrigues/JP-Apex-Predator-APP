//
//  ContentView.swift
//  JPApexPredators
//
//  Created by Heitor Rodrigues on 11/02/26.
//

import SwiftUI

struct ContentView: View {
    let predators = Predators()
    
    @State var searchText = ""
    @State var alphabetical = false
    @State var currentSelection = ApexPredator.APType.all
    
    var filteredDinos : [ApexPredator] {
        predators.filter(by: currentSelection)
        
        predators.sort(by: alphabetical)
        
        if searchText.isEmpty {
            return predators.apexPredators
        } else {
            return predators.apexPredators.filter {
                predator in
                predator.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    var body: some View {
        NavigationStack {
            List(filteredDinos) { predator in
                NavigationLink {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                } label: {
                    HStack {
                        //dinossaur image
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100 , height: 100)
                            .shadow(color: .white, radius: 1)
                        VStack {
                            //name
                            Text(predator.name)
                                .fontWeight(.bold)
                            
                            //type
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal,13)
                                .padding(.vertical,5)
                                .background(predator.type.background)
                                .clipShape(.capsule)
                        }
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchText)
            .animation(.default, value: searchText)
            .toolbar {
                ToolbarItem(placement : .topBarLeading) {
                    Button {
                        withAnimation {
                            alphabetical.toggle()
                        }
                    } label: {
                        if alphabetical {
                            Image(systemName: "film")
                        } else {
                            Image(systemName: "textformat")
                        }
                    }   .symbolEffect(.bounce, value: alphabetical)
                }
                ToolbarItem(placement : .topBarTrailing ) {
                    Menu {
                        Picker("Filter" , selection: $currentSelection.animation()) {
                            ForEach(ApexPredator.APType.allCases) { type in
                                Label(type.rawValue.capitalized,systemImage:type.icon)
                            }
                        }
                    }label : {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
