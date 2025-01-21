//
//  SwiftUIView 2.swift
//  Shared
//
//  Created by Robert Dresler on 11.01.2025.
//

import SwiftUI

public struct CustomTextEditor: View {

    @Binding private var text: String

    public init(text: Binding<String>) {
        _text = text
    }

    public var body: some View {
        TextEditor(text: $text)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
            .frame(height: 64)
            .font(.system(size: 16, weight: .medium))
            .background(SharedColor.cardBackground)
            .foregroundStyle(SharedColor.grayscalePrimary)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }

}

struct PreviewView: View {

    @State var text = "Anna"

    var body: some View {
        CustomTextEditor(text: $text)
    }

}

#Preview {
    PreviewView()
}
