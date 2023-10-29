import SwiftUI
import ComposableArchitecture

struct BasicNaviCore: Reducer {
  struct State: Equatable {
    var numberCount: CounterCore.State?
    var isNavigationActive = false
  }
  
  enum Action: Equatable {
    case setNavigation(isActive: Bool)
    case setNavigationIsActiveDelayCompleted
    case numberAction(CounterCore.Action)
  }
  
  @Dependency(\.continuousClock) var clock
  private enum CancelID { case load }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .setNavigation(isActive: true):
        state.isNavigationActive = true
        return .run { send in
          try await self.clock.sleep(for: .seconds(1))
          await send(.setNavigationIsActiveDelayCompleted)
        }
        .cancellable(id: CancelID.load)
        
      case .setNavigation(isActive: false):
        state.isNavigationActive = false
        state.numberCount = nil
        return .cancel(id: CancelID.load)
        
      case .setNavigationIsActiveDelayCompleted:
        state.numberCount = CounterCore.State()
        return .none
        
      case .numberAction:
        return .none
      }
    }
    .ifLet(\.numberCount, action: /Action.numberAction) {
      CounterCore()
    }
  }
}
struct BasicNaviView: View {
  let store: StoreOf<BasicNaviCore>
  @ObservedObject var viewStore: ViewStoreOf<BasicNaviCore>
  
  init(store: StoreOf<BasicNaviCore>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0} )
  }
  
  var body: some View {
    Form {
      Section {
        NavigationLink(
          "Load optional counter",
          isActive: viewStore.binding(
            get: \.isNavigationActive,
            send: { .setNavigation(isActive: $0) })
        ) {
          IfLetStore(
            self.store.scope(
              state: \.numberCount,
              action: { .numberAction($0) })
          ) {
              CounterView(store: $0)
            } else: {
              ProgressView()
            }
        }
      }
    }
    .navigationTitle("Navigate and Local")
  }
}

#Preview {
  BasicNaviView(store: .init(initialState: BasicNaviCore.State(), reducer: {
    BasicNaviCore()
      ._printChanges()
  }))
}
