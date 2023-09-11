import SwiftUI

struct DSButton: View {
  /// 타이틀
  let title: String
  /// disable 유무
  var disabled: Bool
  /// cornerRadius
  let cornerRadius: CGFloat
  /// 배경색
  let backgroundColor: Color
  /// Tap action
  var tapAction: () -> Void

  init(
    title: String,
    disalbed: Bool = false,
    backgroundColor: Color,
    cornerRadius: CGFloat = 15,
    tapAction: @escaping () -> Void = {}
  ) {
    self.title = title
    self.disabled = disalbed
    self.backgroundColor = backgroundColor
    self.cornerRadius = cornerRadius
    self.tapAction = tapAction
  }

  var body: some View {
    Button {
      tapAction()
    } label: {
      Text(title)
        .frame(width: 130, height: 52)
        .background(backgroundColor)
        .foregroundColor(.white)
        .cornerRadius(cornerRadius)
    }
    .disabled(disabled)
  }
}

struct DSButton_Previews: PreviewProvider {
  static var previews: some View {
    DSButton(title: "취소", backgroundColor: Color.gray.opacity(0.5)) {
      print("Tap")
    }
  }
}
