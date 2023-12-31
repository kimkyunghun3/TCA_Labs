import SwiftUI
import ComposableArchitecture

@main
struct Settings_CloneApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView(store: Store(initialState: SettingsFeature.State(settings: IdentifiedArray(
        uniqueElements: Settings.first
      )), reducer: {
        SettingsFeature()
          ._printChanges()
      }))
    }
  }
}
