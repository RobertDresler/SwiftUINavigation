import SwiftUI
import SwiftUINavigation
import Shared

struct LockedAppView: View {

    @EnvironmentNavigationModel private var navigationModel: LockedAppNavigationModel
    @ObservedObject var viewModel: LockedAppViewModel

    var body: some View {
        VStack(spacing: 0) {
            title
            Spacer()
            VStack(spacing: 24) {
                image
                description
            }
            Spacer()
            unlockButton
        }
            .padding()
            .padding(.top, 48)
    }

    private var title: some View {
        Text("Now the app is locked!")
            .font(.largeTitle)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var image: some View {
        Image(systemName: "lock.fill")
            .font(.system(size: 100))
            .symbolRenderingMode(.hierarchical)
            .foregroundStyle(.pink)
    }

    private var description: some View {
        Text("Knock knock. Who’s trying to get in?")
            .font(.title2)
            .frame(maxWidth: .infinity, alignment: .center)
            .multilineTextAlignment(.center)
            .foregroundColor(SharedColor.grayscalePrimary)
    }

    private var unlockButton: some View {
        PrimaryButton(title: "Let me in!", action: { viewModel.unlock() })
    }

}

#Preview {
    LockedAppNavigationModel(flagsRepository: FlagsRepository()).body
}
