import SwiftUI
import ComposableArchitecture

struct SettingsDetailView: View {
  let store: StoreOf<SettingsDetailFeature>
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      VStack {
        Text("\(viewStore.name)")
          .font(.title)
        Button {
          viewStore.send(.popButtonTapped)
        } label: {
          Text("뒤로가기")
        }
      }
    }
  }
}

struct SettingsDetailView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsDetailView(store: .init(initialState: .init(name: "wifi")) {
      SettingsDetailFeature()
    })
  }
}
