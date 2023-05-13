import UIKit

extension UIButton {
    
    static func obterButton() -> UIButton{
        
        let button = UIButton(type: .system)
        button.setTitle("ver", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = .tertiarySystemGroupedBackground
        button.size(size: .init(width: 80, height: 32))
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        
        return button
    }
    
}
