import Foundation
import ComposableArchitecture

struct WorldClockDetailFeature: Reducer {
  struct State: Equatable {
    var location: String
  }
  
  enum Action: Equatable {
    case cancelButtonTapped
    case delegate(Delegate)
    case textDidEdited(title: String)
    
    enum Delegate: Equatable {
      case addLocation
    }
  }
  
  @Dependency(\.dismiss) var dismiss
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .cancelButtonTapped:
      return .run { send in
        await dismiss()
      }
    case .delegate:
      return .none
    case let .textDidEdited(title):
      state.location = title
      return .none
    }
  }
}
