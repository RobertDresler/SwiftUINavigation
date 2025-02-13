import SwiftUI
import SafariServices

#if os(iOS)
struct SFSafariView: View {

    private struct SFSafariViewBridge: UIViewControllerRepresentable {

        let url: URL

        func makeUIViewController(
            context: UIViewControllerRepresentableContext<SFSafariViewBridge>
        ) -> SFSafariViewController {
            SFSafariViewController(url: url)
        }

        func updateUIViewController(
            _ uiViewController: SFSafariViewController,
            context: UIViewControllerRepresentableContext<SFSafariViewBridge>
        ) {}

    }

    var inputData: SFSafariInputData

    var body: some View {
        SFSafariViewBridge(url: inputData.url)
    }

}
#endif
