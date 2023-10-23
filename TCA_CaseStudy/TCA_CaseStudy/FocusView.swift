import SwiftUI
import ComposableArchitecture

struct FocusCore: Reducer {
  struct State: Equatable {
    @BindingState var focusField: Field?
    @BindingState var userName: String = ""
    @BindingState var password: String = ""
    
    enum Field: String, Hashable {
      case username, password
    }
  }
  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case signInButtonTapped
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
      case .signInButtonTapped:
        if state.userName.isEmpty {
          state.focusField = .username
        } else if state.password.isEmpty {
          state.focusField = .password
        }
        return .none
      }
    }
  }
}

struct FocusView: View {
  let store: StoreOf<FocusCore>
  @ObservedObject var viewStore: ViewStoreOf<FocusCore>
  @FocusState var focusFeild: FocusCore.State.Field?
  
  init(store: StoreOf<FocusCore>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0 })
  }
  
  var body: some View {
    Form {
      Section {
        VStack {
          TextField("Username", text: viewStore.$userName)
            .focused($focusFeild, equals: .username)
          TextField("Password", text: viewStore.$password)
            .focused($focusFeild, equals: .password)
          Button("Sign In") {
            viewStore.send(.signInButtonTapped)
          }
          .buttonStyle(.borderedProminent)
        }
        .textFieldStyle(.roundedBorder)
      }
    }
    .bind(viewStore.$focusField, to: self.$focusFeild)
  }
}

#Preview {
  FocusView(store: .init(initialState: .init(), reducer: {
    FocusCore()
  }))
}
