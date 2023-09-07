import ComposableArchitecture
import Foundation

struct WorldClockFeature: Reducer {
  struct State: Equatable {
    var clocks: IdentifiedArrayOf<WorldClock>
    @PresentationState var destination: Destination.State?
    var path = StackState<WorldClockDetailFeature.State>()
  }
  
  enum Action: Equatable {
    case addButtonTapped(location: String)
    case editButtonTapped
    case deleteClock
    case destination(PresentationAction<Destination.Action>)
    case path(StackAction<WorldClockDetailFeature.State, WorldClockDetailFeature.Action>)
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .addButtonTapped(location):
        state.clocks.append(.init(location: location, date: "", standardDate: ""))
        return .none
      case .editButtonTapped:
        return .none
      case .deleteClock:
        return .none
      case .path:
        return .none
      case .destination:
        return .none
        //      case let .path(.element(id: id, action:     ))
      }
    }
    .forEach(\.path, action: /Action.path) {
      WorldClockDetailFeature()
    }
  }
}

extension WorldClockFeature {
  struct Destination: Reducer {
    enum State: Equatable {
      
    }
    
    enum Action: Equatable {
      
    }
    
    var body: some ReducerOf<Self> {
      EmptyReducer()
    }
  }
}
