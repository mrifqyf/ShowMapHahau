//
//  HahauView.swift
//  Ini Map
//
//  Created by Muhammad Rifqy Fimanditya on 23/05/23.
//

import SwiftUI

struct HahauView: View {
    @ObservedObject var locationManager: LocationManager
    @StateObject var navigateViewModel: NavigateViewModel = NavigateViewModel()
    @State var showSheet = false
    @State var showPapau = false
    
    var body: some View {
        ZStack {
            MapViewCustom(locationManager: locationManager, showSheet: $showSheet)
                .ignoresSafeArea()
        }
        .sheet(isPresented: $showSheet) {
            VStack {
                HStack {
                    Image("image_aeon_1")
                        .resizable()
                        .frame(width: 52, height: 52)
                    
                    VStack(alignment: .leading) {
                        Text("My Location")
                            .font(.title3)
                            .bold()
                        
                        Text("19 min")
                            .font(.callout)
                    }
                    
                    Spacer()
                    
                    Text("25 km")
                        .font(.title3)
                }
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(20)
                
                HStack{
                    Spacer()
                    Button {
                        showPapau = true
                    } label: {
                        Text("Start")
                            .frame(width: 70, height: 30)
                    }
                    .buttonStyle(.borderedProminent)
                    Spacer()
                }
            }
            .presentationDetents([.height(254)])
            .presentationDragIndicator(.visible)
        }
        .onTapGesture {
            showSheet = true
        }
    }
}

struct HahauView_Previews: PreviewProvider {
    static var previews: some View {
        HahauView(locationManager: LocationManager())
    }
}
