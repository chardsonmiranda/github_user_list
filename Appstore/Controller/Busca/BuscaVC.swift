import UIKit

class BuscaVC: UITableViewController, UISearchBarDelegate {
    
    let cellId = "cellId"
    var callBack: ((User) -> ())?

    let searchController = UISearchController(searchResultsController: nil)
    
    let viewInd: UIView = {
        let view = UIView()
        
        let screenSize = UIScreen.main.bounds.size
        view.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        view.backgroundColor = .gray.withAlphaComponent(0.4)

        return view
    }();

    let activityIndicatorView: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .large)
        ai.color = UIColor.darkGray
        ai.startAnimating()
        ai.hidesWhenStopped = true
        return ai
    } ()
    
    let messageLabel: UILabel = {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 200))
        messageLabel.text = ""
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        return messageLabel
    } ()

    var users: [User] = []
    var usersList: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(BuscaCell.self, forCellReuseIdentifier: cellId)
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(callPullToRefresh), for: .valueChanged)

        self.addIndicatorView()
        self.configurarSearchBar()
        self.findUsers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func configurarSearchBar() {
        
        navigationItem.searchController = self.searchController
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Busque por login"
        self.searchController.searchBar.delegate = self
    }

    func addIndicatorView() {
        viewInd.addSubview(activityIndicatorView)
        activityIndicatorView.centralizasSuperview()
        
        view.addSubview(viewInd)
        viewInd.bringSubviewToFront(self.view)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchUsers(texto: searchText)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.usersList = users
        self.tableView.reloadData()
    }
    
    @objc func callPullToRefresh(){
        self.findUsers()
    }
}

extension BuscaVC{
    func findUsers (){
        self.messageLabel.text = ""

        BuscaService.shared.buscaUsers() { (users, err) in

            if (err != nil) {
                self.messageLabel.text = "Ops... Algo deu errado! Confira seu acesso a internet e tente novamente"
                self.tableView.backgroundView = self.messageLabel;
                self.atualizaLayout()
            } else {
                if let users = users {
                    self.users = users
                    self.usersList = users
                }
                self.atualizaLayout()
            }
        }
    }

    func atualizaLayout() {
        DispatchQueue.main.async {
            self.viewInd.removeFromSuperview()
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    func searchUsers (texto: String){
        
        if (texto.isEmpty) {
            self.usersList = users
        } else {
            let filteredUsers = users.filter { user in
                return user.login.uppercased().contains(texto.uppercased())
            }
            
            self.usersList = filteredUsers
        }
        
        self.tableView.reloadData()
    }

}

extension BuscaVC{

    override func numberOfSections(in tableView: UITableView) -> Int {
        if (self.usersList.count > 0) {
            return 1
        } else {
//            self.tableView.backgroundView = self.messageLabel;
            self.tableView.separatorStyle = .none;
            
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.usersList.count == 0) ? 1 : self.usersList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BuscaCell
        
        cell.user = self.usersList[indexPath.item]
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.usersList[indexPath.item])
        
        let appDetalheVC = AppDetalheVC()
        
        appDetalheVC.userLogin = self.usersList[indexPath.item].login
        
        self.navigationController?.pushViewController(appDetalheVC, animated: true)
    }
    
}
