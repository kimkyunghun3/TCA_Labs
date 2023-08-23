import SwiftUI

struct Settings: Equatable, Identifiable {
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
  
  static let dummyData: [Settings] = [
    .init(imageName: "airplane", imageColor: .orange, name: "에어플레인 모드"),
    .init(imageName: "wifi",
          imageColor: .blue,
          name: "Wi-Fi",
          description: "HOME"),
    .init(imageName: "antenna.radiowaves.left.and.right",
          imageColor: .blue,
            name: "Bluetooth", description: "켬"),
    .init(imageName: "antenna.radiowaves.left.and.right",
          imageColor: .green,
            name: "셀룰러"),
    .init(imageName: "antenna.radiowaves.left.and.right",
          imageColor: .green,
            name: "개인용핫스팟", description: "끔"),
    .init(imageName: "antenna.radiowaves.left.and.right",
          imageColor: .blue,
            name: "VPN", description: "연결 안 됨")
  ]
}
