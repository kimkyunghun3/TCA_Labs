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
    @BindingState var editMode: EditMode = .inactive
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
  
  enum Action: BindableAction, Equatable, Sendable {
    case clearButtonTapped
    case addButtonTapped
    case binding(BindingAction<State>)
    case todo(id: TodoCore.State.ID, action: TodoCore.Action)
    case sortCompletedTodos
    case delete(IndexSet)
    case move(IndexSet, Int)
  }
  
  @Dependency(\.continuousClock) var clock
  @Dependency(\.uuid) var uuid
  enum CancelID { case todoCompletion }
  
  var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .clearButtonTapped:
        state.todos.removeAll(where: \.isCompleted)
        return .none
      case .addButtonTapped:
        state.todos.insert(TodoCore.State(id: self.uuid()), at: 0)
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
      case let .delete(indexSet):
        for index in indexSet {
          state.todos.remove(id: state.filteredTodo[index].id)
        }
        return .none
      case var .move(source, destination):
        if state.filter == .completed {
          source = IndexSet(
            source
              .map { state.filteredTodo[$0] }
              .compactMap { state.todos.index(id: $0.id) }
          )
          destination =
          (destination < state.filteredTodo.endIndex
           ? state.todos.index(id: state.filteredTodo[destination].id)
           : state.todos.endIndex) ?? destination
        }
        state.todos.move(fromOffsets: source, toOffset: destination)
        
        return .run { send in
          try await self.clock.sleep(for: .milliseconds(100))
          await send(.sortCompletedTodos)
        }
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
    @BindingViewState var editMode: EditMode
    let isClearCompletedButtonDisabled: Bool
    
    init(store: BindingViewStore<TodosCore.State>) {
      self._editMode = store.$editMode
      self._filter = store.$filter
      self.isClearCompletedButtonDisabled = !store.todos.contains(where: \.isCompleted)
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
          .onDelete { viewStore.send(.delete($0)) }
          .onMove { viewStore.send(.move($0, $1)) }
        }
      }
      .navigationTitle("Todos")
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          HStack(spacing: 20) {
            EditButton()
            Button("Clear Completed") {
              viewStore.send(.clearButtonTapped, animation: .default)
            }
            
            Button("Add Todo") {
              viewStore.send(.addButtonTapped)
            }
          }
        }
      }
      .environment(\.editMode, viewStore.$editMode)
    }
  }
}

extension IdentifiedArray where ID == TodoCore.State.ID, Element == TodoCore.State {
  static let mock: Self = [
    TodoCore.State(text: "Check mail", isCompleted: false, id: UUID()),
    TodoCore.State(text: "Check Buy Milk", isCompleted: false, id: UUID()),
    TodoCore.State(text: "Call Bro", isCompleted: true, id: UUID())
  ]
}


#Preview {
  TodosView(store: Store(initialState: TodosCore.State(todos: .mock)) {
    TodosCore()
  }
  )
}
