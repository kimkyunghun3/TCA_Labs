import SwiftUI

struct AccountView: View {
  var body: some View {
      
      VStack(alignment: .leading) {
        Text("PAYCO Point")
          .padding(.top, 30)
          .foregroundColor(.white)
          .font(.caption2)
          .bold()
        
        
        Button {
          // Button Detail View 이동
        } label: {
          Text("0 P >")
            .font(.title2)
            .foregroundColor(.white)
            .bold()
        }
        .padding(.top, 20)
        
        Spacer()
        
        Button {
          // 계좌 등록 View 이동
        } label: {
          Text("충전 계좌를 등록해주세요.")
            .font(.caption2)
            .foregroundColor(.yellow)
            .underline()
        }
        .padding(.bottom, 30)
      }
      .padding(.leading, 20)
      .frame(width: 400, height: 200, alignment: .leading)
      .background(Color.purple)
      .cornerRadius(20)
  }
}

struct AccountView_Previews: PreviewProvider {
  static var previews: some View {
    AccountView()
      .previewLayout(.sizeThatFits)
  }
}
