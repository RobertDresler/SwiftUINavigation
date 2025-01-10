@MainActor
protocol ActionableListDataFactory {
    func makeTitle() -> String
    func makeSubtitle() -> String?
    func makeItems() -> [ActionableListItem]
}

extension ActionableListDataFactory {
    func makeSubtitle() -> String? { nil }
}
