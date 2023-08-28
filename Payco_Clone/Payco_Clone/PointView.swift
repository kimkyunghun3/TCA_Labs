import SwiftUI

struct PointView: View {
  var body: some View {
    VStack(spacing: 30) {
      AccountView()
      ItemListsView()
      EventView()
      Spacer()
    }
  }
}

struct PointView_Previews: PreviewProvider {
  static var previews: some View {
    PointView()
  }
}
