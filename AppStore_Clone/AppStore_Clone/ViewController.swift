import UIKit
import FlexLayout
import PinLayout

class ViewController: UIViewController {
  let flexView = UIView()
  let scrollView = UIScrollView()
  let contentView = UIView()
  private let button: UIButton = {
      let button = UIButton()
      button.setTitle("button", for: .normal)
      button.setTitleColor(.systemBlue, for: .normal)
      button.setTitleColor(.blue, for: .highlighted)
      return button
  }()
  
  private let label1: UILabel = {
    let label = UILabel()
    label.text = "label1"
    label.font = .systemFont(ofSize: 20, weight: .regular)
    label.backgroundColor = .lightGray
    label.numberOfLines = 1
    return label
  }()
  private let label2: UILabel = {
    let label = UILabel()
    label.text = "label2"
    label.font = .systemFont(ofSize: 20, weight: .regular)
    label.backgroundColor = .blue
    label.numberOfLines = 1
    return label
  }()
  private let label3: UILabel = {
    let label = UILabel()
    label.text = "label3"
    label.font = .systemFont(ofSize: 20, weight: .regular)
    label.backgroundColor = .green
    label.numberOfLines = 1
    return label
  }()
  let labels = [UILabel]()
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(flexView)
    flexView.addSubview(scrollView)
    flexView.addSubview(button)
    scrollView.addSubview(contentView)
    flexView.backgroundColor = .white
    
    contentView.flex.define { flex in
      labels.forEach { label in
        flex.addItem(label)
          .marginHorizontal(20)
      }
    }
    
//    flexView.flex.justifyContent(.spaceBetween).define {
//      $0.addItem(label1)
//        .marginTop(10)
//      $0.addItem(label2)
//
//      $0.addItem(label3)
//    }
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    flexView.pin.all()
    
    button.pin.horizontally().bottom(view.pin.safeArea).height(50)
    
    scrollView.pin.above(of: button).top().horizontally()
    
    contentView.pin.top().horizontally()
    
    contentView.flex.layout(mode: .adjustHeight)
    scrollView.contentSize = contentView.frame.size
  }
}
