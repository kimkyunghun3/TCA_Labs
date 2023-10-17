import SwiftUI
import ComposableArchitecture

struct CounterView: View {
  let store: StoreOf<CounterCore>
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
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
}

struct CounterView_Previews: PreviewProvider {
  static var previews: some View {
    CounterView(store: Store(initialState: CounterCore.State(), reducer: {
      CounterCore()
    }))
  }
}
