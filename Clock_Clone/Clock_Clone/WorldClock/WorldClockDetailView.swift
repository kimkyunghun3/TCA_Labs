import SwiftUI
import ComposableArchitecture

struct WorldClockDetailView: View {
  let store: StoreOf<WorldClockDetailFeature>
  
    var body: some View {
      WithViewStore(self.store, observe: { $0 }) { viewStore in
        List {
          Text(viewStore.location)
        }
      }
        
    }
}

struct WorldClockDetailView_Previews: PreviewProvider {
    static var previews: some View {
      WorldClockDetailView(store: .init(initialState: .init(location: "서울")) {
        WorldClockDetailFeature()
      })
    }
}
