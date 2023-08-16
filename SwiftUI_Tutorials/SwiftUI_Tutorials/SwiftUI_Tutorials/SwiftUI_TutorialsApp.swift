import SwiftUI

@main
struct SwiftUI_TutorialsApp: App {
    var body: some Scene {
        #if os(iOS)
        WindowGroup {
            TabView {
                ContentView()
                    .tabItem {
                        Label("journal", systemImage: "book")
                    }
                
                ContentView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
        }
        #elseif os(macOS)
        WindowGroup {
            AlternativeContentView()
        }
        
        Settings {
            SettingsView()
        }
        #endif
    }
}
