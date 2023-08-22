import SwiftUI
import ComposableArchitecture

struct CallTabView: View {
    @State private var currentTab: Tab = .keypad
    
    enum Tab {
        case favorites
        case recentCall
        case contact
        case keypad
        case voiceOver
    }
    
    var body: some View {

        TabView(selection: $currentTab) {
            TabEmptyView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("즐겨찾기")
                        .font(.body)
                }
                .tag(Tab.favorites)
            
            TabEmptyView()
                .tabItem {
                    Image(systemName: "clock.fill")
                    Text("최근 통화")
                        .font(.body)
                }
                .tag(Tab.recentCall)
            
            TabEmptyView()
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("연락처")
                        .font(.body)
                }
                .tag(Tab.contact)
            
            ContentView()
                .tabItem {
                    Image(systemName: "keyboard")
                    Text("키패드")
                        .font(.body)
                }
                .tag(Tab.keypad)
            
            TabEmptyView()
                .tabItem {
                    Image(systemName: "recordingtape")
                    Text("음성사서함")
                        .font(.body)
                }
                .tag(Tab.voiceOver)
        }
    }
}

struct TabEmptyView: View {
    var body: some View {
        Text("Tab Empty View")
    }
}

struct CallTabView_Previews: PreviewProvider {
    static var previews: some View {
        CallTabView()
    }
}
