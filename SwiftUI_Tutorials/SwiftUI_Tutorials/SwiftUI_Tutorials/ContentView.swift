import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hamlet")
                .font(.largeTitle)
            Text("by william Shakespeare")
                .font(.caption)
                .italic()
            
            Label("Favorite Books", systemImage: "books.vertical")
                .labelStyle(.titleAndIcon)
                .font(.largeTitle)
            
            HStack {
                Image(systemName: "folder.badge.plus")
                Image(systemName: "heart.circle.fill")
                Image(systemName: "alarm")
                
                
            }
            .symbolRenderingMode(.multicolor)
            .font(.largeTitle)
            
            Image(systemName: "swift")
                .resizable()
                .scaledToFit()
            
            HStack {
                Rectangle()
                    .foregroundColor(.blue)
                
                Circle()
                    .foregroundColor(.orange)
                
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .foregroundColor(.green)
            }
            .aspectRatio(3.0, contentMode: .fit)
        }
        .padding()
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
