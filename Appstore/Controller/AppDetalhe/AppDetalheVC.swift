import UIKit

class AppDetalheVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let headerId = "headerId"
    let bodyId = "bodyId"
    
    var userDetail: [UserDetail] = []
    var userDetailRepos: [UserRepoElement] = []
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        ai.color = .cinza
        ai.startAnimating()
        ai.hidesWhenStopped = true
        return ai
    }()
    
    var userLogin: String! {
        didSet {
            self.buscaDetail(userLogin: userLogin)
        }
    }
    
    var loading: Bool = true

    let messageLabel: UILabel = {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 200))
        messageLabel.text = ""
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        return messageLabel
    }()
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        //collectionView.backgroundColor = .white
        collectionView.register(AppDetalheHeaderCell.self, forCellWithReuseIdentifier: headerId)
        collectionView.register(AppDetalheBodyReposCell.self, forCellWithReuseIdentifier: bodyId)
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(callPullToRefresh), for: .valueChanged)

        view.addSubview(activityIndicatorView)
        activityIndicatorView.centralizasSuperview()
        
    }
    
    func buscaDetail (userLogin: String) {
        self.messageLabel.text = ""

        BuscaService.shared.buscaUsersDetail(login: userLogin) { (userDetail, err) in
            
            if (err != nil) {
                self.messageLabel.text = "Ops... Algo deu errado! Confira seu acesso a internet e tente novamente"
                self.atualizaLayout()
            } else {
                if let userDetail = userDetail {
                    self.userDetail = [userDetail]
                    self.buscaDetailRepos(userLogin: userLogin)
                } else {
                    self.atualizaLayout()
                }
            }
        }
    }
    
    func buscaDetailRepos (userLogin: String) {
        
        BuscaService.shared.buscaUsersDetailRepos(login: userLogin) { (repos, err) in
            if (err != nil) {
                self.messageLabel.text = "Ops... Algo deu errado! Confira seu acesso a internet e tente novamente"
                self.atualizaLayout()
            } else {
                if let repos = repos {
                    self.userDetailRepos = repos
                }
                self.atualizaLayout()
            }
        }
    }
    
    func atualizaLayout () {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.collectionView.refreshControl?.endRefreshing()
            self.collectionView.reloadData()
        }
    }

    @objc func callPullToRefresh(){
        self.buscaDetail(userLogin: userLogin)
    }

}
extension AppDetalheVC {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        if (self.userDetail.count > 0) {
            self.collectionView.backgroundView?.isHidden = true
            return 1
        } else {
            self.collectionView.backgroundView = self.messageLabel;
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (userDetail.count == 1) ? 2 : 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: headerId, for: indexPath) as! AppDetalheHeaderCell
            cell.userDatail = self.userDetail[indexPath.item]
            return cell
        }

        if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bodyId, for: indexPath) as! AppDetalheBodyReposCell
            cell.userDatailRepos = self.userDetailRepos
            return cell
        }

        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let viewWidth: CGFloat = view.bounds.width
        var viewHeight: CGFloat = 170

        if indexPath.item == 1 {
            viewHeight = view.bounds.height - 170 - view.safeAreaInsets.bottom - view.safeAreaInsets.top
        }

        return .init(width: viewWidth, height: viewHeight)
    }
}
