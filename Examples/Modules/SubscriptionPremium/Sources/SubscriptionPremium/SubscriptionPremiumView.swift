import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import FlagsRepository

struct SubscriptionPremiumView: View {

    @EnvironmentNavigationModel private var navigationModel: SubscriptionPremiumNavigationModel
    @EnvironmentObject private var flagsRepository: FlagsRepository

    var inputData: SubscriptionPremiumInputData

    var body: some View {
        VStack(spacing: 0) {
            title
            Spacer()
            VStack(spacing: 24) {
                image
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

    private var image: some View {
        Image(systemName: "hands.and.sparkles.fill")
            .font(.system(size: 100))
            .symbolRenderingMode(.hierarchical)
            .foregroundStyle(.yellow)
    }

    private var description: some View {
        Text("You’re now a premium user.\n\nIf you'd like to support me further, you can buy me a coffee. The link is at the very bottom of the GitHub README, or feel free to give a star to the repository on GitHub!")
            .font(.title2)
            .frame(maxWidth: .infinity, alignment: .leading)
            .minimumScaleFactor(0.5)
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
        navigationModel.buyMeCoffee()
    }

    private func unsubscribe() {
        flagsRepository.isUserPremium = false
    }

}

#Preview {
    NavigationStack(root: {
        SubscriptionPremiumNavigationModel(inputData: SubscriptionPremiumInputData())
            .body
            .environmentObject(FlagsRepository())
    })
}
