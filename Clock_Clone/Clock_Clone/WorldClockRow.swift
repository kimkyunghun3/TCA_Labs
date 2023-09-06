import SwiftUI

struct WorldClockRow: View {
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 5) {
        Text("오늘, +0시간")
        Text("서울")
          .font(.title)
      }
      Spacer()
      Text("오후 4:16")
        .font(.title)
    }
    .padding()
  }
}

struct WorldClockRow_Previews: PreviewProvider {
  static var previews: some View {
    WorldClockRow()
      .previewLayout(.sizeThatFits)
  }
}
