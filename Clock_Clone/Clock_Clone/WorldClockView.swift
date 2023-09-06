import SwiftUI

struct WorldClockView: View {
  var body: some View {
    NavigationStack {
      List {
        WorldClockRow()
      }
      .navigationTitle("세계 시계")
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button("편집") {
            // 편집
          }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            // 추가버튼
          } label: {
            Image(systemName: "plus")
          }
        }
      }
      .tint(.orange)
    }
  }
}


struct WorldClockView_Previews: PreviewProvider {
  static var previews: some View {
    WorldClockView()
  }
}
