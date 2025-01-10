import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import UserRepository

struct SubscriptionFreemiumView: View {

    @EnvironmentNavigationNode private var navigationNode: SubscriptionFreemiumNavigationNode
    @EnvironmentObject private var userRepository: UserRepository

    var inputData: SubscriptionFreemiumInputData

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 24) {
                title
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
            .foregroundColor(.gray)
    }

    private var subscribeButton: some View {
        Button(action: { subscribe() }) {
            Text("Simulate Purchase")
                .font(.title3)
                .bold()
                .padding()
                .frame(maxWidth: .infinity)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 24))
        }
    }

    // MARK: Actions

    private func subscribe() {
        userRepository.isUserPremium = true
    }

}

#Preview {
    SubscriptionFreemiumNavigationNode(inputData: SubscriptionFreemiumInputData())
        .view
        .environmentObject(UserRepository())
}