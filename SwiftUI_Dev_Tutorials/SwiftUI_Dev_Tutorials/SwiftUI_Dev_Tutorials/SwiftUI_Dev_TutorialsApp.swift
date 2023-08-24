import SwiftUI

@main
struct SwiftUI_Dev_TutorialsApp: App {
    var body: some Scene {
        WindowGroup {
          ScrumsView(scrums: DailyScrum.sampleData)
        }
    }
}
