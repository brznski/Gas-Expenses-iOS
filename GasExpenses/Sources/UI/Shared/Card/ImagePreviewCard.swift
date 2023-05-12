//
//  ImagePreviewCard.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 12/05/2023.
//

import SwiftUI

struct ImagePreviewCard: View {
    @Binding var imageData: Data?

    var body: some View {
        CardWithTitleView(title: LocalizedStringKey("image")) {
            VStack {
                if let documentPhotoData = $imageData.wrappedValue {
                    Image(uiImage: .init(data: documentPhotoData)!)
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
                              systemImage: "doc")
                        Spacer()
                    }
                    .padding($imageData.wrappedValue == nil ? [.horizontal, .bottom] : .horizontal)
                    .buttonStyle(.borderedProminent)
                    .tint(.ui.action)

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
