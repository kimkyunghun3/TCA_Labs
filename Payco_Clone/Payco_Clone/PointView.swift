import SwiftUI

struct PointView: View {
  var body: some View {
    ScrollView {
      AccountView()
      ItemListsView()
      EventView()
      BenefitView()
      Spacer()
    }
  }
}

struct PointView_Previews: PreviewProvider {
  static var previews: some View {
    PointView()
  }
}
