//
//  AddRefuelView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 27/04/2023.
//

import SwiftUI

final class AddRefuelViewModel: ObservableObject {
    @Published var date: Date = .now
    @Published var mileage: String = ""
    @Published var fuelAmount: String = ""
    @Published var costPerUnit: String = ""

    private let carID: Int = 6
    private let service: RefuelServiceProtocol

    init(service: RefuelServiceProtocol) {
        self.service = service
    }

    func addRefuel() {
        Task {
            do {
                try await service.addRefuel(.init(id: 0,
                                        date: date.JSONDate(),
                                        mileage: Double(mileage)!,
                                        fuelAmount: Double(fuelAmount)!,
                                        costPerUnit: Double(costPerUnit)!),
                                  carID: Int(carID))
            } catch {

            }
        }
    }
}

struct AddRefuelView: View {
    @ObservedObject var viewModel: AddRefuelViewModel = .init(service: RefuelService())

    var body: some View {
        ZStack {
            Color.ui.background
                .ignoresSafeArea()
            VStack {
                TitleAndTextField(title: "mileage",
                                  textFieldValue: $viewModel.mileage)
                TitleAndTextField(title: "fuelAmount",
                                  textFieldValue: $viewModel.fuelAmount)
                TitleAndTextField(title: "cost per unit",
                                  textFieldValue: $viewModel.costPerUnit)

                DatePicker("Date", selection: $viewModel.date, displayedComponents: [.date])
                    .tint(Color.ui.action)
                    .datePickerStyle(.graphical)
                Spacer()
                Button {
                    viewModel.addRefuel()
                } label: {
                    Spacer()
                    Text("add")
                    Spacer()
                }
                .tint(Color.ui.action)
                .buttonStyle(.borderedProminent)

            }
            .padding()

        }
    }
}

struct AddRefuelView_Previews: PreviewProvider {
    static var previews: some View {
        AddRefuelView()
    }
}
