import SwiftUI

@main
struct SwiftUI_Dev_TutorialsApp: App {
  @State private var scrums = DailyScrum.sampleData
  
  var body: some Scene {
    WindowGroup {
      ScrumsView(scrums: $scrums)
    }
  }
}
