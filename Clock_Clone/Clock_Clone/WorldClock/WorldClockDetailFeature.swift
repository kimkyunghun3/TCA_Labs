import Foundation
import ComposableArchitecture

struct WorldClockDetailFeature: Reducer {
  struct State: Equatable {
    let location: String
  }
  
  enum Action: Equatable {
    case cancelButtonTapped
    case delegate(Delegate)
    
    enum Delegate: Equatable {
      case addLocation
    }
  }
  
  @Dependency(\.dismiss) var dismiss
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .cancelButtonTapped:
      return .run { send in
        await send(.delegate(.addLocation))
        await dismiss()
      }
    case .delegate:
      return .none
      
    }
  }
}
