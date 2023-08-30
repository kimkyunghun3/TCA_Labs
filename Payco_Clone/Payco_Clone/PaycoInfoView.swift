import SwiftUI

struct PaycoInfoView: View {
  
  let gridItem: [GridItem] = Array(repeating: .init(.fixed(150)), count: InfoList.images.count)
  
  var body: some View {
    ZStack(alignment: .top) {
      backgroundView
      title
      .offset(x: -90, y: 50)
      infos
        .offset(x: 40, y: 100)
    }
  }
}

private extension PaycoInfoView {
  
  var backgroundView: some View {
    RoundedRectangle(cornerRadius: 20)
      .foregroundColor(.gray.opacity(0.15))
      .frame(height: 300)
      .padding()
  }
  
  var title: some View {
    HStack {
      Image("Instagram")
        .resizable()
        .scaledToFit()
        .frame(width: 30, height: 30)
      Text("지금 페이코는")
        .font(.title2)
        .bold()
    }
  }
  
  var infos: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      LazyVGrid(columns: gridItem) {
        ForEach(InfoList.images, id: \.self) { info in
          Image(info)
            .resizable()
            .frame(width: 150, height: 150)
            .cornerRadius(15)
            .padding()
        }
      }
    }
  }
}

struct PaycoInfoView_Previews: PreviewProvider {
  static var previews: some View {
    PaycoInfoView()
  }
}
