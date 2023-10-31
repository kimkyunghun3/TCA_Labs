import SwiftUI
import ComposableArchitecture

struct TodoCore: Reducer {
  struct State: Equatable, Identifiable {
    @BindingState var text = ""
    @BindingState var isCompleted = false
    let id: UUID
  }
  
  enum Action: BindableAction, Equatable, Sendable {
    case binding(BindingAction<State>)
  }
  
  var body: some Reducer<State, Action> {
    BindingReducer()
  }
}


struct TodoView: View {
  let store: StoreOf<TodoCore>
  @ObservedObject var viewStore: ViewStoreOf<TodoCore>
  
  init(store: StoreOf<TodoCore>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0 })
  }
  
    var body: some View {
      HStack {
        Button {
          viewStore.$isCompleted.wrappedValue.toggle()
        } label: {
          Image(systemName: viewStore.isCompleted ? "checkmark.square" : "square")
        }

        TextField("Untitled Todo", text: viewStore.$text)
      }
      .padding()
      .foregroundStyle(viewStore.isCompleted ? .gray : .black)
    }
}

#Preview {
  TodoView(store: .init(initialState: .init(id: UUID()), reducer: {
    TodoCore()
  }))
}
