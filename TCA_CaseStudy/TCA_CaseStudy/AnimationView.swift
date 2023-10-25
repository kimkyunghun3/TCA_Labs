import SwiftUI
import ComposableArchitecture

struct AnimationCore: Reducer {
  struct State: Equatable {
    @PresentationState var alert: AlertState<Action.Alert>?
    var isOn: Bool = false
    var circleColor = Color.black
    var circlePoint: CGPoint?
  }
  enum Action: Equatable {
    case alert(PresentationAction<Alert>)
    case bigModeTapped(Bool)
    case rainbowButtonTapped
    case resetButtonTapped
    case setColor(Color)
    case tapped(CGPoint)
    
    enum Alert: Equatable {
      case resetButtonTapped
    }
  }
  
  @Dependency(\.continuousClock) var clock
  
  private enum CancelList { case rainbow }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .bigModeTapped(isOn):
        state.isOn = isOn
        return .none
      case .rainbowButtonTapped:
        return .run { send in
          for color in [Color.red, .blue, .green, .orange, .pink, .purple, .yellow, .blue] {
            await send(.setColor(color), animation: .linear)
            try await self.clock.sleep(for: .seconds(1))
          }
        }
        .cancellable(id: CancelList.rainbow)
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
        state = State()
        return .cancel(id: CancelList.rainbow)
      case .alert:
        return .none
      case let .setColor(color):
        state.circleColor = color
        return .none
      case let .tapped(point):
        state.circlePoint = point
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
    VStack(alignment: .leading) {
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
      .gesture(
        DragGesture(minimumDistance: 0).onChanged { gesture in
          viewStore.send(
            .tapped(
              gesture.location),
            animation: .interactiveSpring(
              response: 0.25,
              dampingFraction: 0.1)
          )
        }
      )
      .overlay {
        GeometryReader(content: { geometry in
          Circle()
            .fill(viewStore.circleColor)
            .colorInvert()
            .blendMode(.difference)
            .frame(width: 50, height: 50)
            .scaleEffect(viewStore.isOn ? 2 : 1)
            .position(
              x: viewStore.circlePoint?.x ?? geometry.size.width / 2 ,
              y: viewStore.circlePoint?.y ?? geometry.size.height / 2
            )
            .offset(y: viewStore.circlePoint == nil ? 0 : -44)
        })
        .allowsHitTesting(false)
      }
      
      Toggle(
        "Big mode",
        isOn:
          viewStore
          .binding(get: \.isOn, send: { .bigModeTapped($0) })
          .animation(.interactiveSpring(response: 0.25, dampingFraction: 0.1))
      )
      
      Button("Rainbow") {
        viewStore.send(.rainbowButtonTapped)
      }
      Button("Reset") {
        viewStore.send(.resetButtonTapped)
      }
    }
    .padding()
    .alert(store: self.store.scope(state: \.$alert, action: { .alert($0) }))
  }
}

#Preview {
  AnimationView(store: .init(initialState: .init(), reducer: {
    AnimationCore()
  }))
}
