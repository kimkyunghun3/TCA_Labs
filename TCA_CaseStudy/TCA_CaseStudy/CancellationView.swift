import SwiftUI
import ComposableArchitecture

struct CancellationCore: Reducer {
  struct State: Equatable {
    var count = 0
    var description: String?
    var isRequestFinish = false
  }
  
  enum Action: Equatable {
    case cancelButtonTapped
    case numberFactButtonTapped
    case factResponse(TaskResult<String>)
    case stepperChanged(Int)
  }
  @Dependency(\.factClient) var factClient
  enum CancelID { case cancel }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .cancelButtonTapped:
        return .cancel(id: CancelID.cancel)
      case .numberFactButtonTapped:
        return .run { [count = state.count] send in
          await send(.factResponse(TaskResult { try await self.factClient.fetch(count) }))
        }
        .cancellable(id: CancelID.cancel)
      case let .factResponse(.success(response)):
        state.isRequestFinish = false
        state.description = response
        return .none
      case .factResponse(.failure):
        state.isRequestFinish = false
        return .none
      case let .stepperChanged(value):
        state.count = value
        return .cancel(id: CancelID.cancel)
      }
    }
  }
}

struct CancellationView: View {
  let store: StoreOf<CancellationCore>
  @ObservedObject var viewStore: ViewStoreOf<CancellationCore>
  
  init(store: StoreOf<CancellationCore>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0} )
  }
  
  var body: some View {
    Form {
      Section {
        Stepper("\(viewStore.count)", value: viewStore.binding(get: \.count, send: { .stepperChanged($0)}))
        if viewStore.isRequestFinish {
          HStack {
            Button("Cancel") { viewStore.send(.cancelButtonTapped) }
            Spacer()
            ProgressView()
              .id(UUID())
          }
        } else {
          Button("numberFact") {
            viewStore.send(.numberFactButtonTapped)
          }
          .disabled(viewStore.isRequestFinish)
        }
        
        viewStore.description.map { Text($0).padding(.vertical, 8) }
      }
    }
  }
}

#Preview {
  CancellationView(store: .init(initialState: .init(), reducer: {
    CancellationCore()
      ._printChanges()
  }))
}
