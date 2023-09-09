import SwiftUI

struct DSButton: View {

  let title: String
  var disabled: Bool
  let cornerRadius: CGFloat
  let backgroundColor: Color
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
