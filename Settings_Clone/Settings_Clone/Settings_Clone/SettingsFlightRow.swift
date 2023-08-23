import SwiftUI

struct SettingsFlightRow: View {
  var item: Settings
  @State private var isOn: Bool = false
  
  var body: some View {
    HStack(spacing: 15) {
      image
      title
      Spacer()
      toggle
    }
    .padding(.top, 5)
    .padding(.bottom, 5)
  }
}

private extension SettingsFlightRow {
  var image: some View {
    Image(systemName: item.imageName)
      .resizable()
      .scaledToFit()
      .frame(width: 20, height: 20)
      .foregroundColor(.white)
      .padding(5)
      .background(item.imageColor)
      .cornerRadius(5)
  }
  
  var title: some View {
    Text(item.name)
      .font(.callout)
  }
  
  var toggle: some View {
    Toggle(isOn: $isOn) {
      
    }
  }
}

struct SettingsFlightRow_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      SettingsFlightRow(
        item: Settings(
          imageName: "airplane",
          imageColor: .orange,
          name: "에어플레인 모드"
        )
      )
    }
    .previewLayout(.sizeThatFits)
  }
}
