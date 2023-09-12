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

enum WorkldClockDev: Equatable, Identifiable, CaseIterable {
  case 가보로네
  case 괌
  case 과나후아또
  case 나소
  case 나이로비
  case 노바토
  case 녹스
  case 다롄
  case 다카르
  case 도슨시티
  case 두바이
  case 라사
  case 레온
  case 마닐라
  case 마렝고
  case 바르샤바
  case 발레이오
  case 산살바도르
  case 산타이사벨
  case 산티아고
  case 아덴
  case 아순시온
  case 캘거리
  case 케레타로
  case 톨루카
  case 헤브론
  case 휴스턴
  case 힐즈버그
  case 호놀룰루
  case 헤밀턴
  case 헬싱키
  case 호치민시티
  case 홍콩특별행정구

  var id: String {
    return String(describing: self)
  }

  var name: String {
    return String(describing: self)
  }

  var time: String {
    return "8:10"
  }

  var country: String {
    switch self {
    case .가보로네:
      return "보츠와나"
    case .괌:
      return "괌"
    case .과나후아또:
      return "멕시코"
    case .나소:
      return "바하마"
    case .나이로비:
      return "캐나다"
    case .노바토:
      return "미국"
    case .녹스:
      return "미국"
    case .다롄:
      return "중국 본토"
    case .다카르:
      return "세네갈"
    case .도슨시티:
      return "캐나다"
    case .두바이:
      return "아랍 에밀리트 연합국"
    case .라사:
      return "중국 본토"
    case .레온:
      return "멕시코"
    case .마닐라:
      return "필리핀"
    case .마렝고:
      return "미국"
    case .바르샤바:
      return "폴란드"
    case .발레이오:
      return "미국"
    case .산살바도르:
      return "엘살바도르"
    case .산타이사벨:
      return "멕시코"
    case .산티아고:
      return "칠레"
    case .아덴:
      return "예맨"
    case .아순시온:
      return "파라과이"
    case .캘거리:
      return "캐나다"
    case .케레타로:
      return "미국"
    case .톨루카:
      return ""
    case .헤브론:
      return "미국"
    case .휴스턴:
      return "미국"
    case .힐즈버그:
      return "미국"
    case .호놀룰루:
      return "버뮤다"
    case .헤밀턴:
      return "핀란드"
    case .헬싱키:
      return "몽골"
    case .호치민시티:
      return "베트남"
    case .홍콩특별행정구:
      return "중국"
    }
  }
}

