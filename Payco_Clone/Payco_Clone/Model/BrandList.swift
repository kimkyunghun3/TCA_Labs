import Foundation
import SwiftUI

enum BrandList: String, Identifiable {
  case gmarket = "지마켓"
  case musinsa = "무신사"
  case industrialBank = "IBK"
  case gs25 = "GS25"
  case megaCoffe = "메가MGC커피"
  case akPlaza = "AK플라자"
  case eduwill = "에듀윌"
  case twentyNineCM = "29CM"
  case gsTheFresh = "GS 더프레시"
  
  var id: String {
    return self.rawValue
  }
  
  var pointCardInstruction: String {
    switch self {
    case .gmarket: return "PAYCO 포인트 카드 결제 시"
    case .musinsa: return "PAYCO 포인트 결제 시"
    case .industrialBank: return "PAYCO 포인트 결제 시"
    case .gs25: return "PAYCO 포인트 결제 시"
    case .megaCoffe: return "PAYCO 포인트 결제 시"
    case .akPlaza: return "PAYCO 포인트 결제 시"
    case .eduwill: return "PAYCO 포인트 결제 시"
    case .twentyNineCM: return "PAYCO 포인트 결제 시"
    case .gsTheFresh: return "PAYCO 포인트 결제 시"
    }
  }
  
  var title: String {
    switch self {
    case .gmarket:
      return self.rawValue + "에서 결제하면\n1,000P 페이백!"
    case .musinsa:
      return self.rawValue + "에서\n한도없는 2% 할인!"
    case .industrialBank:
      return self.rawValue + "계좌 연동하면\n 최대 15,000P 혜택"
    case .gs25:
      return self.rawValue
    case .megaCoffe:
      return self.rawValue
    case .akPlaza:
      return self.rawValue
    case .eduwill:
      return self.rawValue
    case .twentyNineCM:
      return self.rawValue
    case .gsTheFresh:
      return self.rawValue
    }
  }
  
  var date: String {
    switch self {
    case .gmarket, .musinsa,
        .industrialBank, .gs25,
        .megaCoffe, .akPlaza,
        .eduwill, .twentyNineCM, .gsTheFresh:
      return "~ 8.31 까지"
    }
  }
  
  var color: Color {
    switch self {
    case .gmarket: return .green
    case .musinsa: return .black
    case .industrialBank: return .indigo
    case .gs25: return .blue
    case .megaCoffe: return .yellow
    case .akPlaza: return .mint
    case .eduwill:  return .orange
    case .twentyNineCM: return .black
    case .gsTheFresh: return .teal
    }
  }
  
  var image: String {
    switch self {
    case .gmarket: return "G_market"
    case .musinsa: return "Musinsa"
    case .industrialBank: return "IBK"
    case .gs25: return "GS_25"
    case .megaCoffe: return "Starbucks"
    case .akPlaza: return "AKPlaza"
    case .eduwill: return "Eduwill"
    case .twentyNineCM: return "twentyNineCM"
    case .gsTheFresh: return "GS_THE_FRESH"
    }
  }
  
  var condition: String {
    switch self {
    case .gmarket:
      return "Gmarket 결제 시"
    case .musinsa:
      return "무신사 결제 시"
    case .industrialBank:
      return "IBK 계좌 페키오 충전 시"
    case .gs25:
      return "GS25 결제 시 건당"
    case .megaCoffe:
      return "스타벅스 결제 시"
    case .akPlaza:
      return "AK 플라자 충전 시"
    case .eduwill:
      return "에듀윌 결제 시"
    case .twentyNineCM:
      return "29CM 충전시"
    case .gsTheFresh:
      return "GS the fresh 결제 시"
    }
  }
  
  var description: String {
    switch self {
    case .gmarket:
      return "2% 할인"
    case .musinsa, .twentyNineCM:
      return "2% 할인"
    case .industrialBank:
      return "5,000P 적립"
    case .gs25, .gsTheFresh, .megaCoffe, .akPlaza:
      return "5% 할인"
    case .eduwill:
      return "5,000원 할인"
    }
  }
}

extension BrandList {
  static let data: [BrandList] = [
    .gmarket, .musinsa, .industrialBank,
    .gs25, .megaCoffe, .akPlaza,
    .eduwill, .twentyNineCM, .gsTheFresh
  ]
}
