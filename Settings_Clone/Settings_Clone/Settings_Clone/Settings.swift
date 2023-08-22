import SwiftUI

struct Settings: Identifiable {
    let imageName: String
    let imageColor: Color
    let name: String
    let description: String?
    
    init(
        imageName: String,
        imageColor: Color,
        name: String,
        description: String? = nil
    ) {
        self.imageName = imageName
        self.imageColor = imageColor
        self.name = name
        self.description = description
    }
    
    var id: String {
        return name
    }
}
