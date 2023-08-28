import SwiftUI

struct BenefitView: View {
  let buttonList = ["전체", "온라인", "오프라인", "NEW"]
  let monthlyPointBenefit = "8월 포인트 결제 혜택"
  @State private var isSelectied = false
  
  var body: some View {
    VStack(alignment: .leading) {
      title
      buttons
      rows
    }
//    .frame(height: 500)
    .background(Color.gray.opacity(0.2))
    .cornerRadius(30)
  }
}

private extension BenefitView {
  
  var title: some View {
    VStack(alignment: .leading) {
      Text(monthlyPointBenefit)
        .font(.title)
        .bold()
        .padding()
    }
  }
  
  var buttons: some View {
    HStack {
      ForEach(buttonList, id: \.self) { buttonTitle in
        Button {
          
        } label: {
          Text(buttonTitle)
            .padding()
            .font(.subheadline)
            .foregroundColor(.black)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(30)
            .padding()
        }
      }
    }
  }
  
  var rows: some View {
    VStack(alignment: .leading) {
      ForEach(BrandList.data) { brand in
        HStack(spacing: 20) {
          Image(brand.image)
            .resizable()
            .frame(width: 50, height: 50)
            .clipShape(Circle())
          
          VStack(alignment: .leading, spacing: 10) {
            Text(brand.condition)
              .font(.caption)
            Text(brand.description)
              .font(.title3)
              .bold()
          }
        }
        .padding()
      }

    }
  }
}

struct BenefitView_Previews: PreviewProvider {
  static var previews: some View {
    BenefitView()
  }
}
