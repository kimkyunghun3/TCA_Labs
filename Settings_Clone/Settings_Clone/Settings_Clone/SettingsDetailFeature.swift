import ComposableArchitecture

struct SettingsDetailFeature: Reducer {
  struct State: Equatable {
    let name: String
  }
  enum Action: Equatable {
    case popButtonTapped
    case delegate(Delegate)
    
    enum Delegate: Equatable {
      case setName
    }
  }
  @Dependency(\.dismiss) var dismiss
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .popButtonTapped:
      return .run { send in
        await send(.delegate(.setName))
        await dismiss()
      }
      
    case .delegate:
      return .none
    }
  }
}
