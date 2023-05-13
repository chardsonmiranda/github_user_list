import UIKit

class BuscaService {
    
    static let shared = BuscaService()

    //--busca user teste carrefour
    func buscaUsers(completion: @escaping([User]?, Error?)-> () ) {
        
        guard let url = URL(string: "https://api.github.com/users") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            if let err = err {
                completion(nil, err)
                return
            }
            
            do{
                guard let data = data else {return}
                
                let apps = try JSONDecoder().decode([User].self, from: data)
                completion(apps, nil)
                
            } catch let err{
                completion(nil, err)
                return
            }
        }.resume()
    }
    
    func buscaUsersDetail(login: String, completion: @escaping(UserDetail?, Error?)-> () ) {
        
        guard let url = URL(string: "https://api.github.com/users/\(login)") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            if let err = err {
                completion(nil, err)
                return
            }
            
            do{
                guard let data = data else {return}
                
                let apps = try JSONDecoder().decode(UserDetail.self, from: data)
                completion(apps, nil)
                
            } catch let err{
                completion(nil, err)
                return
            }
        }.resume()
    }

    func buscaUsersDetailRepos(login: String, completion: @escaping([UserRepoElement]?, Error?)-> () ) {
        
        guard let url = URL(string: "https://api.github.com/users/\(login)/repos") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            if let err = err {
                completion(nil, err)
                return
            }
            
            do{
                guard let data = data else {return}
                
                let apps = try JSONDecoder().decode([UserRepoElement].self, from: data)
                completion(apps, nil)
                
            } catch let err{
                completion(nil, err)
                return
            }
        }.resume()
    }
}

