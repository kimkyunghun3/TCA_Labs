import SwiftUI
import ComposableArchitecture

struct CounterView: View {
  let store: StoreOf<CounterCore>
  @ObservedObject var viewStore: ViewStoreOf<CounterCore>
  
  init(store: StoreOf<CounterCore>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0 })
  }
  
  var body: some View {
    VStack {
      HStack {
        Button("-") {
          viewStore.send(.decrementButtonTapped)
        }
        Text("\(viewStore.count)")
        Button("+") {
          viewStore.send(.incrementButtonTapped)
        }
      }
    }
  }
  
  var buttons: some View {
      Button("gg") {
        viewStore.send(.incrementButtonTapped)
      }
    }
  }

struct CounterView_Previews: PreviewProvider {
  static var previews: some View {
    CounterView(store: Store(initialState: CounterCore.State(), reducer: {
      CounterCore()
    }))
  }
}
