import SwiftUI

struct DSPopup: View {
  /// 타이틀
  let title: String
  /// 설명
  let description: String
  /// 서브설명
  let subDescription: String?
  /// 배경색
  let background: Color
  /// cornerRadius
  let cornerRadius: CGFloat
  /// 버튼 타이틀 배열
  var buttonTitles: [String] = []
  /// 오른쪽 버튼 존재 유무
  @State private var isRightButtonExist = false
  /// 왼쪽 버튼 액션
  let leftAction: () -> Void
  /// 오른쪽 버튼 액션
  let rightAction: () -> Void
  
  init(
    title: String,
    description: String,
    subDescription: String? = "",
    background: Color,
    cornerRadius: CGFloat,
    buttonTitles: [String],
    isRightButtonExist: Bool,
    leftAction: @escaping () -> Void = {},
    rightAction: @escaping () -> Void = {}
  ) {
    self.title = title
    self.description = description
    self.subDescription = subDescription
    self.background = background
    self.cornerRadius = cornerRadius
    self.buttonTitles = buttonTitles
    self.isRightButtonExist = isRightButtonExist
    self.leftAction = leftAction
    self.rightAction = rightAction
  }
  
  var body: some View {
    VStack {
      Text(title)
        .foregroundColor(.gray.opacity(0.5))
      
      Spacer()
      
      VStack(spacing: 20) {
        Text(description)
          .lineLimit(4)
          .multilineTextAlignment(.center)
        Text(subDescription ?? "")
          .opacity(subDescription == "" ? 0 : 1)
          .foregroundColor(.gray.opacity(0.5))
      }
      
      Spacer()
      
      HStack {
        Button {
          leftAction()
        } label: {
          Text(buttonTitles[0])
            .padding(.vertical, 21)
            .frame(maxWidth: .infinity)
            .background(self.buttonTitles.count == 1 ? .green : .gray)
            .cornerRadius(15)
        }
        
        if isRightButtonExist {
          Button {
            rightAction()
          } label: {
            Text(self.buttonTitles.count == 1 ? self.buttonTitles[0] : self.buttonTitles[1])
              .padding(.vertical, 21)
              .frame(maxWidth: .infinity)
              .background(self.buttonTitles.count == 2 ? .green : .white)
              .cornerRadius(15)
          }
        }
      }
      .foregroundColor(.white)
    }
    .font(.title3)
    .frame(height: 294)
    .frame(maxWidth: .infinity)
    .padding()
    .background(background)
    .cornerRadius(cornerRadius)
  }
}

struct DSPopup_Previews: PreviewProvider {
  static var previews: some View {
    ScrollView {
      VStack {
        DSPopup(
          title: "진료안내",
          description: "설정중이던 진료 조건을 임시저장할까요?",
          background: .gray.opacity(0.1),
          cornerRadius: 15,
          buttonTitles: ["취소", "확인"],
          isRightButtonExist: true) {
            print("left action")
          } rightAction: {
            print("right action")
          }
        
        DSPopup(
          title: "안내",
          description: "약 수령 방법을\n 당일 배송으로 선택하시겠습니까?",
          subDescription: "약 3시간 이내 배송",
          background: .gray.opacity(0.1),
          cornerRadius: 15,
          buttonTitles: ["확인"],
          isRightButtonExist: false) {
            print("left action")
          } rightAction: {
            print("right action")
          }
        
        DSPopup(
          title: "안내",
          description: "진료 과목을 변경하시면 선생님을\n 다시 선택하고 예약을 진행하셔야 합니다\n 그래도 변경하시겠습니까?",
          background: .gray.opacity(0.1),
          cornerRadius: 15,
          buttonTitles: ["확인"],
          isRightButtonExist: false) {
            print("left action")
          } rightAction: {
            print("right action")
          }
      }
    }
  }
}
