import SwiftUI

struct AccountView: View {
  @State private var rotationDegrees: Double = 5
  private let timer = Timer.publish(every: 3, on: .current, in: .default).autoconnect()
  
  private var animation: Animation {
    .default
    .speed(0.2)
    .repeatForever(autoreverses: true)
  }
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 30)
        .frame(height: 200)
        .foregroundColor(Color.red)
        .padding()
      
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
            .underline()
        }
        .padding(.bottom, 20)
      }
      .padding(.trailing, 250)
      
      VStack {
        Image("card")
          .resizable()
          .scaledToFit()
          .frame(width: 150, height: 150)
          .shadow(radius: 20, x: 15, y: 15)
          .rotation3DEffect(.degrees(rotationDegrees), axis: (x: 0.1, y: -0.5, z: 0.0))
          .animation(.spring(response: 2, dampingFraction: 0.1), value: rotationDegrees)
        
        Button {
          
        } label: {
          Text("카드관리")
            .font(.subheadline)
        }
        
        .frame(width: 80, height: 40)
        .foregroundColor(.white.opacity(0.8))
        .background(Color.white.opacity(0.3))
        .cornerRadius(15)
        .padding(.leading, 50)
      }
      .padding(.leading, 200)
      .padding(.bottom, 50)
      .onReceive(timer) { _ in
        rotationDegrees = rotationDegrees == 5 ? -5 : 5
      }
    }
  }
}

struct AccountView_Previews: PreviewProvider {
  static var previews: some View {
    AccountView()
    //      .previewLayout(.sizeThatFits)
  }
}