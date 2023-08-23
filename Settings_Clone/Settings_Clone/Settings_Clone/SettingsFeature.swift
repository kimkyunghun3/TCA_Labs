import Foundation
import ComposableArchitecture

struct SettingsFeature: Reducer {
  struct State: Equatable {
    var settings: IdentifiedArrayOf<Settings>
    @PresentationState var destination: Destination.State?
    var path = StackState<SettingsDetailFeature.State>()
    var searchText: String = ""
  }
  
  enum Action: Equatable {
    case toggleButtonTapped(id: Settings.ID)
    case destination(PresentationAction<Destination.Action>)
    case path(StackAction<SettingsDetailFeature.State, SettingsDetailFeature.Action>)
    case textDidEdited(title: String)
    
    enum Alert: Equatable {
      case toggleChange(id: Settings.ID)
    }
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .toggleButtonTapped(id):
        state.destination = .alert(.toggleChange(id: id))
        return .none
      case let .textDidEdited(title):
        state.searchText = title
        return .none
      case .destination:
        return .none
      case let .path(.element(id: id, action: .delegate(.setName))):
        let name = state.path[id: id]!.name
        state.searchText = name
        return .none
      case .path:
        return .none
      }
    }
    .ifLet(\.$destination, action: /Action.destination) {
      Destination()
    }
    .forEach(\.path, action: /Action.path) {
      SettingsDetailFeature()
    }
  }
}

extension SettingsFeature {
  struct Destination: Reducer {
    enum State: Equatable {
      case alert(AlertState<SettingsFeature.Action.Alert>)
    }
    
    enum Action: Equatable {
      case alert(SettingsFeature.Action.Alert)
    }
    
    var body: some ReducerOf<Self> {
      EmptyReducer()
    }
  }
}

extension AlertState where Action == SettingsFeature.Action.Alert {
  static func toggleChange(id: String) -> Self {
    Self {
      TextState("Do you want to change toggle?")
    } actions: {
      ButtonState(role: .destructive, action: .toggleChange(id: id)) {
        TextState("Change")
      }
    }
  }
}
