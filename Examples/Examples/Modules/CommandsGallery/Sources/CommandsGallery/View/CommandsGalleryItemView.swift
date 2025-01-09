import SwiftUI
import Shared

struct CommandsGalleryItemView: View {

    struct ViewModel {
        let symbolName: String
        var accentColor: Color?
        let title: String
        var subtitle: String?
    }

    var viewModel: ViewModel
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            card
        }.tint(viewModel.accentColor)
    }

    private var card: some View {
        cardBody
            .padding(12)
            .background(SharedColor.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private var cardBody: some View {
        HStack(spacing: 16) {
            symbol
            VStack(spacing: 4) {
                title
                if let subtitle = viewModel.subtitle {
                    self.subtitle(for: subtitle)
                }
            }
            chevron
        }
    }

    private var symbol: some View {
        Image(systemName: viewModel.symbolName)
            .font(.system(size: 24))
            .frame(width: 24)
            .foregroundStyle(.tint)
    }

    private var title: some View {
        Text(viewModel.title)
            .font(.system(size: 16, weight: .medium))
            .foregroundStyle(SharedColor.grayscalePrimary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
    }

    private func subtitle(for subtitle: String) -> some View {
        Text(subtitle)
            .font(.system(size: 14, weight: .medium))
            .foregroundStyle(SharedColor.grayscaleSecondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
    }

    private var chevron: some View {
        Image(systemName: "chevron.right")
            .font(.system(size: 16, weight: .medium))
            .frame(width: 12)
            .foregroundStyle(.gray)
    }

}

#Preview {
    CommandsGalleryItemView(
        viewModel: CommandsGalleryItemView.ViewModel(
            symbolName: "heart.fill",
            accentColor: .red,
            title: "Title",
            subtitle: "Subtitle"
        ),
        action: {}
    )
        .padding()
        .background(SharedColor.backgroundGray)
}
