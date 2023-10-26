import SwiftUI
import ComposableArchitecture

struct BasicPresentNaviCore: Reducer {
  struct State: Equatable {
    @PresentationState var counter: CounterCore.State?
    var isActivityIndicatorVisible = false
  }
  
  enum Action: Equatable {
    case counter(PresentationAction<CounterCore.Action>)
    case counterButtonTapped
    case counterPresentationDelayCompleted
  }
  
  @Dependency(\.continuousClock) var clock
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .counter:
        return .none
      case .counterButtonTapped:
        state.isActivityIndicatorVisible = true
        return .run { send in
          try await self.clock.sleep(for: .seconds(1))
          await send(.counterPresentationDelayCompleted)
        }
      case .counterPresentationDelayCompleted:
        state.isActivityIndicatorVisible = false
        state.counter = CounterCore.State()
        return .none
      }
    }
    .ifLet(\.$counter, action: /Action.counter) {
      CounterCore()
    }
  }
}


struct BasicPresentNaviView: View {
  let store: StoreOf<BasicPresentNaviCore>
  @ObservedObject var viewStore: ViewStoreOf<BasicPresentNaviCore>
  
  init(store: StoreOf<BasicPresentNaviCore>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0} )
  }
  var body: some View {
    Form {
      Button {
        viewStore.send(.counterButtonTapped)
      } label: {
        Text("Load opional counter")
        if viewStore.isActivityIndicatorVisible {
          Spacer()
          ProgressView()
        }
      }
    }
    .sheet(store: self.store.scope(state: \.$counter, action: { .counter($0) })) { store in
      CounterView(store: store)
    }
  }
}

#Preview {
  BasicPresentNaviView(store: .init(initialState: .init(), reducer: {
    BasicPresentNaviCore()
  }))
}
