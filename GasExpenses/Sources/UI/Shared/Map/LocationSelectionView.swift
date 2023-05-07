//
//  LocationSelectionView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 06/05/2023.
//

import SwiftUI
import UIKit
import MapKit

struct LocationSelectionView: UIViewControllerRepresentable {

    let onSelectedLocalization: (CLLocationCoordinate2D) -> Void

    func makeUIViewController(context: Context) -> some UIViewController {
        return LocationSelectionViewController(onSelectedLocalization: onSelectedLocalization)
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

    }
}
