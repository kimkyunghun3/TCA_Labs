import SwiftUI

struct ItemListsView: View {
  let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
  
  var body: some View {
    LazyVGrid(columns: columns, spacing: 30) {
      ForEach(ItemList.itemList) { item in
        VStack(spacing: 15) {
          Image(item.imageName)
            .resizable()
            .frame(width: 40, height: 40)
          Text(item.rawValue)
            .font(.subheadline)
        }
      }
    }
    .padding()
  }
}

struct ItemListsView_Previews: PreviewProvider {
  static var previews: some View {
    ItemListsView()
  }
}
