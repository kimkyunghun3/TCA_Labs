import SwiftUI

struct AccountView: View {
  @State private var rotationDegrees: Double = 5
  
  private var animation: Animation {
    .default
    .speed(0.2)
    .repeatForever(autoreverses: true)
  }
  var body: some View {
    ZStack {
      LinearGradient(colors: [.orange.opacity(0.9), .red], startPoint: .leading, endPoint: .trailing)
        .overlay {
          VStack(alignment: .leading) {
            Text("PAYCO Point")
              .foregroundColor(.white)
              .font(.body)
              .bold()
              .padding(.vertical, 5)
            
            Button {
              // Button Detail View 이동
            } label: {
              Text("309 P >")
                .font(.title)
                .foregroundColor(.white)
                .bold()
            }
            .padding(.bottom, 30)
            
            Button {
              // 계좌 등록 View 이동
            } label: {
              Text("토스뱅크 (9920)")
                .font(.caption)
                .foregroundColor(.yellow)
              // markdown
                .underline()
            }
            .padding(.bottom, 20)
          }
          .padding(.trailing, 250)
          
          
          Button {
            
          } label: {
            Text("카드관리")
              .font(.caption)
              .frame(width: 70, height: 30)
              .foregroundColor(.white.opacity(0.7))
              .background(Color.white.opacity(0.2))
              .cornerRadius(10)
          }
          .frame(height: 100)
          .padding(.leading, 270)
          .padding(.bottom, -200)
          .onAppear {
            withAnimation(animation) {
              rotationDegrees = rotationDegrees == 5 ? -5 : 5
            }
          }
        }
        .frame(height: 200)
        .cornerRadius(20)
        .padding()
      
      Image("card")
        .resizable()
        .aspectRatio(1.0, contentMode: .fit)
        .frame(width: 150)
        .shadow(radius: 20, x: 15, y: 15)
        .rotation3DEffect(.degrees(rotationDegrees), axis: (x: 0.1, y: -0.5, z: 0.0))
        .animation(.linear(duration: 1).repeatForever(autoreverses: true), value: rotationDegrees)
        .padding(.leading, 190)
        .padding(.bottom, 100)
        .frame(alignment: .trailing)
    }
  }
}

struct AccountView_Previews: PreviewProvider {
  static var previews: some View {
    AccountView()
    //      .previewLayout(.sizeThatFits)
  }
}
