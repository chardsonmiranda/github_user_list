import UIKit

extension UIImageView {
    
    static func iconeImageView(witdth: CGFloat = 64, height: CGFloat = 64) -> UIImageView {
        
        let imagem = UIImageView()
        
        imagem.size(size: .init(width: witdth, height: height))
        imagem.backgroundColor = .white
        imagem.layer.borderWidth = 0.5
        imagem.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        imagem.layer.cornerRadius = 12
        imagem.clipsToBounds = true
        
        
        return imagem
    }
    
    static func screenshotImageView() -> UIImageView{
        let imagem = UIImageView()
        
        imagem.backgroundColor = .white
        imagem.layer.borderWidth = 0.5
        imagem.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        imagem.layer.cornerRadius = 12
        imagem.clipsToBounds = true
        imagem.contentMode = .scaleAspectFill

        return imagem
        
    }
    
}
