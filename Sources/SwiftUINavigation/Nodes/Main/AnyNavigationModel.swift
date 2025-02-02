import SwiftUI
import Combine

public final class AnyNavigationModel: NavigationModel {

    public let id: String
    public let commonState: CommonNavigationModelState

    public var presentedModel: (any PresentedNavigationModel)? {
        get { base.presentedModel }
        set { base.presentedModel = newValue }
    }

    public var children: [any NavigationModel] {
        base.children
    }
    
    public var body: some View {
        AnyView(base.body)
    }

    public var isWrapperModel: Bool {
        base.isWrapperModel
    }

    let base: any NavigationModel

    private var cancellables = Set<AnyCancellable>()

    public init<T: NavigationModel>(_ base: T) {
        self.id = base.id
        self.commonState = base.commonState
        self.base = base
        bind()
    }

    /// Binding like this is needed since withTransaction wouldn't work with that
    private func bind() {
        guard let publisher = base.objectWillChange as? ObjectWillChangePublisher else { return }
        publisher
            .sink { [weak self] in self?.objectWillChange.send() }
            .store(in: &cancellables)
    }

}
