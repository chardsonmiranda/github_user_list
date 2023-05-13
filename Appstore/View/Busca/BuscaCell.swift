import UIKit
import SDWebImage

class BuscaCell: UITableViewCell {
    
    var user: User! {
        didSet{
            userNomeLabel.text = user.login
            userUrlLabel.text = user.url
            //-- forma usando biblioteca de terceiro
            iconeImageView.sd_setImage(with: URL(string: user.avatarURL), completed: nil)
            
        }
    }
    
    
    let iconeImageView: UIImageView = .iconeImageView()

    let nomeLabel: UILabel = .textLabel(text: "Login:", fontSize: 10, italic: true)
    let userNomeLabel: UILabel = .textLabel(text: "Usuario Nome", fontSize: 18, numberOfLines: 2)

    let urlLabel: UILabel = .textLabel(text: "Link:", fontSize: 10, italic: true)
    let userUrlLabel: UILabel = .textLabel(text: "Usuario URL", fontSize: 14, numberOfLines: 2)
    let obterButtom: UIButton = .obterButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        let nomeStackView = UIStackView(arrangedSubviews: [nomeLabel, userNomeLabel])
        nomeStackView.spacing = 1
        nomeStackView.axis = .vertical

        let urlStackView = UIStackView(arrangedSubviews: [urlLabel, userUrlLabel])
        urlStackView.spacing = 0
        urlStackView.axis = .vertical

        let labelStackView = UIStackView(arrangedSubviews: [nomeStackView, urlStackView])
        labelStackView.spacing = 8
        labelStackView.axis = .vertical

        let headerStackView = UIStackView(arrangedSubviews: [iconeImageView, labelStackView, obterButtom])
        headerStackView.spacing = 12
        headerStackView.alignment = .center

        let globalStackView = UIStackView(arrangedSubviews: [
            headerStackView,
        ])
        
        globalStackView.spacing = 16
        globalStackView.axis = .vertical
        
        addSubview(globalStackView)
        globalStackView.preencherSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}
