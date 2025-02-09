import SwiftUI
import SwiftUINavigation
import Shared

struct SubscriptionFreemiumView: View {

    @EnvironmentNavigationModel private var navigationModel: SubscriptionFreemiumNavigationModel
    @ObservedObject var viewModel: SubscriptionFreemiumViewModel

    var body: some View {
        VStack(spacing: 0) {
            title
            Spacer()
            VStack(spacing: 24) {
                star
                description
            }
            Spacer()
            subscribeButton
        }
            .padding()
            .padding(.top, 48)
    }

    private var title: some View {
        Text("Get Subscription!")
            .font(.largeTitle)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var star: some View {
        Image(systemName: "star.circle.fill")
            .font(.system(size: 100))
            .symbolRenderingMode(.hierarchical)
            .foregroundStyle(.yellow)
    }

    private var description: some View {
        Text("This is just a simulation of a subscription screen. No actual payments here!")
            .font(.title2)
            .frame(maxWidth: .infinity, alignment: .center)
            .multilineTextAlignment(.center)
            .foregroundColor(SharedColor.grayscalePrimary)
    }

    private var subscribeButton: some View {
        PrimaryButton(title: "Simulate Purchase", action: { viewModel.subscribe() })
    }

}

#Preview {
    SubscriptionFreemiumNavigationModel(flagsRepository: FlagsRepository())
        .body
        .environmentObject(FlagsRepository())
}
