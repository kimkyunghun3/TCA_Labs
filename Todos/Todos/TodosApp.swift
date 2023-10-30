import SwiftUI
import ComposableArchitecture

@main
struct TodosApp: App {
    var body: some Scene {
        WindowGroup {
          TodosView(store: .init(initialState: .init(), reducer: {
            TodosCore()
          }))
        }
    }
}
