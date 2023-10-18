import SwiftUI
import ComposableArchitecture

struct OptionalCore: Reducer {
  struct State: Equatable {
    var checkNilVaule = "nil"
    var toggleEnable = false
    var numberCount = CounterCore.State()
  }
  enum Action: Equatable {
    case toggleButtonTapped
    case countButton(CounterCore.Action)
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .toggleButtonTapped:
        state.toggleEnable = !state.toggleEnable
        state.checkNilVaule = state.toggleEnable == true ? "not-nil" : "nil"
        return .none
      case .countButton:
        return .none
      }
    }
    
    Scope(state: \.numberCount, action: /Action.countButton) {
      CounterCore()
    }
  }
}

struct OptionalView: View {
  let store: StoreOf<OptionalCore>
  @ObservedObject var viewStore: ViewStoreOf<OptionalCore>
  
  init(store: StoreOf<OptionalCore>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0} )

  }
  var body: some View {
    VStack {
      Button("Toggle counter state") {
        viewStore.send(.toggleButtonTapped)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      Text("Counter State is \(viewStore.checkNilVaule)")
      .frame(maxWidth: .infinity, alignment: .leading)
      CounterView(store: store.scope(state: \.numberCount, action: OptionalCore.Action.countButton))

      .opacity(viewStore.toggleEnable == false ? 0 : 1)
    }
    .padding()
    .frame(maxWidth: .infinity)
  }
}

struct OptionalView_Previews: PreviewProvider {
  static var previews: some View {
    OptionalView(store: .init(initialState: .init(), reducer: {
      OptionalCore()
    }))
  }
}
