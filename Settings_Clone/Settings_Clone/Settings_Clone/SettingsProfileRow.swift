import SwiftUI

struct SettingsProfileRow: View {
    var body: some View {
        HStack {
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
            Text("kyunghun kim")
                .font(.title3)
            Text("Apple ID, iCloud, 미디어 및 구입 항목")
                .font(.caption2)
        }
    }
}

struct SettingsProfileView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsProfileRow()
            .previewLayout(.sizeThatFits)
            
    }
}
