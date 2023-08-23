import SwiftUI
import ComposableArchitecture

struct ContentView: View {
  let store: StoreOf<SettingsFeature>
  
  var body: some View {
    NavigationStackStore(self.store.scope(state: \.path, action: { .path($0) })) {
      WithViewStore(self.store, observe: { $0 }) { viewStore in
        Form {
          Section {
            SettingsProfileRow()
          }
          
          Section {
            SettingsFlightRow(item: viewStore.settings.first!)
            ForEach(viewStore.settings) { setting in
              NavigationLink(state: SettingsDetailFeature.State(name: setting.name)) {
                SettingsRow(item: setting)
              }
            }
          }
        }
        .searchable(text: viewStore.binding(get: \.searchText, send: { .textDidEdited(title: $0 )}))
      }
    } destination: { subStore in
      SettingsDetailView(store: subStore)
    }
    .alert(
      store: self.store.scope(
        state: \.$destination,
        action: { .destination($0) }
      ), state: /SettingsFeature.Destination.State.alert,
      action: SettingsFeature.Destination.Action.alert
    )
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(store: Store(initialState: SettingsFeature.State(settings: IdentifiedArray(Settings.dummyData)), reducer: {
      SettingsFeature()
    }))
  }
}
