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
            ForEach(viewStore.settings) { setting in
              if setting.type == .airplane {
                SettingsToggleRow(store: store.scope(state: \.toggleState, action: SettingsFeature.Action.toggleAction))
              } else {
                NavigationLink(state: SettingsDetailFeature.State(name: setting.name)) {
                  SettingsRow(item: setting)
                }
              }
            }
          }
        }
        .searchable(
          text: viewStore.binding(
            get: \.searchText,
            send: { .textDidEdited(title: $0 ) }
          )
        )
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
    ContentView(store: Store(initialState: SettingsFeature.State(
      settings: IdentifiedArray(
      uniqueElements: Settings.dummyData)), reducer: {
      SettingsFeature()
    }))
  }
}
