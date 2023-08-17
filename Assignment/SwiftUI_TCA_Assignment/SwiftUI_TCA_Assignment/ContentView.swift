import SwiftUI
import ComposableArchitecture

struct DialogFeature: Reducer {
    struct State: Equatable {
        var number: String = ""
    }
    
    enum Action {
        case numberButtonTapped(String)
        case addNumberButtonTapped
        case callButtonTapped
        case deleteButtonTapped
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .numberButtonTapped(number):
            state.number.append(number)
            return .none
        /// 번호추가
        case .addNumberButtonTapped:
            return .none
        case .callButtonTapped:
            return .none
        case .deleteButtonTapped:
            _ = state.number.popLast()
            return .none
        }
    }
}

struct ContentView: View {
    
    let dialog = Dialog.all()
    let store: StoreOf<DialogFeature>
    @ObservedObject var viewStore: ViewStoreOf<DialogFeature>
    
    init(store: StoreOf<DialogFeature>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }
    
    var body: some View {
        
        let chuckedData = dialog.chunked(into: 3)
    
        VStack(spacing: 20) {
            Spacer()
            VStack(spacing: 10) {
                if viewStore.number.isEmpty == false {
                    Text(viewStore.number)
                        .font(.largeTitle)
                    
                    Button("번호 추가") {
                        viewStore.send(.addNumberButtonTapped)
                    }
                }
            }
            Spacer()
            
            ForEach(0..<chuckedData.count, id: \.self) { index in
                HStack(alignment: .center, spacing: 20) {
                    ForEach(chuckedData[index], id: \.self) { dialog in
                        
                        CircleView(dialog: dialog) {
                            viewStore.send(.numberButtonTapped(dialog.number))
                        }
                    }
                }
            }
            
            HStack(spacing: 20) {
                Button {
                    viewStore.send(.callButtonTapped)
                } label: {
                    Image(systemName: "phone.fill")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        
                }
                .frame(width: 70, height: 70)
                .background(.green)
                .clipShape(Circle())
                
                if viewStore.number.isEmpty == false {
                    Button {
                        viewStore.send(.deleteButtonTapped)
                    } label: {
                        Image(systemName: "delete.backward.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.black, .gray.opacity(0.35))
                    }
                }
            }
        }
        .padding()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            store: Store(
                initialState: DialogFeature.State(),
                reducer: { DialogFeature() })
        )
    }
}
