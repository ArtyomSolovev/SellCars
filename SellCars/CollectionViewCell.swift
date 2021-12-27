//
//  CollectionViewCell.swift
//  SellCars
//
//  Created by Артем Соловьев on 27.12.2021.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    
    static let id = "CollectionViewCell"
    var dataProvider = DataProvider()
    
    private var imageView : UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let costLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name:"HelveticaNeue-Bold",size:17)
        label.textColor = .red// hexStringToUIColor(hex: "#F05454")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rangeLabel: UILabel = {
        let label = UILabel()
//        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let engineLabel: UILabel = {
        let label = UILabel()
//        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setAnimal(car: Car){
        let url = URL(string: car.photoData!.seoLinkB)!
//        let data = try? Data(contentsOf: url)
        
        dataProvider.downloadImage(url: url) { image in
            self.imageView.image = image//UIImage(data: data!)
        }
        self.nameLabel.text = car.title
        self.costLabel.text = String(car.USD) + " $"
        self.rangeLabel.text = car.autoData?.race
        self.engineLabel.text = car.autoData?.fuelName
        backgroundColor = hexStringToUIColor(hex: "#F5F5F5")
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.25) {
                self.alpha = self.isHighlighted ? 0.5 : 1.0
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureContentLayout()
        self.configureLayer()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContentLayout() {
        self.addSubview(imageView)
        self.addSubview(nameLabel)
        self.addSubview(costLabel)
        self.addSubview(rangeLabel)
        self.addSubview(engineLabel)
        setupName()
        setupPhoto()
        setupCost()
        setupRange()
        setupEngine()
    }
    
    private func setupName(){
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
    }
    
    private func setupPhoto() {
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6).isActive = true
        imageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
    }
    
    private func setupCost(){
        costLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        costLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        costLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
        costLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
    }
    
    private func setupRange(){
        rangeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: UIScreen.main.bounds.width/10).isActive = true
        rangeLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
        rangeLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
        rangeLabel.topAnchor.constraint(equalTo: costLabel.bottomAnchor).isActive = true
    }
    private func setupEngine(){
        engineLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 5).isActive = true
        engineLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
        engineLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
        engineLabel.topAnchor.constraint(equalTo: costLabel.bottomAnchor).isActive = true
    }
    
    private func configureLayer() {
        layer.cornerRadius = frame.height / 10
        backgroundColor = UIColor.systemGray
//        layer.borderColor = UIColor.darkGray.cgColor
//        layer.borderWidth = 1
    }

}

extension CollectionViewCell {
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
