//
//  ContentView.swift
//  Ini Map
//
//  Created by Muhammad Rifqy Fimanditya on 17/05/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State private var location = CLLocation()
    @State var showHahau = false
    @StateObject private var locationManager = LocationManager()
    @State var showSheet = false
    
    
    
    var routes = [
        LocationModel(name: "AEON", latitude: -6.304494, longitude: 106.644015, openHour: getDateFromHourFormat(dateString: "09:00"), closedHour: getDateFromHourFormat(dateString: "22:00"), image: "image_aeon_1"),
        LocationModel(name: "The Breeze", latitude: -6.301937, longitude: 106.654243, openHour: getDateFromHourFormat(dateString: "09:00"), closedHour: getDateFromHourFormat(dateString: "21:00"), image: "image_thebreeze_1"),
        LocationModel(name: "QBig BSD City", latitude: -6.283754, longitude: 106.636069, openHour: getDateFromHourFormat(dateString: "10:00"), closedHour: getDateFromHourFormat(dateString: "22:00"), image: "image_qbigbsdcity_1")
    ]
    
    var body: some View {
        if showHahau {
            HahauView(locationManager: locationManager)
        }
        else {
            ZStack {
                MapViewCustom(locationManager: locationManager, showSheet: $showSheet)
                    .ignoresSafeArea()
            }
            .sheet(isPresented: $showSheet) {
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Image("\(routes[0].image)")
                            .resizable()
                            .frame(width: 130, height: 120)
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                        
                        VStack(spacing: 5) {
                            HStack {
                                Text("\(routes[0].name)")
                                    .bold()
                                    .font(.title)
                                
                                Spacer()
                            }
                            
                            HStack {
                                Text("Mall")
                                    .foregroundColor(.secondary)

                                Spacer()
                            }
                            
                            LineShape()
                                .stroke(Color.secondary, lineWidth: 1.5)
                                .frame(width: 180, height: 1)
                                .offset(x: 5)
                            
                            HStack(spacing: 30) {
                                VStack {
                                    Text("Hour")
                                        .foregroundColor(Color.secondary)
                                        .font(.system(size: 12))
                                    Text("09.00 -21.00")
                                        .font(.system(size: 18))
                                }
                                
                                LineShape()
                                    .stroke(Color.black, lineWidth: 20)
                                    .frame(width: 1.2, height: 3)
                                
                                VStack {
                                    Text("Distance")
                                        .foregroundColor(Color.secondary)
                                        .font(.system(size: 12))
                                    Text("1 km")
                                        .font(.system(size: 18))
                                }
                            }
                            .padding(.bottom, 20)
                        }
                    }
                    .padding()
                    
                    HStack{
                        Spacer()
                        Button {
                            showHahau = true
                        } label: {
                            Text("Navigate")
                                .frame(width: 70, height: 30)
                        }
                        .buttonStyle(.borderedProminent)
                        Spacer()
                    }
//                    HStack(alignment: .top) {
//                        Image("image_aeon_1")
//                            .resizable()
//                            .frame(width: 150, height: 150)
//                            .scaledToFit()
//                        VStack(alignment: .leading){
//                            Text("ÆON Mall BSD City")
//                                .bold()
//                                .font(.title)
//                                .frame(maxWidth: .infinity)
//                            Text("Mall")
//                                .foregroundColor(.secondary)
//                                .frame(maxWidth: .infinity)
//                            HStack {
//                                VStack {
//                                    Text("Hour")
//                                        .font(.system(size: 15))
//                                        .foregroundColor(.secondary)
//
//                                    Text("Open")
//                                        .font(.system(size: 20))
//                                }
//
//
//
//                                VStack {
//                                    Text("Hour")
//                                        .font(.system(size: 15))
//                                        .foregroundColor(.secondary)
//                                    Text("Open")
//                                        .font(.system(size: 20))
//                                }
//                            }
//                        }
//                        .frame(maxWidth: .infinity)
//                    }
//
//                    .padding(.horizontal)
                }
                .presentationDetents([.height(254)])
                .presentationDragIndicator(.visible)
            }
            .onTapGesture {
                showSheet = true
            }
        }
    }
}

struct MapViewCustom: UIViewRepresentable {
    
    @ObservedObject var locationManager: LocationManager
    @Binding var showSheet: Bool
    @ObservedObject var navigationViewModel: NavigateViewModel = NavigateViewModel()
    
    func makeUIView(context: Context) -> MKMapView {
        
        locationManager.view.delegate = context.coordinator
        locationManager.view.showsUserLocation = true
        let p1 = MKPointAnnotation()
        p1.coordinate = CLLocationCoordinate2D(latitude: -6.304494, longitude: 106.644015)
        p1.title = "ÆON Mall BSD City"
        locationManager.view.addAnnotation(p1)
        let p2 = MKPointAnnotation()
        p2.coordinate = CLLocationCoordinate2D(latitude: -6.301937, longitude: 106.654243)
        p2.title = "The Breeze"
        locationManager.view.addAnnotation(p2)
        let p3 = MKPointAnnotation()
        p3.coordinate = CLLocationCoordinate2D(latitude: -6.283754, longitude: 106.636069)
        p3.title = "QBig BSD City"
        locationManager.view.addAnnotation(p3)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: p1.coordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: p2.coordinate))
        request.transportType = .walking
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let route = response?.routes.first else { return }
            locationManager.view.addAnnotation(p1)
            locationManager.view.addAnnotation(p2)
            locationManager.view.addOverlay(route.polyline)
            locationManager.view.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), animated: true)}
        
        return locationManager.view
      
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // TODO: Update UI View
    }
    
    func makeCoordinator() -> Coordinator {
        return MapViewCustom.Coordinator(viewmodel: NavigateViewModel())
    }
    
    class Coordinator: NSObject, MKMapViewDelegate{
        let viewmodel: NavigateViewModel
        
        init(viewmodel: NavigateViewModel) {
            self.viewmodel = viewmodel
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation.isKind(of: MKUserLocation.self) { return nil}
            else {
                let pinAnnotation = MKPinAnnotationView(
                    annotation: annotation, reuseIdentifier: "PIN_VIEW"
                )
                pinAnnotation.tintColor = .yellow
                pinAnnotation.animatesDrop = true
                pinAnnotation.canShowCallout = true
                return pinAnnotation
                
            }
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            print("Annotation \(view.coordinateSpace)")
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polygon = overlay as? MKPolygon {
                let renderer = MKPolygonRenderer(polygon: polygon)
                renderer.fillColor = UIColor.purple.withAlphaComponent(0.2)
                renderer.strokeColor = .purple.withAlphaComponent(0.7)
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
                if let annotation = view.annotation {
                    // Handle the tap gesture for the annotation here
                    print("Tapped annotation: \(annotation)")
                    //function dari viewmodel untuk set showsheet jadi true
                    viewmodel.openSheet(
                        selectedTitle: annotation.title! ?? "",
                        selectedInfo: annotation.description
                    )
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct LineShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Define the starting and ending points of the line
        let startPoint = CGPoint(x: rect.minX, y: rect.midY)
        let endPoint = CGPoint(x: rect.maxX, y: rect.midY)
        
        // Create a path from the starting to the ending point
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        
        return path
    }
}
