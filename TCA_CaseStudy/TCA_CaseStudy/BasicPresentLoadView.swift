import SwiftUI
import ComposableArchitecture

struct BasicPresentLoadCore: Reducer {
  struct State: Equatable {
    var counter: CounterCore.State?
    var isPresent = false
  }
  enum Action: Equatable {
    case counter(CounterCore.Action)
    case setSheet(isPresented: Bool)
    case setisDelayCompleted
  }
  
  @Dependency(\.continuousClock) var clock
  
  enum CancelID { case load }
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .setSheet(isPresented: true):
        state.isPresent = true
        return .run { send in
          try await self.clock.sleep(for: .seconds(1))
          await send(.setisDelayCompleted)
        }
        .cancellable(id: CancelID.load)
      case .setSheet(isPresented: false):
        state.isPresent = false
        state.counter = nil
        return .cancel(id: CancelID.load)
      case .setisDelayCompleted:
        state.counter = CounterCore.State()
        return .none
      case .counter:
        return .none
      }
    }
    .ifLet(\.counter, action: /Action.counter) {
      CounterCore()
    }
  }
}

struct BasicPresentLoadView: View {
  let store: StoreOf<BasicPresentLoadCore>
  @ObservedObject var viewStore: ViewStoreOf<BasicPresentLoadCore>
  
  init(store: StoreOf<BasicPresentLoadCore>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0 })
  }
  var body: some View {
    Form {
      Button("Load optional Counter") {
        viewStore.send(.setSheet(isPresented: true))
      }
    }
    .sheet(isPresented: viewStore.binding(get: \.isPresent, send: { .setSheet(isPresented: $0) })
    ) {
      IfLetStore(self.store.scope(state: \.counter, action: { .counter($0) })) { store in
        CounterView(store: store)
      } else: {
        ProgressView()
      }
    }
  }
}

#Preview {
  BasicPresentLoadView(store: .init(initialState: .init(), reducer: {
    BasicPresentLoadCore()
  }))
}
