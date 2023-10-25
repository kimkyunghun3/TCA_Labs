import SwiftUI
import ComposableArchitecture

struct EffectBasicCore: Reducer {
  struct State: Equatable {
    var CounterCount = CounterCore.State()
    var isTextHidden = false
    var numberFact: String?
  }
  
  enum Action: Equatable {
    case countAction(CounterCore.Action)
    case numberFactTapped
    case numberFactResponse(TaskResult<String>)
  }
  
  @Dependency(\.factClient) var factClient
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .countAction:
        return .none
      case .numberFactTapped:
        state.isTextHidden = true
        state.numberFact = nil
        return .run { [count = state.CounterCount.count] send in
          await send(.numberFactResponse(TaskResult { try await self.factClient.fetch(count) })) }
      case let .numberFactResponse(.success(response)):
        state.isTextHidden = false
        state.numberFact = response
        return .none
      case .numberFactResponse(.failure):
        state.isTextHidden = false
        return .none
      }
    }
    Scope(state: \.CounterCount, action: /Action.countAction) {
      CounterCore()
    }
  }
}

struct EffectBasicView: View {
  let store: StoreOf<EffectBasicCore>
  let viewStore: ViewStoreOf<EffectBasicCore>
  
  init(store: StoreOf<EffectBasicCore>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0} )
  }
    var body: some View {
      Form {
        VStack(spacing: 20) {
          CounterView(store: store.scope(state: \.CounterCount, action:
            EffectBasicCore.Action.countAction))
          .frame(maxWidth: .infinity)
          
          Button("Number fact") {
            viewStore.send(.numberFactTapped)
          }
          .frame(maxWidth: .infinity)
          
          if viewStore.isTextHidden {
            ProgressView()
              .frame(maxWidth: .infinity)
              .id(UUID())
          }
          
          if let number = viewStore.numberFact {
            Text(number)
          }
        }
        .padding()
      }
    }
}

#Preview {
  EffectBasicView(store: .init(initialState: .init(), reducer: {
    EffectBasicCore()
  }))
}
