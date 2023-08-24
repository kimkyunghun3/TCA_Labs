import SwiftUI
import ComposableArchitecture

struct ContentView: View {
  let store: StoreOf<SettingsFeature>
  
  var body: some View {
    NavigationStackStore(self.store.scope(state: \.path, action: { .path($0) })) {
      WithViewStore(self.store, observe: { $0 }) { viewStore in
        
        Form {
          Section {
            NavigationLink(state: SettingsDetailFeature.State(name: "프로필 수정")) {
                SettingsProfileRow()
            }
          }
          
          Section {
            ForEach(viewStore.firstSection) { setting in
              NavigationLink(state: SettingsDetailFeature.State(name: setting.name)) {
                if setting.type == .airplane {
                  SettingsToggleRow(store: store.scope(state: \.toggleState, action: SettingsFeature.Action.toggleAction))
                }
                else if setting.type == .detail {
                  SettingsRow(item: setting)
                }
              }
            }
          }
          
          Section {
            ForEach(viewStore.secondSection) { setting in
              NavigationLink(state: SettingsDetailFeature.State(name: setting.name)) {
                if setting.type == .secondDetail {
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
        uniqueElements: Settings.first)), reducer: {
          SettingsFeature()
        }))
  }
}
