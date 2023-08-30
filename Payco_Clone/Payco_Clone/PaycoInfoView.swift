import SwiftUI

struct PaycoInfoView: View {
  
  let gridItem: [GridItem] = Array(repeating: .init(.fixed(150)), count: InfoList.images.count)
  
  var body: some View {
    ZStack(alignment: .top) {
      HStack {
        Image("Instagram")
          .resizable()
          .scaledToFit()
          .frame(width: 30, height: 30)
        Text("지금 페이코는")
          .font(.title2)
          .bold()
      }
      .offset(x: -90, y: -10)
      infos
        .offset(y: 50)
//        .padding()
    }
//    .frame(height: 250)
//    .padding(30)
//    .background(Color.gray.opacity(0.15))
//    .cornerRadius(20)
//    .padding()
  }
}

private extension PaycoInfoView {
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
