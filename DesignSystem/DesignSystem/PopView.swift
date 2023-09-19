import SwiftUI

struct PopView: View {
    var body: some View {
      Button("버튼") {
        

      }
      .popup(title: "의료진안내", description: "해보세요", leftAction: {
        
      }, rightAction: {
        print("right")
      }, buttonTitles: ["취소", "확인"])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      PopView()
    }
}
