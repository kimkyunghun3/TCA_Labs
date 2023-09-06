import SwiftUI

struct MonthlyBrandView: View {
  @State private var items = BrandList.data
  @State private var offset: CGFloat = 0
  private let timer = Timer.publish(every: 0.01, on: .main, in: .default).autoconnect()

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
      LazyHStack {
        ForEach(0..<items.count, id: \.self) { index in
          VStack(spacing: 0) {
            if index == 3 || index == 6 {
              NewView()
                .frame(height: -10)
            }
            Image(items[index].image)
              .resizable()
              .clipShape(Circle())
              .frame(width: 70, height: 100)
              .padding(5)
          }

            .onAppear {
              if index == items.count - 3 {
                items.append(contentsOf: BrandList.data)
              }
            }
        }
      }
      .frame(height: 150)
      .offset(x: offset)
      .animation(.easeIn, value: offset)
    }
    .onReceive(timer) { _ in
      offset -= 0.3
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
