import SwiftUI

struct RewardView: View {
    var body: some View {
      HStack {
        Image(systemName: "bitcoinsign.circle")
        Text("PAYCO 리워드")
        Spacer()
        Text("0 P")
      }
      .frame(height: 50)
      .padding()
      .background(Color.gray.opacity(0.2))
      .cornerRadius(20)
      .bold()
    }
}

struct RewardView_Previews: PreviewProvider {
    static var previews: some View {
        RewardView()
    }
}
