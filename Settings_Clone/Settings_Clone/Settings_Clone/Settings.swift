import SwiftUI

enum CellType {
  case profile
  case airplane
  case detail
  case secondDetail
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
  
  static let first: [Settings] = [
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
  
  static let second: [Settings] = [
    .init(
      imageName: "bell.badge.fill",
      imageColor: .red,
      name: "알림",
      type: .secondDetail
    ),
    .init(
      imageName: "speaker.wave.2.fill",
      imageColor: .red,
      name: "사운드 및 햅틱",
      type: .secondDetail
    ),
    .init(
      imageName: "moon.fill",
      imageColor: .indigo,
      name: "집중 모드",
      type: .secondDetail
    ),
    .init(
      imageName: "hourglass",
      imageColor: .indigo,
      name: "스크린 타임",
      type: .secondDetail
    ),
  ]
}
