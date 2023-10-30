import SwiftUI
import ComposableArchitecture

enum Filter: LocalizedStringKey, CaseIterable, Hashable {
  case all = "All"
  case active = "Active"
  case completed = "Completed"
}

struct TodosCore: Reducer {
  struct State: Equatable {
    @BindingState var filter: Filter = .all
    var todos: IdentifiedArrayOf<TodoCore.State> = []
    
    var filteredTodo: IdentifiedArrayOf<TodoCore.State> {
      switch filter {
      case .all:
        return self.todos
      case .active:
        return self.todos.filter { !$0.isCompleted }
      case .completed:
        return self.todos.filter(\.isCompleted)
      }
    }
  }
  
  enum Action: BindableAction, Equatable {
    case editButtonTapped
    case clearButtonTapped
    case addButtonTapped
    case binding(BindingAction<State>)
    case todo(id: TodoCore.State.ID, action: TodoCore.Action)
    case sortCompletedTodos
  }
  
  @Dependency(\.continuousClock) var clock
  @Dependency(\.uuid) var uuid
  enum CancelID { case todoCompletion }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .editButtonTapped:
        return .none
      case .clearButtonTapped:
        return .none
      case .addButtonTapped:
        return .none
      case .binding:
        return .none
      case .todo(id: _, action: .binding(\.$isCompleted)):
        return .run { send in
          try await self.clock.sleep(for: .seconds(1))
          await send(.sortCompletedTodos, animation: .default)
        }
        .cancellable(id: CancelID.todoCompletion, cancelInFlight: true)
      case .todo:
        return .none
      case .sortCompletedTodos:
        state.todos.sort { $1.isCompleted && !$0.isCompleted }
        return .none
      }
    }
    .forEach(\.todos, action: /Action.todo(id:action:)) {
      TodoCore()
    }
  }
}

struct TodosView: View {
  let store: StoreOf<TodosCore>
  @ObservedObject var viewStore: ViewStoreOf<TodosCore>
  
  struct ViewState: Equatable {
    @BindingViewState var filter: Filter
    
    init(store: BindingViewStore<TodosCore.State>) {
      self._filter = store.$filter
    }
  }
  
  init(store: StoreOf<TodosCore>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0} )
  }
  
  var body: some View {
    NavigationStack {
      VStack {
        Picker("Picker", selection: viewStore.$filter.animation()) {
          ForEach(Filter.allCases, id: \.self) { filter in
            Text(filter.rawValue).tag(filter)
          }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
        
        List {
          ForEachStore(self.store.scope(state: \.filteredTodo, action: { .todo(id: $0, action: $1) })) { store in
            TodoView(store: store)
          }
        }
      }
      .navigationTitle("Todos")
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          HStack(spacing: 20) {
            EditButton()
            Button("Clear Completed") {
              viewStore.send(.clearButtonTapped)
            }
            
            Button("Add Todo") {
              viewStore.send(.addButtonTapped)
            }
          }
        }
      }
    }
  }
}

#Preview {
  TodosView(store: .init(initialState: .init(), reducer: {
    TodosCore()
  }))
}
