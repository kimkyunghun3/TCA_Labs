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

struct City: Equatable, Identifiable {
  let name: String
  let country: String?
  
  init(name: String, country: String? = "") {
    self.name = name
    self.country = country
  }

  var id: String {
    return name
  }
  
  static let data: [City] = [
    .init(name: "가보로네", country: "보츠와나"),
    .init(name: "괌", country: "괌"),
    .init(name: "과나후아또", country: "멕시코"),
    .init(name: "나소", country: "바하마"),
    .init(name: "나이로비", country: "케냐"),
    .init(name: "노바토", country: "미국"),
    .init(name: "녹스", country: "미국"),
    .init(name: "다롄", country: "중국 본토"),
    .init(name: "다카르", country: "세네갈"),
    .init(name: "도슨 시티", country: "캐나다"),
    .init(name: "두바이", country: "아랍 에밀리트 연합국"),
    .init(name: "라사", country: "중국 본토"),
    .init(name: "레온", country: "멕시코"),
    .init(name: "마닐라", country: "필리핀"),
    .init(name: "마렝고", country: "미국"),
    .init(name: "바르샤바", country: "폴란드"),
    .init(name: "발레이오", country: "미국"),
    .init(name: "산살바도르", country: "엘살바도르"),
    .init(name: "산타 이사벨", country: "멕시코"),
    .init(name: "산티아고", country: "칠레"),
    .init(name: "아덴", country: "예맨"),
    .init(name: "아순시온", country: "파라과이"),
    .init(name: "캘거리", country: "캐나다"),
    .init(name: "케레타로", country: "멕시코"),
    .init(name: "톨루카", country: "멕시코"),
    .init(name: "헤브론"),
    .init(name: "휴스턴", country: "미국"),
    .init(name: "힐즈버그", country: "미국"),
    .init(name: "호놀룰루", country: "미국"),
    .init(name: "헤밀턴", country: "버뮤다"),
    .init(name: "헬싱키", country: "핀란드"),
    .init(name: "호브드", country: "몽골"),
    .init(name: "호치민 시티", country: "베트남"),
    .init(name: "홍콩 특별행정구", country: "중국")
  ]
}
