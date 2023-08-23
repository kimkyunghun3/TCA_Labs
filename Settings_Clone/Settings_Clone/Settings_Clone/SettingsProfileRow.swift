import SwiftUI

struct SettingsProfileRow: View {
  var body: some View {
    HStack(spacing: 20) {
      profileImage
      Descriptions
    }
  }
}

private extension SettingsProfileRow {
  var profileImage: some View {
    Image("profile")
      .resizable()
      .scaledToFit()
      .frame(width: 50, height: 50)
      .clipShape(Circle())
  }
  
  var Descriptions: some View {
    VStack(alignment: .leading) {
      Text("김경훈")
        .font(.title2)
      Text("Apple ID, iCloud, 미디어 및 구입 항목")
        .font(.subheadline)
    }
  }
}

struct SettingsProfileView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsProfileRow()
      .previewLayout(.sizeThatFits)
    
  }
}
