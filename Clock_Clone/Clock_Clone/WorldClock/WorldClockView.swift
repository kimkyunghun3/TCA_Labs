import SwiftUI
import ComposableArchitecture

struct WorldClockView: View {
  let store: StoreOf<WorldClockFeature>
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      NavigationStack {
        List {
          ForEach(viewStore.contents) {
            WorldClockRow(
              item: .init(
                location: $0.location,
                date: $0.date,
                standardDate: $0.standardDate
              )
            )
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
              viewStore.send(.addButtonTapped)
            } label: {
              Image(systemName: "plus")
            }
          }
        }
      }
      .tint(.orange)
    }
    .sheet(
      store: self.store.scope(state: \.$destination, action: { .destination($0)}),
      state: /WorldClockFeature.Destination.State.addClock,
      action: WorldClockFeature.Destination.Action.addClock,
      content: { store in
        WorldClockDetailView(store: store)
      }
    )
  }
}


struct WorldClockView_Previews: PreviewProvider {
  static var previews: some View {
    WorldClockView(store: Store(initialState: WorldClockFeature.State(clocks: IdentifiedArray(uniqueElements: WorldClock.dummy)), reducer: {
      WorldClockFeature()
    }))
  }
}
