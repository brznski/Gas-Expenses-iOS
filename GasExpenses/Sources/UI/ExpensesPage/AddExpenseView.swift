//
//  AddExpenseView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 14/04/2023.
//

import SwiftUI
import MapKit
import CoreLocationUI

struct AddExpenseView: View {
    @ObservedObject var locationManager = LocationManager()
    @ObservedObject var viewModel: AddExpenseViewModel
    @Environment(\.dismiss) var dismiss

    @State var pin: [Location] = []
    @State var showCardSelectionSheet = false
    @State var documentPhoto: Data?
    @State var commnent: String = ""

    var body: some View {

        ZStack {
            Color.ui.background
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    Group {
                        TitleAndTextField(title: "title",
                                          textFieldValue: $viewModel.title)
                        TitleAndTextField(title: "comment",
                                          textFieldValue: $commnent
                        )
                        TitleAndTextField(title: "amount",
                                          textFieldValue: $viewModel.amount)

                        HStack {
                            Text("expense.type")
                            Spacer()
                            Picker("fuel.type", selection: $viewModel.expenseType) {
                                ForEach(ExpenseType.allCases.sorted { lhs, rhs in
                                    return lhs.rawValue < rhs.rawValue
                                }) {
                                    Text($0.rawValue.capitalized).tag($0.rawValue)
                                }
                            }
                            .tint(Color.ui.action)
                        }
                    }

                    DatePicker("date", selection: $viewModel.date,
                               displayedComponents: [.date])
                    .tint(Color.ui.action)
                    .datePickerStyle(.graphical)
                    Spacer()

                    if let region = $locationManager.region,
                       region.wrappedValue != nil {
                        Map(coordinateRegion: region.toUnwrapped(defaultValue: .init(.world)),
                            showsUserLocation: true,
                            annotationItems: pin) {
                            MapMarker(coordinate: .init(latitude: $0.latitude,
                                                        longitude: $0.longitude))
                        }
                            .frame(height: 300)
                            .cornerRadius(8)
                            .padding()
                    }

                    HStack {
                        LocationButton(.currentLocation) {
                            locationManager.requestLocation()
                            pin.removeAll()
                            pin.append(.init(latitude: locationManager.location?.latitude ?? 0,
                                             longitude: locationManager.location?.longitude ?? 0))
                        }
                        .cornerRadius(8)
                        .frame(height: 44)
                        .foregroundColor(.white)
                        .padding()
                        .tint(.ui.action)
                        NavigationLink(destination: LocationSelectionView { coordinate in
                            locationManager.location = coordinate
                            viewModel.latitude = coordinate.latitude
                            viewModel.longitude = coordinate.longitude
                            pin.removeAll()
                            pin.append(.init(latitude: coordinate.latitude,
                                             longitude: coordinate.longitude))
                        }) {
                            Label("open.map", systemImage: "map")
                                .padding([.all], 10)
                                .background(Color.ui.action)
                                .tint(.white)
                                .cornerRadius(8)
                        }
                    }

                    if let documentPhotoData = $documentPhoto.wrappedValue {
                        Image(uiImage: .init(data: documentPhotoData)!)
                            .resizable()
                            .scaledToFit()
                    }

                    NavigationLink(destination: CameraView(onPhotoSelected: { data in
                        documentPhoto = data
                    })) {
                        Label("add.document.photo", systemImage: "doc")
                            .padding([.all], 10)
                            .background(Color.ui.action)
                            .tint(.white)
                            .cornerRadius(8)
                    }

                    ButtonPrimary {
                        Text("add")
                    } action: {
                        viewModel.addExpense()
                        dismiss()
                    }
                }
                .padding()
            }
        }
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView(viewModel: .init(carDataStore: CarDataSource(carService: CarService()),
                                        expenseService: ExpenseService(),
                                        carID: 0))
    }
}
