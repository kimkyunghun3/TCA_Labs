import SwiftUI
import ComposableArchitecture

struct WorldClockDetailView: View {
  let store: StoreOf<WorldClockDetailFeature>
  let contents = City.data
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      ScrollView {
        LazyVStack(pinnedViews: [.sectionHeaders]) {
          Section {
            ForEach(contents) { content in
              HStack {
                Text("\(content.name),")
                Text(content.country ?? "")
                Spacer()
              }
              
              .frame(maxWidth: .infinity)
              .padding(.leading, 15)
              .padding(3)
              Divider()
            }
          } header: {
            VStack {
              Text("도시 선택")
              HStack {
                ZStack(alignment: .leading) {
                  TextField("검색", text: viewStore.binding(get: \.location, send: { .textDidEdited(title: $0) }))
                    .padding(10)
                    .padding(.horizontal, 20)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(10)
                    .tint(.orange)
                  
                  Image(systemName: "magnifyingglass")
                    .padding(3)
                }

                Button("취소") {
                  store.send(.cancelButtonTapped)
                }
                .tint(.orange)
                .bold()
              }
            }
            .padding()
          }
          .background(Color.white)
        }
      }
    }
    .clipped()
  }
}


struct WorldClockDetailView_Previews: PreviewProvider {
  static var previews: some View {
    WorldClockDetailView(store: .init(initialState: .init(location: "서울")) {
      WorldClockDetailFeature()
    })
  }
}
