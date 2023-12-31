import SwiftUI

struct SearchFeatureView: View {
  @State private var isHidden = false
  
  var body: some View {
    ZStack(alignment: .trailing) {
      Text(attributedString)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.black.opacity(0.9))
      
      Button {
       isHidden = true
      } label: {
        Image(systemName: "xmark")
          .foregroundColor(.gray.opacity(0.6))
      }
      .padding(.trailing, 25)
    }
    
    .opacity(isHidden ? 0 : 1)
    .frame(height: 50)
  }
}

private extension SearchFeatureView {
  var attributedString: AttributedString {
    var text: AttributedString = "이 기능 어딨지? 검색해서 바로 찾기🔍"
    let range = text.range(of: "검색해서 바로 찾기")!
    
    text[range].foregroundColor = .yellow
    
    return text
  }
}

struct SearchFeatureView_Previews: PreviewProvider {
  static var previews: some View {
    SearchFeatureView()
      .previewLayout(.sizeThatFits)
  }
}
