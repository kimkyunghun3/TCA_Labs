import SwiftUI

struct PointView: View {
  var body: some View {
    ScrollView {
      AccountView()
      ItemListsView()
      EventView()
      BenefitView()
      RewardView()
      MonthlyBrandView()
      CardRegisterView()
      PaycoInfoView()
    }
  }
}

struct PointView_Previews: PreviewProvider {
  static var previews: some View {
    PointView()
  }
}
