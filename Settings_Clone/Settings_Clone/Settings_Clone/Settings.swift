import SwiftUI

enum CellType {
  case profile
  case airplane
  case detail
}

struct Settings: Equatable, Identifiable {
  let imageName: String
  let imageColor: Color
  let name: String
  let description: String?
  var type: CellType = .detail
  
  init(
    imageName: String,
    imageColor: Color,
    name: String,
    description: String? = nil,
    type: CellType
  ) {
    self.imageName = imageName
    self.imageColor = imageColor
    self.name = name
    self.description = description
    self.type = type
  }
  
  var id: String {
    return name
  }
  
  static let dummyData: [Settings] = [
    .init(
      imageName: "airplane",
      imageColor: .orange,
      name: "에어플레인 모드",
      type: .airplane
    ),
    .init(
      imageName: "wifi",
      imageColor: .blue,
      name: "Wi-Fi",
      description: "HOME",
      type: .detail
    ),
    .init(
      imageName: "antenna.radiowaves.left.and.right",
      imageColor: .blue,
      name: "Bluetooth",
      description: "켬",
      type: .detail
    ),
    .init(
      imageName: "antenna.radiowaves.left.and.right",
      imageColor: .green,
      name: "셀룰러",
      type: .detail
    ),
    .init(
      imageName: "antenna.radiowaves.left.and.right",
      imageColor: .green,
      name: "개인용핫스팟",
      description: "끔",
      type: .detail
    ),
    .init(
      imageName: "antenna.radiowaves.left.and.right",
      imageColor: .blue,
      name: "VPN",
      description: "연결 안 됨",
      type: .detail
    )
  ]
}
