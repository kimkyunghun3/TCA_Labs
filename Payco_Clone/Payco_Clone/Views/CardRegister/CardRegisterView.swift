import SwiftUI

struct PagingControls: View {
  
  @Binding var pagecontrolTracker: Int
  let totalCount: Int

  var body: some View {
    HStack {
      ForEach(1..<totalCount + 1, id: \.self) { pagingIndex in
        RoundedRectangle(cornerRadius: 10)
          .frame(width: pagecontrolTracker == pagingIndex ? 40 : 6, height: 6)
          .foregroundColor(pagecontrolTracker == pagingIndex ? .black : .gray.opacity(0.2))
          .animation(.easeInOut, value: pagecontrolTracker)
      }
    }
  }
}

struct CardRegisterView: View {
  private let titles: [String] = [
    "내 주변 가맹점 확인하고\n주요 브랜드에서 적립받기",
    "결제할 때 사용 가능한\n5천 포인트 바로 받기",
    "PAYCO 포인트로\n해외결제도 된다는 사실",
    "이달의 브랜드 확인하고\n더 많은 포인트를 적립 받으세요",
    "내 주변 가맹점 확인하고\n주요 브랜드에서 적립받기",
    "결제할 때 사용 가능한\n5천 포인트 바로 받기"
  ]
  
  private let descriptions: [String] = [
    "패션, 뷰티 브랜드부터\n집 주변 카페까지!",
    "신청까지 최대 1분,\n신청완료 즉시 5천P 지급!",
    "해외 호텔 & 항공 예약 시\n할인은 기본,\n현지화 출금까지 가능해요",
    "결제할 때마다\n최대 15%까지 적립!",
    "패션, 뷰티 브랜드부터\n집 주변 카페까지!",
    "신청까지 최대 1분,\n신청완료 즉시 5천P 지급!"
  ]
  
  @State var pagecontrolTracker: Int  = 1
  
  var body: some View {
    VStack {
      TabView(selection: $pagecontrolTracker) {
        ForEach(0..<titles.count, id: \.self) { index in
          ApplyCardView(
            titleValue: titles[index],
            descriptionVlaue: descriptions[index]
          )
          .padding(.horizontal)
            .tag(index)
        }
      }
      .onChange(of: pagecontrolTracker) { _ in
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
          if pagecontrolTracker == 5 { pagecontrolTracker = 1 }
          if pagecontrolTracker == 0 { pagecontrolTracker = 4 }
        }
      }
      .tabViewStyle(.page(indexDisplayMode: .never))
      
      PagingControls(
        pagecontrolTracker: $pagecontrolTracker,
        totalCount: 4
      )
      .offset(y: -20)
    }
    .frame(height: 400)
  }
}

struct ApplyCardView: View {
  let titleValue: String
  let descriptionVlaue: String
  
  var body: some View {
    VStack {
      HStack(alignment: .top) {
        VStack(alignment: .leading, spacing: 20) {
          title
          description
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
        image
          .frame(width: 150)
          .frame(maxHeight: .infinity)
      }
      .padding()
      Spacer()
      applyButton
    }
    .frame(height: 300)
    .frame(maxWidth: .infinity)
    .padding()
    .background(Color.gray.opacity(0.05))
    .cornerRadius(30)
  }
}

private extension ApplyCardView {
  var image: some View  {
    Image("Money")
      .resizable()
      .scaledToFit()
      .foregroundColor(.teal)
  }
  var title: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(titleValue)
      
    }
    .font(.title2)
  }
  
  var description: some View {
    VStack(alignment: .leading, spacing: 5) {
      Text(descriptionVlaue)
    }
    .foregroundColor(.gray)
  }
  
  var applyButton: some View  {
    Button {
      // 신청하기 action
    } label: {
      Text("카드 신청하기 >")
    }
    .font(.title3)
    .bold()
    .frame(maxWidth: .infinity)
    .padding()
    .background(Color.red)
    .cornerRadius(15)
    .foregroundColor(.white)
  }
}

struct CardRegisterView_Previews: PreviewProvider {
  static var previews: some View {
    CardRegisterView()
  }
}
