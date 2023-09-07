import SwiftUI

struct WorldClockRow: View {
  var item: WorldClock
  
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 5) {
        Text(item.date)
        Text(item.location)
          .font(.title)
      }
      Spacer()
      Text(item.standardDate)
        .font(.title)
    }
    .padding()
  }
}

struct WorldClockRow_Previews: PreviewProvider {
  static var previews: some View {
    WorldClockRow(item: .init(location: "서울", date: "오늘, +0시간", standardDate: "오전 11:06"))
      .previewLayout(.sizeThatFits)
  }
}
