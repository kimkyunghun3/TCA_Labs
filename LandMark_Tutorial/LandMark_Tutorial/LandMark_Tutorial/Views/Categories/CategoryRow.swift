import SwiftUI

struct CategoryRow: View {
    var categoryname: String
    var items: [LandMark]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryname)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(items) { landmark in
                        NavigationLink {
                            LandmarkDetail(landmark: landmark)
                        } label: {
                            CategoryItem(landmark: landmark)
                        }
                    }
                }
            }
            .frame(height: 185)
        }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static let landmarks = ModelData().landmarks
    
    static var previews: some View {
        
        CategoryRow(
            categoryname: landmarks[0].category.rawValue,
            items: Array(landmarks.prefix(4))
        )
    }
}
