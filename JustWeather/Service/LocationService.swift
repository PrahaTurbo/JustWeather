//
//  LocationService.swift
//  JustWeather
//
//  Created by Артем Ластович on 17.05.2022.
//

import Combine
import Foundation
import MapKit
import CoreLocation

@MainActor final class LocationService: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    @Published var locationResults = [MKLocalSearchCompletion]()
    
    @Published var searchTerm = "" {
        didSet {
            searchCompleter.delegate = self
            searchCompleter.region = MKCoordinateRegion()
            searchCompleter.resultTypes = MKLocalSearchCompleter.ResultType([.address])
            
            getCities(searchText: searchTerm)
            
            if searchTerm.isEmpty {
                locationResults.removeAll()
            }
        }
    }
    
    func getCities(searchText: String) {
        searchCompleter.queryFragment = searchText
        locationResults = searchCompleter.results
    }
    
    func getCoordinates(for city: String, subtitle: String) async -> Location {
        do {
            let placemarks = try await CLGeocoder().geocodeAddressString(city)

            let coordinates = placemarks[0].location?.coordinate ?? CLLocationCoordinate2D(latitude: 20, longitude: 20)
            
            print("Succesfully got coodinates for: \(city)")
            print(coordinates)
            return Location(name: city, subtitle: subtitle, latitude: String(coordinates.latitude), longitude: String(coordinates.longitude))
        } catch {
            print("Unable to get coordinates for: \(city)")
        }
        
        return Location.placeholder
    }
    
//    private var cancellables : Set<AnyCancellable> = []
    
    private var searchCompleter = MKLocalSearchCompleter()
    
//    private var currentPromise : ((Result<[MKLocalSearchCompletion], Error>) -> Void)?
    
//    override init() {
//        super.init()
//        searchCompleter.delegate = self
//        searchCompleter.region = MKCoordinateRegion()
//        searchCompleter.resultTypes = MKLocalSearchCompleter.ResultType([.address])
//
//        $searchTerm
//            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
//            .removeDuplicates()
//            .flatMap({ (currentSearchTerm) in
//                self.searchTermToResults(searchTerm: currentSearchTerm)
//            })
//            .sink(receiveCompletion: { (completion) in
//                //handle error
//            }, receiveValue: { (results) in
//                self.locationResults = results
//            })
//            .store(in: &cancellables)
//    }
//
//    func searchTermToResults(searchTerm: String) -> Future<[MKLocalSearchCompletion], Error> {
//        Future { promise in
//            self.searchCompleter.queryFragment = searchTerm
//            self.currentPromise = promise
//        }
//    }
//}
//
//extension MapSearch : MKLocalSearchCompleterDelegate {
//    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
//            currentPromise?(.success(completer.results))
//        }
//
//    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
//        //could deal with the error here, but beware that it will finish the Combine publisher stream
//        //currentPromise?(.failure(error))
//    }
}


//struct LocalSearchViewData: Identifiable {
//    var id = UUID()
//    var title: String
//    var subtitle: String
//
//    init(mapItem: MKMapItem) {
//        self.title = mapItem.name ?? ""
//        self.subtitle = mapItem.placemark.title ?? ""
//    }
//}
//
//final class LocalSearchService {
//    let localSearchPublisher = PassthroughSubject<[MKMapItem], Never>()
//    private let center: CLLocationCoordinate2D
//    private let radius: CLLocationDistance
//
//    init(in center: CLLocationCoordinate2D,
//         radius: CLLocationDistance = 350_000) {
//        self.center = center
//        self.radius = radius
//    }
//
//    public func searchCities(searchText: String) {
//        request(resultType: .address, searchText: searchText)
//    }
//
//    public func searchPointOfInterests(searchText: String) {
//        request(searchText: searchText)
//    }
//
//    private func request(resultType: MKLocalSearch.ResultType = .pointOfInterest,
//                         searchText: String) {
//        let request = MKLocalSearch.Request()
//        request.naturalLanguageQuery = searchText
//        request.pointOfInterestFilter = .includingAll
//        request.resultTypes = resultType
//        request.region = MKCoordinateRegion(center: center,
//                                            latitudinalMeters: radius,
//                                            longitudinalMeters: radius)
//        let search = MKLocalSearch(request: request)
//
//        search.start { [weak self] (response, _) in
//            guard let response = response else {
//                return
//            }
//
//            self?.localSearchPublisher.send(response.mapItems)
//        }
//    }
//}

//@MainActor class LocationService: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
//
//    private var completer = MKLocalSearchCompleter()
//
//    @Published var searchTerms = [String]()
//
//    @Published var searchText = "" {
//        didSet {
//            searchFor(term: oldValue)
//        }
//    }
//
//    // triggers the search-as-you-type
//    //
//    func searchFor(term: String) {
//        completer.delegate = self
//        completer.region = MKCoordinateRegion(.world)
//        completer.pointOfInterestFilter = MKPointOfInterestFilter.excludingAll
//        completer.queryFragment = term
//
//        completerDidUpdateResults(completer)
//    }
//
//    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
//
//        let results = completer.results.filter { result in
//            guard result.title.contains(",") || !result.subtitle.isEmpty else { return false }
//            guard !result.subtitle.contains("Nearby") && !result.subtitle.contains("возле") else { return false }
//            return true
//        }
//
//        searchTerms = results.map { $0.title + ($0.subtitle.isEmpty ? "" : ", " + $0.subtitle) }
//    }
//}

