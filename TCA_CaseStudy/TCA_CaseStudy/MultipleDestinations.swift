//import SwiftUI
//import ComposableArchitecture
//
//struct MultipleDestinationsCore: Reducer {
//  public struct Destination: Reducer {
//    public enum State: Equatable {
//      case drillDown(CounterCore.State)
//      case popover(CounterCore.State)
//      case sheet(CounterCore.State)
//    }
//    
//    public enum Action: Equatable {
//      case drillDown(CounterCore.Action)
//      case popover(CounterCore.Action)
//      case sheet(CounterCore.Action)
//    }
//    
//    public var body: some Reducer<State, Action> {
//      Scope(state: /State.drillDown, action: /Action.drillDown) {
//        CounterCore()
//      }
//      
//      Scope(state: /State.popover, action: /Action.popover) {
//        CounterCore()
//      }
//      
//      Scope(state: /State.sheet, action: /Action.sheet) {
//        CounterCore()
//      }
//    }
//  }
//  
//  struct State: Equatable {
//    @PresentationState var destination: Destination.State?
//  }
//  enum Action: Equatable {
//    case destination(PresentationAction<Destination.Action>)
//    case showDrillDown
//    case showPopover
//    case showSheet
//  }
//  
//  var body: some ReducerOf<Self> {
//    Reduce { state, action in
//      switch action {
//      case .showDrillDown:
//        state.destination = .drillDown(CounterCore.State())
//        return .none
//      case .showPopover:
//        state.destination = .popover(CounterCore.State())
//        return .none
//      case .showSheet:
//        state.destination = .sheet(CounterCore.State())
//        return .none
//      case .destination:
//        return .none
//      }
//    }
//    .ifLet(\.$destination, action: /Action.destination) {
//      Destination()
//    }
//  }
//}
//
//struct MultipleDestinations: View {
//  let store: StoreOf<MultipleDestinationsCore>
//  @ObservedObject var viewStore: ViewStoreOf<MultipleDestinationsCore>
//  
//  init(store: StoreOf<MultipleDestinationsCore>) {
//    self.store = store
//    self.viewStore = ViewStore(self.store, observe: { $0 })
//  }
//  var body: some View {
//    Form {
//      Button("Show drill-down") {
//        viewStore.send(.showDrillDown)
//      }
//      
//      Button("Show popover") {
//        viewStore.send(.showPopover)
//      }
//      
//      Button("Show sheet") {
//        viewStore.send(.showSheet)
//      }
//    }
//    .navigationDestination(
//      store: self.store.scope(
//        state: \.$destination,
//        action: { .destination($0) }),
//      state: /MultipleDestinationsCore.Destination.State.drillDown,
//      action: MultipleDestinationsCore.Destination.State.drillDown) { store in
//      CounterView(store: store)
//    }
//    .popover(
//      store: self.store.scope(
//        state: \.$destination,
//        action: { .destination($0) }),
//      state: /MultipleDestinationsCore.Destination.State.popover,
//      action: MultipleDestinationsCore.Destination.State.popover) { store in
//      CounterView(store: store)
//    }
//    
//    .sheet(
//      store: self.store.scope(
//        state: \.$destination,
//        action: { .destination($0) }),
//      state: /MultipleDestinationsCore.Destination.State.sheet,
//      action: MultipleDestinationsCore.Destination.State.sheet) { store in
//      CounterView(store: store)
//    }
//  }
//}
//
//#Preview {
//  MultipleDestinations(store: .init(initialState: .init(), reducer: {
//    MultipleDestinationsCore()
//  }))
//}
