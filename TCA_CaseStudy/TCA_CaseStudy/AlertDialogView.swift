import SwiftUI
import ComposableArchitecture

struct AlertCore: Reducer {
  struct State: Equatable {
    var count = 0
    @PresentationState var alert: AlertState<Action.Alert>?
    @PresentationState var confimataionDialog: ConfirmationDialogState<Action.ConfirmationDialog>?
  }
  
  enum Action: Equatable {
    case alert(PresentationAction<Alert>)
    case alertButtonTapped
    case confirmationDialogButtonTapped
    case confirmationDialog(PresentationAction<ConfirmationDialog>)
    
    enum Alert: Equatable {
      case incrementButtonTapped
    }
    
    enum ConfirmationDialog: Equatable {
      case incrementButtonTapped
      case decrementButtonTapped
    }
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .alert(.presented(.incrementButtonTapped)), .confirmationDialog(.presented(.incrementButtonTapped)):
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
      case .confirmationDialog(.presented(.decrementButtonTapped)):
        state.alert = AlertState { TextState("Decremented") }
        state.count -= 1
        return .none
      case .confirmationDialog:
        return .none
      case .confirmationDialogButtonTapped:
        state.confimataionDialog = ConfirmationDialogState(title: {
          TextState("Confirmation dialog") }, actions: {
            ButtonState(role: .cancel) {
              TextState("Cancel")
            }
            ButtonState(action: .incrementButtonTapped) {
              TextState("Increment")
            }
            ButtonState(action: .decrementButtonTapped) {
              TextState("Decrement")
            }
          }, message: {
            TextState("This is a confirmation dialog.")
          })
        return .none
      }
    }
    .ifLet(\.$alert, action: /Action.alert)
    .ifLet(\.$confimataionDialog, action: /Action.confirmationDialog)
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
        viewStore.send(.confirmationDialogButtonTapped)
      }
    }
    .padding()
    .frame(maxWidth: .infinity, alignment: .leading)
    .alert(store: self.store.scope(state: \.$alert, action: { .alert($0) }))
    .confirmationDialog(store: self.store.scope(state: \.$confimataionDialog, action: { .confirmationDialog($0) }))
  }
}

#Preview {
  AlertDialogView(store: .init(initialState: .init(), reducer: {
    AlertCore()
      ._printChanges()
  }))
}
