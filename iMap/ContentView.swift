//
//  ContentView.swift
//  iMap
//
//  Created by A.f. Adib on 12/24/23.
//
import MapKit
import SwiftUI

struct ContentView: View {
   
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack{
            Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                
                MapAnnotation(coordinate: location.coordinate ) {
                    VStack{
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 44, height: 44)
                            .background(.white)
                            .clipShape(Circle())
                        
                        Text(location.name)
                            .fixedSize()
                    }
                    .onTapGesture {
                        viewModel.selectedPlace = location
                    }
                }
            }
                .ignoresSafeArea()
            
            Circle()
                .fill(.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
            VStack{
                Spacer()
                
                HStack{
                    Spacer()
                    
                    Button{
                        viewModel.addLocation()
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(.black.opacity(0.7))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
        }
        .sheet(item: $viewModel.selectedPlace) { place in
            EditView(location: place) { newLoc in
                viewModel.update(location: newLoc)
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
