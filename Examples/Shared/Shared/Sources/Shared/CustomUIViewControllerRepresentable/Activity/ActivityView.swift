import SwiftUI

#if os(iOS)
struct ActivityView: UIViewControllerRepresentable {

    var inputData: ActivityInputData

    func makeUIViewController(
        context: UIViewControllerRepresentableContext<ActivityView>
    ) -> UIActivityViewController {
        UIActivityViewController(
            activityItems: inputData.activityItems,
            applicationActivities: inputData.applicationActivities
        )
    }

    func updateUIViewController(
        _ uiViewController: UIActivityViewController,
        context: UIViewControllerRepresentableContext<ActivityView>
    ) {}

}
#endif
