import SwiftUI
import ComposableArchitecture

struct CounterFeature: Reducer {
    struct State: Equatable {
        var count = 0
    }
    
    enum Action {
        case plusButtonTapped
        case minusButtonTapped
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action  {
        case .plusButtonTapped:
            state.count += 1
            return .none
        case .minusButtonTapped:
            state.count -= 1
            return .none
        }
    }
}

struct CounterView: View {
    let store: StoreOf<CounterFeature>
    @ObservedObject var viewStore: ViewStoreOf<CounterFeature>
    
    init(store: StoreOf<CounterFeature>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }
    
    var body: some View {
        VStack {
            Text(String(viewStore.count))
                .commonButton()
            
            HStack {
                Button("+") {
                    viewStore.send(.plusButtonTapped)
                }
                .commonButton()
                
                Button("-") {
                    viewStore.send(.minusButtonTapped)
                }
                .commonButton()

            }
        }
    }
}

fileprivate extension View {
    func commonButton() -> some View {
        modifier(ButtonModifier())
    }
}

fileprivate struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        
        content
            .font(.largeTitle)
            .padding()
            .background(Color.black.opacity(0.1))
            .cornerRadius(10)
    }
}

private extension View {
    func common() -> some View {
        self
            .font(.largeTitle)
            .padding()
            .background(Color.black.opacity(0.1))
            .cornerRadius(10)
    }
}

struct CounterFeature_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(
            store: Store(
                initialState: CounterFeature.State(),
                reducer: { CounterFeature() }
            )
        )
    }
}
