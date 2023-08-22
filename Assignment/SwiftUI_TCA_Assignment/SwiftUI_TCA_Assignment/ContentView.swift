import SwiftUI
import ComposableArchitecture

struct DialogFeature: Reducer {
    struct State: Equatable {
        var number: String = ""
        var dialogs = Dialog.all()
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

struct DialogView: View {
    let store: StoreOf<DialogFeature>
    @ObservedObject var viewStore: ViewStoreOf<DialogFeature>
    
    init(store: StoreOf<DialogFeature>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }
    
    let layout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        VStack(spacing: 20) {
            Spacer()
            VStack(spacing: 10) {
                
                Text(viewStore.number)
                    .font(.largeTitle)
                    .gesture(
                        DragGesture(coordinateSpace: .global)
                            .onEnded {
                                if $0.translation.width < 0 {
                                    store.send(.deleteButtonTapped)
                                }
                            }
                    )
                    .animation(nil, value: viewStore.number)
                
                Menu {
                    Button {
                        store.send(.addNumberButtonTapped)
                    } label: {
                        Label("새로운 연락처 등록", systemImage: "person.circle")
                    }
                    
                    Button {
                        store.send(.addNumberButtonTapped)
                    } label: {
                        Label("기존의 연락처에 추가", systemImage: "person.crop.circle.badge.plus")
                    }
                } label: {
                    Text("번호 추가")
                        .font(.title3)
                        .opacity(viewStore.number.isEmpty ? 0 : 1)
                }
            }
            Spacer()
            
            LazyVGrid(columns: layout, spacing: 20) {
                ForEach(viewStore.dialogs) { dialog in
                    CircleView(dialog: dialog) {
                        viewStore.send(.numberButtonTapped(dialog.number))
                    }
                }
                
                Button("") {
                    
                }
                
                Button {
                    viewStore.send(.callButtonTapped)
                } label: {
                    Image(systemName: "phone.fill")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                }
                .frame(width: 90, height: 90)
                .background(.green)
                .clipShape(Circle())
                
                if viewStore.number.isEmpty == false {
                    Button {
                        viewStore.send(.deleteButtonTapped, animation: .easeOut)
                    } label: {
                        Image(systemName: "delete.backward.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.black, .gray.opacity(0.35))
                    }
                }
            }
            .padding([.leading, .trailing], 40)
            .padding(.bottom, 30)
        }
    }
}

