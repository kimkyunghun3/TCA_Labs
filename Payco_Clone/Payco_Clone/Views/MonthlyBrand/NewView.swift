import SwiftUI

struct NewView: View {
  var body: some View {
    VStack(spacing: 0) {
      HStack(spacing: 0) {
        Text("✨")
          .font(.caption2)
        
        Text("NEW")
          .bold()
          .font(.caption2)
          .foregroundColor(.white)
          .frame(alignment: .leading)
      }

      .padding(.horizontal, 5)
      .padding(.vertical, 5)
      .background(.black)
      .clipShape(Capsule())
      
      Triangle()
        .frame(width: 7, height: 4)
        .offset(x: 5)
    }
  }
}

struct Triangle: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    path.move(to: CGPoint(x: rect.midX, y: rect.minY))
    path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
    path.addLine(to: CGPoint(x: -rect.maxX, y: -rect.maxY))
    path.addLine(to: CGPoint(x: -rect.midX, y: rect.minY))
    
    return path
  }
}
struct NewView_Previews: PreviewProvider {
  static var previews: some View {
    NewView()
  }
}
