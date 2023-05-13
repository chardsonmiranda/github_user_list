import UIKit

class AppDetalheBodyReposCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    let cellId = "cellId"
    
    var userDatailRepos: [UserRepoElement]? {
        didSet {
            reposTableView.reloadData()
        }
    }
    
    let reposTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .gray
        return tableView
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        reposTableView.delegate = self
        reposTableView.dataSource = self
        reposTableView.register(ReposCell.self, forCellReuseIdentifier: cellId)

        addSubview(reposTableView)
        reposTableView.preencherSuperview(padding: .init(top: 0, left: 20, bottom: 0, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDatailRepos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let repo = userDatailRepos?[indexPath.item]

        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ReposCell
        cell.userRepositorioLabel.text = repo?.name
        cell.userRepositorioFullLabel.text = repo?.fullName
        cell.userRepositorioDescricaoLabel.text = repo?.description
        return cell
    }
}

class ReposCell: UITableViewCell {
    
    let repositorioLabel: UILabel = .textLabel(text: "Repositório:", fontSize: 10, italic: true)
    let userRepositorioLabel: UILabel = .textLabel(text: "", fontSize: 18, numberOfLines: 2)

    let repositorioFullLabel: UILabel = .textLabel(text: "Repositório URL:", fontSize: 10, italic: true)
    let userRepositorioFullLabel: UILabel = .textLabel(text: "", fontSize: 14, numberOfLines: 0)

    let repositorioDescricaoLabel: UILabel = .textLabel(text: "Descrição:", fontSize: 10, italic: true)
    let userRepositorioDescricaoLabel: UILabel = .textLabel(text: "", fontSize: 14, numberOfLines: 0)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        let repositorioStackView = UIStackView(arrangedSubviews: [repositorioLabel, userRepositorioLabel])
        repositorioStackView.spacing = 1
        repositorioStackView.axis = .vertical

        let repositorioFullStackView = UIStackView(arrangedSubviews: [repositorioFullLabel, userRepositorioFullLabel])
        repositorioFullStackView.spacing = 1
        repositorioFullStackView.axis = .vertical

        let repositorioDescricaoStackView = UIStackView(arrangedSubviews: [repositorioDescricaoLabel, userRepositorioDescricaoLabel])
        repositorioDescricaoStackView.spacing = 1
        repositorioDescricaoStackView.axis = .vertical

        let stackView = UIStackView(arrangedSubviews: [repositorioStackView, repositorioFullStackView, repositorioDescricaoStackView])
        stackView.spacing = 8
        stackView.axis = .vertical

        addSubview(stackView)
        stackView.preencherSuperview(padding: .init(top: 20, left: 10, bottom: 20, right: 10))
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

