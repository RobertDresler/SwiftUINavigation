@MainActor
protocol CommandsGalleryDataFactory {
    func makeTitle() -> String
    func makeItems() -> [CommandsGalleryItem]
}
