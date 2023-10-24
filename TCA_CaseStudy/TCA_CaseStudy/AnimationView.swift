import SwiftUI
import ComposableArchitecture

struct AnimationCore: Reducer {
  struct State: Equatable {
    @PresentationState var alert: AlertState<Action.Alert>?
  }
  enum Action: Equatable {
    case alert(PresentationAction<Alert>)
    case bigModeTapped
    case rainbowButtonTapped
    case resetButtonTapped
    
    enum Alert: Equatable {
      case cancelButtonTapped
      case resetButtonTapped
    }
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .bigModeTapped:
        return .none
      case .rainbowButtonTapped:
        return .none
      case .resetButtonTapped:
        state.alert = AlertState {
          TextState("Reset state?")
        } actions: {
          ButtonState(role: .cancel) {
            TextState("Cancel")
          }
          ButtonState(role: .destructive, action: .resetButtonTapped) {
            TextState("Reset")
          }
        }
        
        return .none
      case .alert(.presented(.resetButtonTapped)):
        return .none
      case .alert:
        return .none
      }
    }
    .ifLet(\.$alert, action: /Action.alert)
  }
}

struct AnimationView: View {
  let store: StoreOf<AnimationCore>
  @ObservedObject var viewStore: ViewStoreOf<AnimationCore>
  
  init(store: StoreOf<AnimationCore>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0 } )
  }
  var body: some View {
    VStack {
      Text("""
  This screen demonstrates how changes to application state can drive animations. Because the \
  `Store` processes actions sent to it synchronously you can typically perform animations \
  in the Composable Architecture just as you would in regular SwiftUI.
  
  To animate the changes made to state when an action is sent to the store you can pass along an \
  explicit animation, as well, or you can call `viewStore.send` in a `withAnimation` block.
  
  To animate changes made to state through a binding, use the `.animation` method on `Binding`.
  
  To animate asynchronous changes made to state via effects, use `Effect.run` style of effects \
  which allows you to send actions with animations.
  
  Try it out by tapping or dragging anywhere on the screen to move the dot, and by flipping the \
  toggle at the bottom of the screen.
  """)
      
      HStack {
        Text("Big mode")
        
      }
      
      Button("Rainbow") {
        viewStore.send(.rainbowButtonTapped)
      }
      
      Button("Reset") {
        viewStore.send(.resetButtonTapped)
      }
    }
    .alert(store: self.store.scope(state: \.$alert, action: { .alert($0) }))
    .padding()
  }
}

#Preview {
  AnimationView(store: .init(initialState: .init(), reducer: {
    AnimationCore()
  }))
}
