//
//  LocationSelectionViewController.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 06/05/2023.
//

import UIKit
import MapKit
import SwiftUI

final class LocationSelectionViewController: UIViewController {

    private lazy var map: MKMapView = {
        let map = MKMapView()

        return map
    }()

    private lazy var addButton: UIButton = {
        let button = UIButton()

        button.setTitle("Add location", for: .normal)
        button.backgroundColor = .cyan
        button.layer.cornerRadius = 8

        let action = UIAction { [weak self] _ in
            guard let self else { return }
            self.onSelectedLocalization(self.map.centerCoordinate)
            self.navigationController?.popViewController(animated: true)
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()

    private lazy var label: UILabel = {
        return UILabel()
    }()

    private let onSelectedLocalization: (CLLocationCoordinate2D) -> Void

    init(onSelectedLocalization: @escaping (CLLocationCoordinate2D) -> Void) {
        self.onSelectedLocalization = onSelectedLocalization
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        setupLayout()
    }

    private func setupLayout() {
        view.addSubview(map)
        view.addSubview(addButton)
        view.addSubview(label)

        label.text = "."

        map.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            map.topAnchor.constraint(equalTo: view.topAnchor),
            map.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            map.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])

        addButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: map.bottomAnchor, constant: 8),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8)
        ])

        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: map.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: map.centerYAnchor)
        ])
    }
}
