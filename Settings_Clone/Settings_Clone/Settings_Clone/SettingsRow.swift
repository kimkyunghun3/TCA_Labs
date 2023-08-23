import SwiftUI

struct SettingsRow: View {
  var item: Settings
  
  var body: some View {
    HStack(spacing: 15) {
      image
      title
      Spacer()
      description
    }
    .padding(.top, 5)
    .padding(.bottom, 5)
  }
}

private extension SettingsRow {
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
  
  @ViewBuilder
  var description: some View {
    if let description = item.description {
      Text(description)
        .foregroundColor(.gray.opacity(0.9))
        .font(.callout)
    }
  }
}

struct SettingsRow_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      SettingsRow(
        item: Settings(
          imageName: "wifi",
          imageColor: .blue,
          name: "Wi-Fi",
          description: "Eddy",
          type: .detail
        )
      )
      
      SettingsRow(
        item: Settings(
          imageName: "antenna.radiowaves.left.and.right",
          imageColor: .green,
          name: "셀룰러",
          type: .detail
        )
      )
    }
    .previewLayout(.sizeThatFits)
  }
}
