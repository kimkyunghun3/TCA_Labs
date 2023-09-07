import Foundation

struct WorldClock: Equatable, Identifiable {
  let location: String
  let date: String
  let standardDate: String
  
  var id: String {
    return location
  }
  
  static let dummy: [WorldClock] = [
    .init(location: "서울", date: "0시간", standardDate: "오전 11:07"),
    .init(location: "스위스", date: "+7시간", standardDate: "오후 5:07"),
    .init(location: "미국", date: "-7시간", standardDate: "오전 4:07"),
  ]
}
