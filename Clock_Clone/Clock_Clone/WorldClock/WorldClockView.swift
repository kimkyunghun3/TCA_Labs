import SwiftUI
import ComposableArchitecture

struct WorldClockView: View {
  let store: StoreOf<WorldClockFeature>
  
  var body: some View {
    WithViewStore(self.store, observe: { $0.clocks }) { viewStore in
      NavigationStack {
        List {
          
          ForEach(WorldClock.dummy) {
            WorldClockRow(item: .init(location: $0.location, date: $0.date, standardDate: $0.standardDate))
          }
        }
        .navigationTitle("세계 시계")
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            Button("편집") {
              viewStore.send(.editButtonTapped)
            }
          }
          ToolbarItem(placement: .navigationBarTrailing) {
            Button {
              // 추가버튼
            } label: {
              Image(systemName: "plus")
            }
          }
        }
        .tint(.orange)
      }
    }
    //    } destination: { subStore in
    //      WorldClockDetailView(store: subStore)
    //    }
    //      .sheet(
    //          store: self.store.scope(state: \.$destination, action: { .destination($0) }),
    //          state: /ContactsFeature.Destination.State.addContact,
    //          action: ContactsFeature.Destination.Action.addContact
    //      ) { addContactStore in
    //          NavigationStack {
    //              AddContactView(store: addContactStore)
    //          }
    //      }
  }
}


struct WorldClockView_Previews: PreviewProvider {
  static var previews: some View {
    WorldClockView(store: Store(initialState: WorldClockFeature.State(clocks: IdentifiedArray(uniqueElements: WorldClock.dummy)), reducer: {
      WorldClockFeature()
    }))
  }
}
