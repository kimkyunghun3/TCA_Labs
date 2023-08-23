import Foundation
import ComposableArchitecture

struct SettingsFeature: Reducer {
  struct State: Equatable {
    var settings: IdentifiedArrayOf<Settings>
    @PresentationState var destination: Destination.State?
    var path = StackState<SettingsDetailFeature.State>()
    var searchText: String = ""
    var toggleState = SettingsToggleFeature.State(
      item: .init(
        imageName: "airplane",
        imageColor: .blue,
        name: "에어플레인 모드",
        type: .airplane
      ),
      toggle: false
    )
  }
  
  enum Action: Equatable {
    case destination(PresentationAction<Destination.Action>)
    case path(StackAction<SettingsDetailFeature.State, SettingsDetailFeature.Action>)
    case textDidEdited(title: String)
    case toggleAction(SettingsToggleFeature.Action)
    
    enum Alert: Equatable {
      case change
    }
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .toggleAction(.toggleTapped):
        state.destination = .alert(.toggleChange())
        return .none
      case let .textDidEdited(title):
        state.searchText = title
        return .none
      case .destination(.presented(.alert(.change))):
        state.toggleState.toggle.toggle()
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
    
    Scope(state: \.toggleState, action: /Action.toggleAction) {
      SettingsToggleFeature()
        ._printChanges()
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
  static func toggleChange() -> Self {
    Self {
      TextState("Do you want to change toggle?")
    } actions: {
      ButtonState(role: .destructive, action: .change) {
        TextState("Change")
      }
    }
  }
}
