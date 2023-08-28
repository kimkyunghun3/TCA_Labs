import SwiftUI

struct EventView: View {
  var body: some View {
    Carousel()
  }
}

struct Carousel: View {
  @State var currentTabIndex = 0
  @State var eventLists = EventList.data
  
  var body: some View {
    TabView(selection: $currentTabIndex) {
      ForEach(eventLists) { data in
        
        HStack {
          VStack(alignment: .leading) {
            Spacer()
            
            Text(data.pointCardInstruction)
              .foregroundColor(.white.opacity(0.5))
              .font(.title3)
              .padding(.top, 30)
  
            Spacer()

            Text(data.title)
              .foregroundColor(.white)
              .font(.title2)
              
            Spacer()

            Text(data.date)
              .foregroundColor(.white.opacity(0.5))
              .font(.title2)
              .padding(.bottom, 30)
          }
          .padding(.leading, 30)
          
          Image(systemName: "swift")
            .resizable()
            .frame(width: 150, height: 150)
        }
        .frame(width: 400, height: 250)
        .background(data.color)
        .cornerRadius(30)
        .bold()
      }
    }
    .tabViewStyle(.page(indexDisplayMode: .never))
  }
}

struct EventView_Previews: PreviewProvider {
  static var previews: some View {
    EventView()
  }
}
