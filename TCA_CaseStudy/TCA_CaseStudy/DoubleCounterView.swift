import ComposableArchitecture
import SwiftUI

struct DoubleCounterCore: Reducer {
  struct State: Equatable {
    var firstCount = CounterCore.State()
    var secondCount = CounterCore.State()
  }
  
  enum Action: Equatable {
    case firstAction(CounterCore.Action)
    case secondAction(CounterCore.Action)
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .firstAction:
        return .none
      case .secondAction:
        return .none
      }
    }
    
    Scope(state: \.firstCount, action: /Action.firstAction) {
      CounterCore()
    }
    
    Scope(state: \.secondCount, action: /Action.secondAction) {
      CounterCore()
    }
  }
}

struct DoubleCounterView: View {
  let store: StoreOf<DoubleCounterCore>
  
  init(store: StoreOf<DoubleCounterCore>) {
    self.store = store
  }
  
  var body: some View {
    VStack {
      CounterView(store: store.scope(state: \.firstCount, action: DoubleCounterCore.Action.firstAction))
      CounterView(store: store.scope(state: \.secondCount, action: DoubleCounterCore.Action.secondAction))
    }
  }
}

struct DoubleCounterView_Previews: PreviewProvider {
  static var previews: some View {
    DoubleCounterView(store: Store(initialState: .init(), reducer: {
      DoubleCounterCore()
    }))
  }
}
