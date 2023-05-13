import UIKit

class AppDetalheHeaderCell: UICollectionViewCell {
    
    var userDatail: UserDetail? {
        didSet {
            
            if let userDatail = userDatail {
                iconeImageView.sd_setImage(with: URL(string: userDatail.avatarURL ?? ""), completed: nil)
                userNomeLabel.text = userDatail.name
                userLoginLabel.text = userDatail.login
                userEmpresaLabel.text = userDatail.company ?? ""
            }
            
        }
        
    }
    
    let iconeImageView: UIImageView = .iconeImageView(witdth: 128, height: 128)

    let nomeLabel: UILabel = .textLabel(text: "Nome:", fontSize: 10, italic: true)
    let userNomeLabel: UILabel = .textLabel(text: "", fontSize: 18, numberOfLines: 2)

    let loginLabel: UILabel = .textLabel(text: "Login:", fontSize: 10, italic: true)
    let userLoginLabel: UILabel = .textLabel(text: "", fontSize: 14, numberOfLines: 2)

    let empresaLabel: UILabel = .textLabel(text: "Empresa:", fontSize: 10, italic: true)
    let userEmpresaLabel: UILabel = .textLabel(text: "", fontSize: 14, numberOfLines: 2)
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)

        iconeImageView.image = UIImage(named: "icone")
        
        let nomeStackView = UIStackView(arrangedSubviews: [nomeLabel, userNomeLabel])
        nomeStackView.spacing = 1
        nomeStackView.axis = .vertical

        let loginStackView = UIStackView(arrangedSubviews: [loginLabel, userLoginLabel])
        loginStackView.spacing = 1
        loginStackView.axis = .vertical

        let empresaStackView = UIStackView(arrangedSubviews: [empresaLabel, userEmpresaLabel])
        empresaStackView.spacing = 1
        empresaStackView.axis = .vertical

        let labelStackView = UIStackView(arrangedSubviews: [nomeStackView, loginStackView, empresaStackView])
        labelStackView.spacing = 8
        labelStackView.axis = .vertical
        
        let stackView = UIStackView(arrangedSubviews: [iconeImageView, labelStackView])
        stackView.alignment = .center
        stackView.spacing = 12

        addSubview(stackView)
        stackView.preencherSuperview(padding: .init(top: 0, left: 20, bottom: 0, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}


