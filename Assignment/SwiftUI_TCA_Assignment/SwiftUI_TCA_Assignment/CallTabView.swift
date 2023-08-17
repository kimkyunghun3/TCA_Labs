import SwiftUI

struct CallTabView: View {
    var body: some View {

        TabView() {
            Text("")
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("즐겨찾기")
                        .font(.body)
                }
            
            Text("")
                .tabItem {
                    Image(systemName: "clock.fill")
                    Text("최근 통화")
                        .font(.body)
                }
            
            Text("")
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("연락처")
                        .font(.body)
                }
            
            Text("")
                .tabItem {
                    Image(systemName: "keyboard")
                    Text("키패드")
                        .font(.body)
                }
            
            Text("")
                .tabItem {
                    Image(systemName: "recordingtape")
                    Text("음성사서함")
                        .font(.body)
                }
        }
        .frame(height: 50)
    }
}

struct CallTabView_Previews: PreviewProvider {
    static var previews: some View {
        CallTabView()
    }
}
