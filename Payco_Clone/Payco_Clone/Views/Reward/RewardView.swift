import SwiftUI

struct RewardView: View {
    var body: some View {
      HStack {
        Image("Dollar")
          .resizable()
          .scaledToFit()
          .frame(width: 20, height: 20)
        Text("PAYCO 리워드")
        Spacer()
        Text("0 P")
      }
      .frame(height: 50)
      .padding()
      .background(Color.gray.opacity(0.05))
      .cornerRadius(30)
      .bold()
    }
}

struct RewardView_Previews: PreviewProvider {
    static var previews: some View {
        RewardView()
    }
}
