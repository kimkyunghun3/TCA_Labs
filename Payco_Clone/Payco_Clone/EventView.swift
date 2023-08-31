import SwiftUI

struct EventView: View {
  var body: some View {
    Carousel()
      .frame(height: 200)
      .frame(maxWidth: .infinity)
  }
}

struct CarouselView<Content: View>: View {
  typealias PageIndex = Int
  
  let pageCount: Int
  let visibleEdgeSpace: CGFloat
  let spacing: CGFloat
  let content: (PageIndex) -> Content
  private let timer = Timer.publish(every: 3, on: .main, in: .default).autoconnect()
  
  @GestureState var dragOffset: CGFloat = 0
  @State var currentIndex: Int = 0
  
  init(
    pageCount: Int,
    visibleEdgeSpace: CGFloat,
    spacing: CGFloat,
    @ViewBuilder content: @escaping (PageIndex) -> Content
  ) {
    self.pageCount = pageCount
    self.visibleEdgeSpace = visibleEdgeSpace
    self.spacing = spacing
    self.content = content
  }
  
  var body: some View {
    GeometryReader { proxy in
      let baseOffset: CGFloat = spacing + visibleEdgeSpace
      let pageWidth: CGFloat = proxy.size.width - (visibleEdgeSpace + spacing) * 2
      let offsetX: CGFloat = baseOffset + CGFloat(currentIndex) * -pageWidth + CGFloat(currentIndex) * -spacing + dragOffset
      
      HStack(spacing: spacing) {
        ForEach(1..<pageCount + 1, id: \.self) { pageIndex in
          self.content(pageIndex)
            .frame(
              width: pageWidth,
              height: proxy.size.height
            )
        }
        .contentShape(Rectangle())
      }
      .offset(x: offsetX)
      .animation(.default, value: offsetX)
      .gesture(
        DragGesture()
          .updating($dragOffset) { value, out, _ in
            out = value.translation.width
          }
          .onEnded { value in
            let offsetX = value.translation.width
            let progress = -offsetX / pageWidth
            let increment = Int(progress.rounded())
            
            currentIndex = max(min(currentIndex + increment, pageCount - 1), 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
              if currentIndex == 8 { currentIndex = 0 }
            }
          }
      )
      .onChange(of: currentIndex) { _ in
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
          if currentIndex == 8 { currentIndex = 0 }
          if currentIndex == 0 { currentIndex = 8 }
        }
      }
      .onReceive(timer) { _ in
        currentIndex += 1
      }
    }
  }
}

struct Carousel: View {
  @State var currentTabIndex = 0
  @State var eventLists = BrandList.data
  
  var body: some View {
    CarouselView(pageCount: eventLists.count, visibleEdgeSpace: 8, spacing: 5) { index in
      ForEach(1..<eventLists.count - 1, id: \.self) { data in
        HStack {
          VStack(alignment: .leading) {
            Text(eventLists[data].pointCardInstruction)
              .foregroundColor(.white.opacity(0.5))
              .font(.body)
              .padding(.top, 25)
            
            Text(eventLists[data].title)
              .foregroundColor(.white)
              .font(.title2)
              .padding(.top, 10)
              .padding(.bottom, 10)
            
            Text(eventLists[data].date)
              .foregroundColor(.white.opacity(0.5))
              .font(.body)
              .padding(.bottom, 30)
            
          }
          .frame(alignment: .leading)
          .frame(maxWidth: .infinity)

          Image(eventLists[data].eventImage)
            .resizable()
            .scaledToFit()
            .frame(width: 150, height: 200)
        }
        .frame(height: 200)
        .background(eventLists[data].color)
        .cornerRadius(30)
        .bold()
      }
    }
  }
}

struct EventView_Previews: PreviewProvider {
  static var previews: some View {
    EventView()
  }
}
