import SwiftUI

struct PointView: View {
  var body: some View {
    NavigationStack {
      ZStack(alignment: .bottom) {
        ScrollView {
          NavigationPointView()
          AccountView()
          ItemListsView()
          EventView()
          BenefitView()
          RewardView()
          MonthlyBrandView()
          CardRegisterView()
          PaycoInfoView()
        }
        SearchFeatureView()
      }
    }
  }
}

struct NavigationPointView: View {
  var body: some View {
    HStack {
      Text("포인트")
        .font(.title)
        .bold()
      Spacer()
      ZStack {
        Image(systemName: "doc.text.magnifyingglass")
          .font(.title2)
          .overlay(NotificationCountView(value: .constant(5)))
      }
      ZStack {
        Image(systemName: "bell")
          .font(.title2)
          .overlay(NotificationCountView(value: .constant(24)))
      }
      ZStack {
        Image(systemName: "person.crop.circle.badge.exclamationmark")
          .font(.title2)
          .overlay(NotificationCountView(value: .constant(999)))
      }
    }
    .padding(.horizontal)
  }
}


struct NotificationCountView : View {
  
  @Binding var value: Int
  @State var foreground: Color = .white
  @State var background: Color = .red
  
  private let size = 16.0
  private let x = 20.0
  private let y = 0.0
  
  var body: some View {
    ZStack {
      Capsule()
        .fill(background)
        .frame(width: size * widthMultplier(), height: size, alignment: .topTrailing)
        .position(x: x, y: y)
      
      if hasTwoOrLessDigits() {
        Text("\(value)")
          .foregroundColor(foreground)
          .font(Font.caption)
          .position(x: x, y: y)
      } else {
        Text("999+")
          .foregroundColor(foreground)
          .font(Font.caption)
          .frame(width: size * widthMultplier(), height: size, alignment: .center)
          .position(x: x, y: y)
      }
    }
    .opacity(value == 0 ? 0 : 1)
  }
  
  func hasTwoOrLessDigits() -> Bool {
    return value < 999
  }
  
  func widthMultplier() -> Double {
    if value < 10 {
      // one digit
      return 1.0
    } else if value < 100 {
      // two digits
      return 1.5
    } else {
      return 2.5
    }
  }
}

struct PointView_Previews: PreviewProvider {
  static var previews: some View {
    PointView()
  }
}
