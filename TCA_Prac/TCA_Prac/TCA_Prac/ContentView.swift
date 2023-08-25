import SwiftUI
import ComposableArchitecture

struct Content: Identifiable, Equatable {
  var id: String {
    return name
  }
  let name: String
  let score: Int
  
  static let dummy: [Content] = [
    .init(name: "사과는 1점", score: 1),
    .init(name: "메론은 10점", score: 10),
    .init(name: "키위는 100점", score: 100)
  ]
}

struct ContentCore: Reducer {
  struct State: Equatable {
    var pushNum = 0
    var alertNum = 0
    var modalNum = 0
    let contents = Content.dummy
    var path = StackState<DetailCore.State>()
    @PresentationState var destination: Destination.State?
  }
  
  enum Action: Equatable {
    case didTapAlertButton
    case didTapClearButton
    case didTapModalButton
    case path(StackAction<DetailCore.State, DetailCore.Action>)
    case destination(PresentationAction<Destination.Action>)
    enum Alert {
      case confirm
    }
  }
  
  @Dependency(\.dismiss) var dismiss
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .didTapAlertButton:
        state.destination = .alert(AlertState(title: {
          TextState("Are you sure?")
        }, actions: {
          ButtonState(role: .cancel, action: .confirm) {
            TextState("닫기")
          }
        }))
        return .none
      case .destination(.presented(.alert(.confirm))):
        state.alertNum += 1
        return .none
      case .didTapClearButton:
        state.alertNum = 0
        state.modalNum = 0
        state.pushNum = 0
        return .none
      case .didTapModalButton:
        state.destination = .modal(.init())
        return .none
      case .destination(.presented(.modal(.delegate(.increase)))):
        state.modalNum += 1
        return .none
      case let .path(.popFrom(id: id)):
        let result = state.path[id: id]!.title.score
        state.pushNum += result
        return .none
      case .path:
        return .none
      case .destination:
        return .none
      }
    }
    .ifLet(\.$destination, action: /Action.destination, destination: {
      Destination()
    })
    .forEach(\.path, action: /Action.path) {
      DetailCore()
    }
  }
}

extension ContentCore {
  struct Destination: Reducer {
    enum State: Equatable {
      case alert(AlertState<ContentCore.Action.Alert>)
      case modal(ModelCore.State)
    }
    
    enum Action: Equatable {
      case alert(ContentCore.Action.Alert)
      case modal(ModelCore.Action)
    }
    
    var body: some ReducerOf<Self> {
      Scope(state: /State.modal, action: /Action.modal) {
        ModelCore()
      }
    }
  }
}

struct ContentView: View {
  let store: StoreOf<ContentCore>
  
  var body: some View {
    NavigationStackStore(self.store.scope(state: \.path, action: { .path($0) })) {
      WithViewStore(self.store, observe: { $0 }) { viewStore in
        VStack {
          List {
            ForEach(viewStore.contents) { content in
              NavigationLink(state: DetailCore.State(title: content)) {
                Text(content.name)
              }
            }
          }
          .listStyle(.plain)
          .frame(height: 200)
          HStack {
            AlertView(title: "Alert") {
              viewStore.send(.didTapAlertButton)
            }
            AlertView(title: "Modal") {
              viewStore.send(.didTapModalButton)
            }
            AlertView(title: "Clear") {
              viewStore.send(.didTapClearButton)
            }
          }
          VStack(alignment: .leading) {
            Text("Alert: \(viewStore.alertNum)")
            Text("Modal: \(viewStore.modalNum)")
            Text("Push: \(viewStore.pushNum)")
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding()
          .font(.largeTitle)
          .background(
            RoundedRectangle(cornerRadius: 10)
              .foregroundColor(.gray)
          )
          .padding(.horizontal, 20)
        }
      }
    } destination: {
      DetailView(store: $0)
    }
    .alert(
      store: self.store.scope(state: \.$destination, action: { .destination($0) }),
      state: /ContentCore.Destination.State.alert,
      action: ContentCore.Destination.Action.alert
    )
    .sheet(
      store: self.store.scope(state: \.$destination, action: { .destination($0)}),
      state: /ContentCore.Destination.State.modal,
      action: ContentCore.Destination.Action.modal,
      content: { store in
        ModalView(store: store)
      }
    )
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(store: .init(initialState: ContentCore.State(), reducer: {
      ContentCore()
    }))
  }
}
