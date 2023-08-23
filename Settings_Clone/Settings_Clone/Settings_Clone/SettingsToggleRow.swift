import SwiftUI
import ComposableArchitecture

struct SettingsToggleRow: View {
//  var item: Settings
  let store: StoreOf<SettingsToggleFeature>
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      HStack(spacing: 15) {
        Image(systemName: viewStore.item.imageName)
          .resizable()
          .scaledToFit()
          .frame(width: 20, height: 20)
          .foregroundColor(.white)
          .padding(5)
          .background(viewStore.item.imageColor)
          .cornerRadius(5)
        Text(viewStore.item.name)
          .font(.callout)
        Spacer()
        Toggle("", isOn: viewStore.binding(get: \.toggle, send: .toggleTapped))
      }
      .padding(.top, 5)
      .padding(.bottom, 5)
    }
  }
}

//private extension SettingsToggleRow {
//  var image: some View {
////    Image(systemName: viewStore.item.imageName)
////      .resizable()
////      .scaledToFit()
////      .frame(width: 20, height: 20)
////      .foregroundColor(.white)
////      .padding(5)
////      .background(item.imageColor)
////      .cornerRadius(5)
//  }
//  
//  var title: some View {
////    Text(item.name)
////      .font(.callout)
//  }
//}
