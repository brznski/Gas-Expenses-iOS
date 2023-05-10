//
//  CameraView.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 09/05/2023.
//

import UIKit
import SwiftUI

struct CameraView: UIViewControllerRepresentable {

    @Environment (\.dismiss) var dismiss

    typealias UIViewControllerType = UIImagePickerController

    let onPhotoSelected: (Data) -> Void

    func makeUIViewController(context: Context) -> UIViewControllerType {
        let viewController = UIViewControllerType()
        viewController.delegate = context.coordinator
        viewController.sourceType = .camera
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}

    func makeCoordinator() -> CameraView.Coordinator {
        return Coordinator(self, onDismiss: dismiss.callAsFunction)
    }
}

extension CameraView {
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: CameraView
        let onDismiss: () -> Void

        init(_ parent: CameraView, onDismiss: @escaping () -> Void) {
            self.parent = parent
            self.onDismiss = onDismiss
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            print("Cancel pressed")
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let imageData = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)?.jpegData(compressionQuality: 0.5) {
                parent.onPhotoSelected(imageData)
                onDismiss()
            }
        }
    }
}
