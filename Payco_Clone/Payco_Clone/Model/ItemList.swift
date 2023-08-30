import Foundation

enum ItemList: String, CaseIterable, Identifiable {
  case transfer = "내계좌로 송금"
  case charge = "충전"
  case transform = "전환"
  case history = "이용내역"
  case monthlyBrand = "이달의 브랜드"
  case pointGift = "포인트 선물"
  case withdrawATM = "ATM 출금"
  case incomDeduction = "소득공제"
  
  var id: String {
    return self.rawValue
  }
  
  var imageName: String {
    switch self {
    case .transfer: return "Transfer"
    case .charge: return  "Charging"
    case .transform: return "Conversion"
    case .history: return "History"
    case .monthlyBrand: return "Brand"
    case .pointGift: return "Gift"
    case .withdrawATM: return "ATM"
    case .incomDeduction: return "TaxDeduction"
    }
  }
}

extension ItemList {
  static let itemList: [ItemList] = [
    .transfer, .charge, .transform, .history, .monthlyBrand, .pointGift, .withdrawATM, .incomDeduction
    ]
}
