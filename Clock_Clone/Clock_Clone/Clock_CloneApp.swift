import SwiftUI
import ComposableArchitecture

@main
struct Clock_CloneApp: App {
  @State private var selection: Tab = .worldClock
  
  enum Tab {
    case worldClock
    case alarm
    case stopWatch
    case timer
  }
    var body: some Scene {
        WindowGroup {
          TabView(selection: $selection) {
            WorldClockView(store: Store(initialState: WorldClockFeature.State(clocks: IdentifiedArray(uniqueElements: WorldClock.dummy)), reducer: {
              WorldClockFeature()
            }))
              .tabItem {
                Image(systemName: "globe")
                Text("세계 시계")
              }
              .tag(Tab.worldClock)
            
            ContentView()
              .tabItem {
                Image(systemName: "alarm.fill")
                Text("알람")
              }
              .tag(Tab.alarm)
            
            ContentView()
              .tabItem {
                Image(systemName: "stopwatch.fill")
                Text("스톱워치")
              }
              .tag(Tab.stopWatch)
            
            ContentView()
              .tabItem {
                Image(systemName: "timer")
                Text("타이머")
              }
              .tag(Tab.timer)
          }
          .tint(.orange)
        }
    }
}
