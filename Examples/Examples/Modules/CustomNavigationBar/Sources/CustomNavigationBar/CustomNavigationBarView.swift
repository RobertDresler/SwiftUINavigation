import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import FlagsRepository
import Shared

struct CustomNavigationBarView: View {

    @EnvironmentNavigationNode private var navigationNode: CustomNavigationBarNavigationNode
    @EnvironmentObject private var flagsRepository: FlagsRepository
    @State private var navigationBarBackgroundOpacity: CGFloat = 0
    var inputData: CustomNavigationBarInputData

    var body: some View {
        scrollView
            .safeAreaInset(edge: .top) { customNavigationBar }
            .navigationBarHidden(true)
    }

    private var scrollView: some View {
        OffsetObservableScrollView(offsetChange: { handleOffsetChange($0) }) {
            VStack(spacing: 12) {
                ForEach([Color.red, Color.orange, Color.yellow, Color.green, Color.blue, Color.purple, Color.pink], id: \.self) { color in
                    color
                        .frame(height: 300)
                }
            }
        }
    }

    private var customNavigationBar: some View {
        VStack(alignment: .leading, spacing: 4) {
            hideButton
            title
        }.background(customNavigationBarBackground)
    }

    private var customNavigationBarBackground: some View {
        Color.clear
            .background(.regularMaterial)
            .opacity(navigationBarBackgroundOpacity)
            .ignoresSafeArea()

    }
    private var hideButton: some View {
        Button(action: { hide() }) {
            Image(systemName: "chevron.left")
                .font(.system(size: 16, weight: .bold))
                .padding()
        }
    }

    private var title: some View {
        Text("This is a long dummy title to demonstrate how a multi-line title can be displayed, something not easily achievable with native approach")
            .font(.largeTitle)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: Actions

    private func handleOffsetChange(_ offset: CGFloat) {
        let newNavigationBarBackgroundOpacity = max(min(offset / 64, 1), 0)
        guard newNavigationBarBackgroundOpacity != navigationBarBackgroundOpacity else { return }
        navigationBarBackgroundOpacity = newNavigationBarBackgroundOpacity
    }

    private func hide() {
        navigationNode.dropLast()
    }

}

#Preview {
    CustomNavigationBarNavigationNode(inputData: CustomNavigationBarInputData())
        .view
        .environmentObject(FlagsRepository())
}
