import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

@NavigationModel
public final class CustomNavigationBarNavigationModel {

    public init() {}

    public var body: some View {
        CustomNavigationBarView()
    }

    func dropLast() {
        execute(.stackDropLast())
    }

}
