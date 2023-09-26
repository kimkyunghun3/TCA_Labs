import UIKit
import FlexLayout
import PinLayout

final class NoDataCell: UITableViewCell {
  static let id = "NoDataCell"
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func attribute() {
    
  }
  
  private func layout() {
    
  }
}
