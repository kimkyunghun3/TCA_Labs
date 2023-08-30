import SwiftUI

struct AccountView: View {
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
        Image("Payco_Card")
          .resizable()
          .scaledToFit()
          .frame(width: 150, height: 150)
          .shadow(radius: 20, x: 15, y: 15)

        
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
 
    }
  }
}

struct AccountView_Previews: PreviewProvider {
  static var previews: some View {
    AccountView()
    //      .previewLayout(.sizeThatFits)
  }
}
