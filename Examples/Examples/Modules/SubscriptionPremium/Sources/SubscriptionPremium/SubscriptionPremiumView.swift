import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import UserRepository

struct SubscriptionPremiumView: View {

    @EnvironmentNavigationNode private var navigationNode: SubscriptionPremiumNavigationNode
    @EnvironmentObject private var userRepository: UserRepository

    var inputData: SubscriptionPremiumInputData

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 24) {
                title
                description
            }
            Spacer()
            buyMeCoffeeButton
        }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    unsubscribeButton
                }
            }
    }

    private var unsubscribeButton: some View {
        Button(action: { unsubscribe() }) {
            Text("Unsubscribe")
        }
    }

    private var title: some View {
        Text("Thanks for Going Premium!")
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
        Text("You’re now a premium user.\n\nIf you'd like to support me further, you can buy me a coffee. The link is at the very bottom of the GitHub README, or feel free to give a star to the repository on GitHub!")
            .font(.title2)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var buyMeCoffeeButton: some View {
        Button(action: { buyMeCoffee() }) {
            Image(.buyMeCoffeeButton)
                .resizable()
                .renderingMode(.original)
                .scaledToFill()
                .frame(height: 80)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 24))
        }
    }

    // MARK: Actions

    private func buyMeCoffee() {
        navigationNode.buyMeCoffee()
    }

    private func unsubscribe() {
        userRepository.isUserPremium = false
    }

}

#Preview {
    NavigationStack(root: {
        SubscriptionPremiumNavigationNode(inputData: SubscriptionPremiumInputData())
            .view
            .environmentObject(UserRepository())
    })
}
