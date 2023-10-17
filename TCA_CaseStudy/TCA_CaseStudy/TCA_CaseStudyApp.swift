import SwiftUI
import ComposableArchitecture

@main
struct TCA_CaseStudyApp: App {
    var body: some Scene {
        WindowGroup {
          CounterView(store: Store(initialState: CounterCore.State(), reducer: {
            CounterCore()
          }))
        }
    }
}
