import SwiftUI

public struct OffsetObservableScrollView<Content: View>: View {

    private let coordinateSpaceName = "frameLayer"

    private let showsIndicators: Bool
    private let offsetWithRectChange: @MainActor @Sendable (OffsetObservableScrollViewOffsetWithRectData) -> Void
    @ViewBuilder private let content: () -> Content

    public init(
        showsIndicators: Bool = true,
        offsetWithRectChange: @MainActor @Sendable @escaping (OffsetObservableScrollViewOffsetWithRectData) -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.showsIndicators = showsIndicators
        self.offsetWithRectChange = offsetWithRectChange
        self.content = content
    }

    public var body: some View {
        ScrollView(showsIndicators: showsIndicators) {
            content()
                .readRect(in: coordinateSpaceName) {
                    offsetWithRectChange(OffsetObservableScrollViewOffsetWithRectData(offset: -$0.minY, rect: $0))
                }
        }
            .coordinateSpace(name: coordinateSpaceName)
    }

}

extension OffsetObservableScrollView {
    public init(
        showsIndicators: Bool = true,
        offsetChange: @MainActor @Sendable @escaping (CGFloat) -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.showsIndicators = showsIndicators
        self.offsetWithRectChange = { offsetChange($0.offset) }
        self.content = content
    }
}

public struct OffsetObservableScrollViewOffsetWithRectData {
    public let offset: CGFloat
    public let rect: CGRect
}


public extension View {
    func readSize(edgesIgnoringSafeArea: Edge.Set = [], onChange: @MainActor @Sendable @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                SwiftUI.Color.clear
                    .preference(key: ReadSizePreferenceKey.self, value: geometryProxy.size)
            }.edgesIgnoringSafeArea(edgesIgnoringSafeArea)
        )
        .onPreferenceChange(ReadSizePreferenceKey.self) { size in
            DispatchQueue.main.async { onChange(size) }
        }
    }
}

@MainActor
struct ReadSizePreferenceKey: @preconcurrency PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

public extension View {
    func readRect(
        in spaceName: String,
        edgesIgnoringSafeArea: Edge.Set = [],
        onChange: @MainActor @Sendable @escaping (CGRect) -> Void
    ) -> some View {
        readRect(in: .named(spaceName), edgesIgnoringSafeArea: edgesIgnoringSafeArea, onChange: onChange)
    }

    func readRect(
        in coordinateSpace: CoordinateSpace,
        edgesIgnoringSafeArea: Edge.Set = [],
        onChange: @MainActor @Sendable @escaping (CGRect) -> Void
    ) -> some View {
        background(
            GeometryReader { geometryProxy in
                SwiftUI.Color.clear
                    .preference(key: ReadRectPreferenceKey.self, value: geometryProxy.frame(in: coordinateSpace))
            }.edgesIgnoringSafeArea(edgesIgnoringSafeArea)
        )
        .onPreferenceChange(ReadRectPreferenceKey.self) { rect in
            DispatchQueue.main.async { onChange(rect) }
        }
    }
}

@MainActor
struct ReadRectPreferenceKey: @preconcurrency PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {}
}
