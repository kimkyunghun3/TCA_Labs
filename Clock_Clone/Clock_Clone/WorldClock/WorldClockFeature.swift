import ComposableArchitecture
import Foundation

struct WorldClockFeature: Reducer {
  struct State: Equatable {
    var clocks: IdentifiedArrayOf<WorldClock> = []
    @PresentationState var destination: Destination.State?
    var path = StackState<WorldClockDetailFeature.State>()
    var name = ""
  }
  
  enum Action: Equatable {
    case addButtonTapped
    case editButtonTapped
    case deleteClock
    case destination(PresentationAction<Destination.Action>)
    case path(StackAction<WorldClockDetailFeature.State, WorldClockDetailFeature.Action>)
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .addButtonTapped:
        state.destination = .addClock(.init(location: "", cities: []))
        return .none
      case .editButtonTapped:
        return .none
      case .deleteClock:
        return .none
      case let .path(.element(id: id, action: .delegate(.addLocation))):
        let location = state.path[id: id]!.location
        state.name = location
        return .none
      case .path:
        return .none
//      case .destination(.presented(.addClock(.delegate(.addLocation)))):
//        state.name = state.path.first!.location
//        return .none
      case .destination:
        return .none
      }
    }
    .ifLet(\.$destination, action: /Action.destination) {
      Destination()
    }
    .forEach(\.path, action: /Action.path) {
      WorldClockDetailFeature()
    }
  }
}

extension WorldClockFeature {
  struct Destination: Reducer {
    enum State: Equatable {
      case addClock(WorldClockDetailFeature.State)
    }
    
    enum Action: Equatable {
      case addClock(WorldClockDetailFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
      Scope(state: /State.addClock, action: /Action.addClock) {
        WorldClockDetailFeature()
      }
    }
  }
}
