import SwiftUI

struct PointView: View {
  var body: some View {
    NavigationView {
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
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Text("포인트")
            .font(.title)
            .bold()
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          HStack {
            Image(systemName: "doc.text.magnifyingglass")
            Image(systemName: "bell")
            Image(systemName: "person.crop.circle.badge.exclamationmark")
          }
          .font(.title3)
        }
      }
    }
  }
}

struct PointView_Previews: PreviewProvider {
  static var previews: some View {
    PointView()
  }
}
