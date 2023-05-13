//
//  ImagePreviewCard.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 12/05/2023.
//

import SwiftUI
import PhotosUI

struct ImagePreviewCard: View {
    @State private var selectedPhoto: PhotosPickerItem?
    @Binding var imageData: Data?

    var body: some View {
        CardWithTitleView(title: LocalizedStringKey("image")) {
            VStack {
                if let documentPhotoData = $imageData.wrappedValue,
                let uiImage = UIImage(data: documentPhotoData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .padding()
                        .scaledToFit()
                        .cornerRadius(8)

                }
                VStack(spacing: 2) {
                    NavigationLink(destination: CameraView { data in
                        imageData = data
                    }) {
                        Spacer()
                        Label($imageData.wrappedValue == nil ? "add.document.photo" : "edit.document.photo",
                              systemImage: "camera")
                        Spacer()
                    }
                    .padding($imageData.wrappedValue == nil ? [.horizontal, .bottom] : .horizontal)
                    .buttonStyle(.borderedProminent)
                    .tint(.ui.action)

                    PhotosPicker(selection: $selectedPhoto) {
                        Spacer()
                        Label("select.document.photo", systemImage: "photo")
                        Spacer()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.ui.action)
                    .padding()
                    .onChange(of: selectedPhoto) { newValue in
                        Task {
                            if let data = try? await newValue?.loadTransferable(type: Data.self) {
                                imageData = data
                            }
                        }
                    }

                    if $imageData.wrappedValue != nil {
                        ButtonDestructive {
                            Label("delete",
                                  systemImage: "trash.fill")
                        } action: {
                            imageData = nil
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

struct CardImagePreview_Previews: PreviewProvider {
    static var previews: some View {
        ImagePreviewCard(imageData: .constant(nil))
    }
}
