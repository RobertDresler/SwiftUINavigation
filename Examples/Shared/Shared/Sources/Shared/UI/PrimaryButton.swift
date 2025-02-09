import SwiftUI

public struct PrimaryButton: View {

    private let title: String
    private let action: () -> Void

    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title3)
                .bold()
                .padding()
                .frame(maxWidth: .infinity)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 24))
        }
    }

}

#Preview {
    PrimaryButton(title: "Action", action: {})
}
