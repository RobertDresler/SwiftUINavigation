import Foundation

#if os(iOS)
public struct SFSafariInputData {

    let url: URL

    public init(url: URL) {
        self.url = url
    }

}
#endif
