import SwiftUI

struct BenefitView: View {
  let buttonList = ["전체", "온라인", "오프라인", "NEW"]
  let monthlyPointBenefit = "8월 포인트 결제 혜택"
  @State private var isSelectied = "전체"
  @State var moreCount = 1
  
  var body: some View {
    VStack {
      title
      buttons
      rows
      moreButton
    }
    .padding()
    .background(Color.gray.opacity(0.05))
    .cornerRadius(30)
    .padding()
  }
}

private extension BenefitView {
  
  var title: some View {
    VStack(alignment: .leading) {
      Text(monthlyPointBenefit)
        .font(.title2)
        .bold()
    }
    .padding(.vertical)
    .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  var buttons: some View {
    ScrollView(.horizontal) {
      HStack(spacing: 10) {
        ForEach(buttonList, id: \.self) { buttonTitle in
          Button {
            isSelectied = buttonTitle
          } label: {
            Text(buttonTitle)
              .padding()
              .fontWeight(isSelectied == buttonTitle ? .bold : .light)
              .foregroundColor(isSelectied == buttonTitle ? .white : .black)
              .background(isSelectied == buttonTitle ? .black : Color.gray.opacity(0.15))
              .cornerRadius(25)
          }
        }
      }
    }
  }
  
  var rows: some View {
    VStack(alignment: .leading) {
      ForEach(0..<4) { index in
        HStack(spacing: 20) {
          Image(BrandList.data[index].image)
            .resizable()
            .frame(width: 50, height: 50)
            .clipShape(Circle())
          
          VStack(alignment: .leading, spacing: 3) {
            Text(BrandList.data[index].condition)
              .font(.caption)
            Text(BrandList.data[index].description)
              .font(.body)
              .bold()
          }
        }
        .padding(.top, 20)
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  var moreButton: some View {
    Button {
      moreCount += 1
      if moreCount == 9 {
        moreCount = 1
      }
    } label: {
      Text("더보기 \(moreCount) / 8")
    }
    .buttonStyle(.plain)
    .frame(width: 100, height: 10)
    .padding()
    .foregroundColor(.black)
    .background(Color.white)
    .cornerRadius(30)
    .padding()
  }
}

struct BenefitView_Previews: PreviewProvider {
  static var previews: some View {
    BenefitView()
  }
}
