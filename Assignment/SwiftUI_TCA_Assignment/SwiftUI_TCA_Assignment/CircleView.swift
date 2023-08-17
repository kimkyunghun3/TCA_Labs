import SwiftUI

struct CircleView: View {
    let dialog: Dialog
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Text(dialog.number)
                    .font(.title)
                Text(dialog.alphabet ?? "")
                    .font(.caption)
                    .bold()
            }
            .frame(width: 90, height: 90)
            .foregroundColor(.black)
            .background(.gray.opacity(0.35))
            .clipShape(Circle())
        }
    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView(dialog: .init(number: "1", alphabet: "abc"), action: {})
    }
}

// 애니메이션
// 크기
// 탭바
