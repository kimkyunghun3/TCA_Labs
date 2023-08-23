import ComposableArchitecture

struct SettingsToggleFeature: Reducer {
  struct State: Equatable {
    let item: Settings
    var toggle: Bool
  }
  
  enum Action: Equatable {
    case toggleTapped
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .toggleTapped:
      return .none
    }
  }
}
