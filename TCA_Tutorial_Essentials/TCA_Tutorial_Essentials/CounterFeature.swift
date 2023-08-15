import SwiftUI
import ComposableArchitecture

struct CounterFeature: Reducer {
    struct State: Equatable {
        var count = 0
        var fact: String?
        var isLoading = false
        var isTimerRunning = false
    }
    
    enum Action {
        case plusButtonTapped
        case minusButtonTapped
        case factButtonTapped
        case factResponse(String)
        case timerTick
        case toggleTimerButtonTapped
    }

    enum CancelID { case timer }

    @Dependency(\.continuousClock) var clock
    @Dependency(\.numberFact) var numberFact
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action  {
        case .plusButtonTapped:
            state.count += 1
            state.fact = nil
            return .none
        case .minusButtonTapped:
            state.count -= 1
            state.fact = nil
            return .none
        case .factButtonTapped:
            state.fact = nil
            state.isLoading = true

            return .run { [count = state.count] send in
                let (data, _) = try await URLSession.shared
                    .data(from: URL(string: "http://numbersapi.com/\(count)")!)
                let fact = String(decoding: data, as: UTF8.self)
                await send(.factResponse(fact))
            }
        case let .factResponse(fact):
            state.fact = fact
            state.isLoading = false
            return .none
        case .toggleTimerButtonTapped:
            state.isTimerRunning.toggle()
            if state.isTimerRunning {

                return .run { send in
                    while true {
                        try await Task.sleep(for: .seconds(1))
                        await send(.timerTick)
                    }
                }
                .cancellable(id: CancelID.timer)
            } else {
                return .cancel(id: CancelID.timer)
            }
        case .timerTick:
            state.count += 1
            state.fact = nil
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

            Button(viewStore.isTimerRunning ? "Stop timer" : "Start timer") {
                viewStore.send(.toggleTimerButtonTapped)
            }
            .common()

            Button("Fact") {
                viewStore.send(.factButtonTapped)
            }
            .common()

            if viewStore.isLoading {
                ProgressView()
            } else if let fact = viewStore.fact {
                Text(fact)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()
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
