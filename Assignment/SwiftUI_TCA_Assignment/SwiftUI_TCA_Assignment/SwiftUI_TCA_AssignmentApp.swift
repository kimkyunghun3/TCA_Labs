import SwiftUI
import ComposableArchitecture

@main
struct SwiftUI_TCA_AssignmentApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                store: Store(
                    initialState: DialogFeature.State(),
                    reducer: { DialogFeature()._printChanges() })
            )
        }
    }
}
