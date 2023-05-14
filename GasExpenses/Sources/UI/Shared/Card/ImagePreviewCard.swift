//
//  ImagePreviewCard.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 12/05/2023.
//

import SwiftUI
import PhotosUI

enum ImagePreviewCardContext {
    case preview
    case edit
}

struct ImagePreviewCard: View {
    @State private var selectedPhoto: PhotosPickerItem?
    @Binding var imageData: Data?

    let cardContext: ImagePreviewCardContext

    var body: some View {
        CardWithTitleView(title: LocalizedStringKey("image")) {
            VStack {
                if let documentPhotoData = $imageData.wrappedValue,
                   let uiImage = UIImage(data: documentPhotoData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .cornerRadius(8)
                        .padding()
                        .scaledToFit()

                }
                if cardContext != .preview {
                    VStack() {
                        NavigationLink(destination: CameraView { data in
                            imageData = data
                        }) {
                            Spacer()
                            Label($imageData.wrappedValue == nil ? "add.document.photo" : "edit.document.photo",
                                  systemImage: "camera")
                            Spacer()
                        }
                        .padding(.horizontal)
                        .buttonStyle(.borderedProminent)
                        .tint(.ui.action)

                        PhotosPicker(selection: $selectedPhoto) {
                            Spacer()
                            Label("select.document.photo", systemImage: "photo")
                            Spacer()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.ui.action)
                        .padding( $imageData.wrappedValue != nil ? .horizontal : [.horizontal, .bottom] )
                        .onChange(of: selectedPhoto) { newValue in
                            Task {
                                if let data = try? await newValue?.loadTransferable(type: Data.self) {
                                    imageData = data
                                }
                            }
                        }

                        if $imageData.wrappedValue != nil {
                            ButtonDestructive {
                                Label("delete.photo",
                                      systemImage: "trash.fill")
                            } action: {
                                imageData = nil
                            }
                            .padding([.horizontal, .bottom])
                        }
                    }
                }
            }
        }
    }
}

struct CardImagePreview_Previews: PreviewProvider {
    static var previews: some View {
        ImagePreviewCard(imageData: .constant(nil),
                         cardContext: .edit)
    }
}
