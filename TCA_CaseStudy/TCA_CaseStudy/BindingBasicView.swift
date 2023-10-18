import SwiftUI
import ComposableArchitecture

struct BindingBasicCore: Reducer {
  struct State: Equatable {
    var name: String = ""
    var isDisable: Bool = false
    var maxSliderValue = 10
    var sliderValue = 5.0
  }
  
  enum Action: Equatable {
    case textFieldDidEdited(String)
    case toggleDidTapped(isOn: Bool)
    case decrementButtonTapped
    case incrementButtonTapped
    case sliderDidEdited(Double)
    case resetButtonTapped
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .textFieldDidEdited(name):
        state.name = name
        return .none
      case let .toggleDidTapped(isOn):
        state.isDisable = isOn
        return .none
      case .decrementButtonTapped:
        state.maxSliderValue -= 1
        return .none
      case .incrementButtonTapped:
        state.maxSliderValue += 1
        return .none
      case let .sliderDidEdited(value):
        state.sliderValue = value
        return .none
      case .resetButtonTapped:
        state.name = ""
        state.isDisable = false
        state.maxSliderValue = 10
        state.sliderValue = 5.0
        return .none
      }
    }
  }
}

struct BindingBasicView: View {
  let store: StoreOf<BindingBasicCore>
  @ObservedObject var viewStore: ViewStoreOf<BindingBasicCore>
  
  init(store: StoreOf<BindingBasicCore>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0 })
  }
  
  var body: some View {
    VStack {
      HStack {
        TextField("Type here", text: viewStore.binding(get: \.name, send: { .textFieldDidEdited($0) })
        )
        Text(viewStore.name)
      }
      HStack {
        Text("Disalbe other controls")
        Spacer()
        Toggle("", isOn: viewStore.binding(get: \.isDisable, send: { .toggleDidTapped(isOn: $0)
        }))
      }
      
      HStack {
        Text("Max slider value: \(viewStore.maxSliderValue)")
        Spacer()
        Button("-") {
          viewStore.send(.decrementButtonTapped)
        }
        .font(.title3)
        .padding(.horizontal)
        .background(.gray.opacity(0.2))
        .cornerRadius(5)
        .disabled(viewStore.isDisable)
        Button("+") {
          viewStore.send(.incrementButtonTapped)
        }
        .font(.title3)
        .padding(.horizontal)
        .background(.gray.opacity(0.2))
        .cornerRadius(5)
        .disabled(viewStore.isDisable)
      }
      
      HStack {
        Text("Slider value \(Int(viewStore.sliderValue))")
        Slider(value: viewStore.binding(
          get: \.sliderValue,
          send: { .sliderDidEdited($0) }),
               in: 0...Double(viewStore.maxSliderValue)
            )
        .disabled(viewStore.isDisable)
      }
      HStack {
        Button("Reset") {
          viewStore.send(.resetButtonTapped)
        }
        .foregroundColor(.red)
        Spacer()
      }
    }
    .padding()
  }
}

struct BindingBasicView_Previews: PreviewProvider {
  static var previews: some View {
    BindingBasicView(store: Store(initialState: .init(), reducer: {
      BindingBasicCore()
    }))
  }
}
