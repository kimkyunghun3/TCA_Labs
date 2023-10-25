import SwiftUI
import ComposableArchitecture

struct NavigatingCore: Reducer {
  struct State: Equatable {
    var count = 0
  }
  
  enum Action: Equatable {
    case incrementButtonTapped
    case decrementButtonTapped
    case refresh
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .incrementButtonTapped:
        state.count += 1
        return .none
      case .decrementButtonTapped:
        state.count -= 1
        return .none
      case .refresh:
        return .none
      }
    }
  }
}

struct NavigatingView: View {
  let store: StoreOf<NavigatingCore>
  @ObservedObject var viewStore: ViewStoreOf<NavigatingCore>
  @State var isLoading = false
  
  init(store: StoreOf<NavigatingCore>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0} )
  }
  
  var body: some View {
    Form {
      HStack {
        Button("-") {
          viewStore.send(.decrementButtonTapped)
        }
        Text("\(viewStore.count)")
        Button("+") {
          viewStore.send(.incrementButtonTapped)
        }
      }
      .buttonStyle(.borderless)
      .frame(maxWidth: .infinity)
    }
    .refreshable {
      self.isLoading = true
      defer { self.isLoading = false }
      await viewStore.send(.refresh).finish()
    }
  }
}

#Preview {
  NavigatingView(store: .init(initialState: .init(), reducer: {
    NavigatingCore()
      ._printChanges()
  }))
}
