import SwiftUI

extension DSButton {
  func background(_ color: Color) -> Self {
    var v = self
    v.backgroundColor = color
    return v
  }
  
  func cornerRadius(_ value: CGFloat) -> Self {
    var v = self
    v.cornerRadius = value
    return v
  }
  
  func foreground(_ color: Color) -> Self {
    var v = self
    v.foregroundColor = color
    return v
  }
}

struct DSButton: View {
  @Environment(\.isEnabled) var isEnabled
  /// 타이틀
  let title: String
  /// cornerRadius
  var cornerRadius: CGFloat = 15
  /// 글자색
  var foregroundColor: Color = .white
  /// 배경색
  var backgroundColor: Color = .gray.opacity(0.5)
  /// Tap action
  var tapAction: () -> Void

  init(
    title: String,
    tapAction: @escaping () -> Void = {}
  ) {
    self.title = title
    self.tapAction = tapAction
  }

  var body: some View {
    Button {
      tapAction()
    } label: {
      Text(title)
        .frame(width: 130, height: 52)
        .background(backgroundColor)
        .foregroundColor(foregroundColor)
        .cornerRadius(cornerRadius)
    }
    .overlay {
      if isEnabled == false {
        Color.gray.opacity(0.5)
      }
    }
  }
}

struct DSButton_Previews: PreviewProvider {
  static var previews: some View {
    DSButton(title: "취소") {
      print("Tap")
    }
    .background(.gray.opacity(0.5))
  }
}
