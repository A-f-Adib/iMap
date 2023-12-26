//
//  EditViw.swift
//  iMap
//
//  Created by A.f. Adib on 12/26/23.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    
    enum LoadingState {
        case loading, loaded, fialed
    }
    
    @State private var loadingState = LoadingState.loading
    @State private var pages = [Page]()
    
    
    var location : Location
    var onSave : (Location) -> Void
    
    @State private var name : String
    @State private var description : String
    
    var body: some View {
        NavigationView{
            Form{
                Section {
                    TextField("Place name ", text: $name)
                        .font(.title3.bold())
                    TextField("description" , text: $description)
                }
                
                
                Section("Nearby Places..."){
                    switch loadingState {
                        
                    case .loading:
                        Text("Loading Data...")
                        
                    case .loaded:
                        ForEach(pages, id: \.pageId) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ")
                            + Text(page.description)
                        }
                        
                    case .fialed:
                        Text("Failed to load data. Try again...")
                    }
                }
            }
            .navigationTitle("Place Details")
            .toolbar {
                Button("Save") {
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.descripton = description
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await fetchNearbyPlaces()
            }
        }
    }
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave
        
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.descripton)
    }
    
    
    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        
        
        guard let url = URL(string: urlString) else {
            print("Bad url : \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(Result.self, from: data)
            pages = items.query.pages.values.sorted()
            loadingState = .loaded
        } catch {
            loadingState = .fialed
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location : Location.example) { _ in}
    }
}
