import SwiftUI
import ComposableArchitecture

struct AlertCore: Reducer {
  struct State: Equatable {
    var count = 0
    @PresentationState var alert: AlertState<Action.Alert>?
  }
  
  enum Action: Equatable {
    case alert(PresentationAction<Alert>)
    case alertButtonTapped
    case dialogButtonTapped
    
    enum Alert: Equatable {
      case incrementButtonTapped
    }
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .alert(.presented(.incrementButtonTapped)):
        state.alert = AlertState { TextState("Incremented") }
        state.count += 1
        return .none
      case .alert:
        return .none
      case .alertButtonTapped:
        state.alert = AlertState {
          TextState("Alert")
        } actions: {
          ButtonState(role: .cancel) {
            TextState("Cancel")
          }
          ButtonState(action: .incrementButtonTapped) {
            TextState("Increment")
          }
        } message: {
          TextState("This is an alert")
        }
        return .none
      case .dialogButtonTapped:
        return .none
      }
    }
    .ifLet(\.$alert, action: /Action.alert)
  }
}

struct AlertDialogView: View {
  let store: StoreOf<AlertCore>
  @ObservedObject var viewStore: ViewStoreOf<AlertCore>
  
  init(store: StoreOf<AlertCore>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0 })
  }
  var body: some View {
    VStack(alignment: .leading) {
      Text("Count: \(viewStore.count)")
      Button("Alert") {
        viewStore.send(.alertButtonTapped)
      }
      Button("Confirmation Dialog") {
        
      }
    }
    .padding()
    .frame(maxWidth: .infinity, alignment: .leading)
    .alert(store: self.store.scope(state: \.$alert, action: { .alert($0) }))
  }
}

#Preview {
  AlertDialogView(store: .init(initialState: .init(), reducer: {
    AlertCore()
      ._printChanges()
  }))
}
