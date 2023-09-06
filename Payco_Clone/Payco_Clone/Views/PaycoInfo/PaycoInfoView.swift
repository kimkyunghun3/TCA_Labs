import SwiftUI

struct PaycoInfoView: View {
  
  var body: some View {
    ZStack {
      VStack {
        title
          .frame(height: 50)
        infos
      }
      .background(backgroundView)
    }
    .frame(height: 250)
  }
}

private extension PaycoInfoView {
  
  var backgroundView: some View {
    RoundedRectangle(cornerRadius: 20)
      .foregroundColor(Color.gray.opacity(0.05))
      .frame(height: 200)
      .padding()
  }
  
  var title: some View {
    HStack {
      Image("Instagram")
        .resizable()
        .scaledToFit()
        .frame(width: 20, height: 20)
      Text("지금 페이코는")
        .font(.body)
        .bold()
    }
    .offset(x: 30)
    .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  var infos: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      LazyHStack {
        Rectangle()
          .fill(.clear)
          .frame(width: 30)
        
        ForEach(InfoList.images, id: \.self) { info in
          Image(info)
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 100)
            .cornerRadius(15)
        }
      }
      .frame(height: 100)
      .padding(.horizontal, -5)
    }
  }
}

struct PaycoInfoView_Previews: PreviewProvider {
  static var previews: some View {
    PaycoInfoView()
  }
}
