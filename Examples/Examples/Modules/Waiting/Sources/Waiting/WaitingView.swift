import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import FlagsRepository
import Shared

struct WaitingView: View {

    @EnvironmentNavigationNode private var navigationNode: WaitingNavigationNode

    var inputData: WaitingInputData

    var body: some View {
        VStack(spacing: 0) {
            title
            Spacer()
            VStack(spacing: 24) {
                image
                description
            }
            Spacer()
            closeButton
        }
            .padding()
            .padding(.top, 48)
    }

    private var title: some View {
        Text("Nothing to see here")
            .font(.largeTitle)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var image: some View {
        Image(.meme)
            .resizable()
            .scaledToFit()
    }

    private var description: some View {
        Text("Me, waiting for you to realize the close button is right there")
            .font(.title2)
            .frame(maxWidth: .infinity, alignment: .center)
            .multilineTextAlignment(.center)
            .foregroundColor(SharedColor.grayscalePrimary)
    }

    private var closeButton: some View {
        PrimaryButton(title: "Close", action: { close() })
    }

    // MARK: Actions

    private func close() {
        navigationNode.close()
    }

}

#Preview {
    WaitingNavigationNode(inputData: WaitingInputData(), flagsRepository: FlagsRepository()).view
}
