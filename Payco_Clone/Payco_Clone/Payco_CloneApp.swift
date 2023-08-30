import SwiftUI

@main
struct Payco_CloneApp: App {
  @State private var selection: Tab = .point
  
  enum Tab {
    case benefit
    case point
    case pay
    case finance
    case whole
  }
  
  var body: some Scene {
    WindowGroup {
      TabView(selection: $selection) {
        EmptyView()
          .tabItem {
            Image(systemName: "percent")
            Text("혜택")
          }
          .tag(Tab.benefit)
        
        PointView()
          .tabItem {
            Image(systemName: "p.circle")
            Text("포인트")
          }
          .tag(Tab.point)

        EmptyView()
          .tabItem {
            Image(systemName: "qrcode.viewfinder")
            Text("결제")
          }
          .tag(Tab.pay)
        
        EmptyView()
          .tabItem {
            Image(systemName: "chart.line.uptrend.xyaxis")
            Text("금융")
          }
          .tag(Tab.finance)
        
        EmptyView()
          .tabItem {
            Image(systemName: "ellipsis")
            Text("전체")
          }
          .tag(Tab.whole)
      }
      .tint(.red)
    }
  }
}
