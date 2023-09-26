import UIKit
import FlexLayout
import PinLayout

final class ViewController: UIViewController {
  
  private lazy var tableView: UITableView = {
    let v = UITableView(frame: .zero)
    
    return v
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    self.title = "심장"
  }
}
