@MainActor
protocol ActionableListDataFactory {
    func makeTitle() -> String
    func makeItems() -> [ActionableListItem]
}
