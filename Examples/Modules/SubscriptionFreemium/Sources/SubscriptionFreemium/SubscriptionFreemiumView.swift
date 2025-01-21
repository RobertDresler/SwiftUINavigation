import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import FlagsRepository
import Shared

struct SubscriptionFreemiumView: View {

    @EnvironmentNavigationNode private var navigationNode: SubscriptionFreemiumNavigationNode
    @EnvironmentObject private var flagsRepository: FlagsRepository

    var inputData: SubscriptionFreemiumInputData

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
        PrimaryButton(title: "Simulate Purchase", action: { subscribe() })
    }

    // MARK: Actions

    private func subscribe() {
        flagsRepository.isUserPremium = true
    }

}

#Preview {
    SubscriptionFreemiumNavigationNode(inputData: SubscriptionFreemiumInputData())
        .view
        .environmentObject(FlagsRepository())
}
