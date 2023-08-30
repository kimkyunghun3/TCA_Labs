import SwiftUI

struct MonthlyBrandView: View {
  let columns: [GridItem] = Array(repeating: .init(.fixed(50)), count: BrandList.data.count)
  
  var body: some View {
    VStack {
      HStack {
        title
        Spacer()
        seeButton
      }
      brands
    }
    .padding()
    .background(Color.gray.opacity(0.05))
    .cornerRadius(30)
    .padding()
  }
}

private extension MonthlyBrandView {
  
  var brands: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      LazyVGrid(columns: columns, spacing: 10) {
        ForEach(BrandList.data) { brand in
          Image(brand.image)
            .resizable()
            .clipShape(Circle())
            .frame(width: 50, height: 50)
            .padding()
        }
      }
    }
  }
  
  var title: some View {
    VStack(alignment: .leading, spacing: 5) {
      Text("이달의 브랜드")
      Text("최대 15% 적립")
        .foregroundColor(.red)
    }
    .bold()
    .font(.title2)
    .padding()
  }
  
  var seeButton: some View {
    Button {
      // 보러가기 aciton
    } label: {
      Text("보러가기")
    }
    .frame(height: 10)
    .padding()
    .foregroundColor(.black)
    .background(Color.gray.opacity(0.1))
    .cornerRadius(10)
    .font(.subheadline)
  }
}

struct MonthlyBrandView_Previews: PreviewProvider {
  static var previews: some View {
    MonthlyBrandView()
  }
}
