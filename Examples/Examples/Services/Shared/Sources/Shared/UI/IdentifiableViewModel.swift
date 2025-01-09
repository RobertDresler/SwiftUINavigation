public struct IdentifiableViewModel<ID: Hashable, ViewModel>: Identifiable {

    public let id: ID
    public let viewModel: ViewModel

    public init(id: ID, viewModel: ViewModel) {
        self.id = id
        self.viewModel = viewModel
    }

}
