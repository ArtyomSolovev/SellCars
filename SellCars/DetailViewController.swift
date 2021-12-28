//
//  DetailViewController.swift
//  SellCars
//
//  Created by Артем Соловьев on 27.12.2021.
//

import UIKit
import SafariServices
import CoreData

final class DetailViewController: UIViewController {

    private var car: Car?
    private var galleryCollectionView = GalleryCollectionView()
    private var labels = [UILabel]()
    private var labelsWithData = [UILabel]()
    private var textInLabels = ["Цена:", "Город:", "Дата размещения:", "Цвет:", "Год:", "Пробег:",
                                "Двигатель:", "Коробка пердач:", "Привод:", "Категорияя:",
                                "VIN:", "Гос. номер:"]
    private var textInLabelsWithData = [String]()
    
    init(car: Car) {
        self.car = car
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let buyButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Купить", for: .normal)
        btn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        btn.backgroundColor = .hexStringToUIColor(hex: Constants.Color.red)
        btn.layer.cornerRadius = 25
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.shadowRadius = 5
        btn.layer.shadowOpacity = 0.3
        btn.layer.shadowOffset = CGSize(width: 5, height: 8)
        return btn
    }()
    
    @objc func buttonAction(sender: UIButton!) {
        if let url = URL(string: "https://auto.ria.com" + car!.linkToView) {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        }
    }
    
//    private let addButton: UIButton = {
//        let btn = UIButton()
//        btn.setImage(UIImage(systemName: "square.and.arrow.down",
//                             withConfiguration: UIImage.SymbolConfiguration(textStyle: .largeTitle)),
//                     for: .normal)
//        btn.addTarget(self, action: #selector(saveTask), for: .touchUpInside)
//        btn.tintColor = .black
//        btn.backgroundColor = .hexStringToUIColor(hex: Constants.Color.red)
//        btn.layer.cornerRadius = 25
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.layer.shadowRadius = 5
//        btn.layer.shadowOpacity = 0.3
//        btn.layer.shadowOffset = CGSize(width: 5, height: 8)
//        btn.layer.cornerRadius = 25
//        return btn
//    }()
    
//    @objc private func saveTask() {
//
//        let context = Constants.getContext()
//
//        guard let entity = NSEntityDescription.entity(forEntityName: "CarDB", in: context) else { return }
//
//        let taskObject = CarDB(entity: entity, insertInto: context)
//        taskObject.userId = Int64(car!.userId)
//        taskObject.title = car?.title
//
//        do {
//            try context.save()
//            addButton.isEnabled = false
//            addButton.alpha = 0.5
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//    }
    
    private lazy var descriptionLabel: UILabel = {
        let v = UILabel()
        v.numberOfLines = 0
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let customView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = car?.title
        view.backgroundColor = UIColor.hexStringToUIColor(hex: Constants.Color.white)
        
        view.addSubview(scrollView)
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(customView)
        
        self.configureCollectionView()
        self.configureBuyButton()
//        self.configureAddButton()
        
        
        self.fillLabelsWithData()
        self.fillingTheArray(arrayOfString: textInLabels, arrayOfLabels: &labels)
        self.fillingTheArray(arrayOfString: textInLabelsWithData, arrayOfLabels: &labelsWithData)
        
        //verticalStackView
        let verticalStackView   = UIStackView(arrangedSubviews: labels)
        verticalStackView.axis  = NSLayoutConstraint.Axis.vertical
        verticalStackView.distribution  = UIStackView.Distribution.equalSpacing
        verticalStackView.alignment = UIStackView.Alignment.fill
        verticalStackView.spacing   = 10.0
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let verticalStackView2   = UIStackView(arrangedSubviews: labelsWithData)
        verticalStackView2.axis  = NSLayoutConstraint.Axis.vertical
        verticalStackView2.distribution  = UIStackView.Distribution.equalSpacing
        verticalStackView2.alignment = UIStackView.Alignment.center
        verticalStackView2.spacing   = 10.0
        verticalStackView2.translatesAutoresizingMaskIntoConstraints = false
        
        let StackView   = UIStackView(arrangedSubviews: [verticalStackView, verticalStackView2])
        StackView.axis  = NSLayoutConstraint.Axis.horizontal
        StackView.distribution  = UIStackView.Distribution.equalSpacing
        StackView.alignment = UIStackView.Alignment.center
        StackView.spacing   = 10.0
        StackView.translatesAutoresizingMaskIntoConstraints = false
        
        customView.addSubview(StackView)
        NSLayoutConstraint.activate([
            StackView.topAnchor.constraint(equalTo: buyButton.bottomAnchor, constant: 10),
            StackView.leftAnchor.constraint(equalTo: customView.leftAnchor),
        ])
        
        descriptionLabel.text = "Описание: " + (car?.autoData?.description)!
        customView.addSubview(descriptionLabel)
        descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: StackView.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height*1.5)
    }
    
    
    fileprivate func configureCollectionView() {
        customView.addSubview(galleryCollectionView)
        galleryCollectionView.leadingAnchor.constraint(equalTo: customView.leadingAnchor).isActive = true
        galleryCollectionView.trailingAnchor.constraint(equalTo: customView.trailingAnchor).isActive = true
        galleryCollectionView.topAnchor.constraint(equalTo: customView.topAnchor, constant: 10).isActive = true
        galleryCollectionView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        let arrayOfPhoto = getAllPhotos()
        galleryCollectionView.set(cells: arrayOfPhoto)
    }
    
    fileprivate func configureBuyButton() {
        customView.addSubview(buyButton)
        buyButton.topAnchor.constraint(equalTo: galleryCollectionView.bottomAnchor, constant: 10).isActive = true
        buyButton.leftAnchor.constraint(equalTo: customView.leftAnchor, constant: UIScreen.main.bounds.width/20).isActive = true
        buyButton.widthAnchor.constraint(equalTo: customView.widthAnchor, multiplier: 0.4).isActive = true
        buyButton.heightAnchor.constraint(equalTo: customView.widthAnchor, multiplier: 0.4).isActive = true
    }
    
//    fileprivate func configureAddButton() {
//        customView.addSubview(addButton)
//        addButton.topAnchor.constraint(equalTo: galleryCollectionView.bottomAnchor, constant: 10).isActive = true
//        addButton.leftAnchor.constraint(equalTo: buyButton.rightAnchor, constant: UIScreen.main.bounds.width/10).isActive = true
//        addButton.widthAnchor.constraint(equalTo: customView.widthAnchor, multiplier: 0.4).isActive = true
//        addButton.heightAnchor.constraint(equalTo: customView.widthAnchor, multiplier: 0.4).isActive = true
//    }
    
    private func fillLabelsWithData(){
        guard let car = car else { return }
        textInLabelsWithData.append(String(car.USD) + " $")
        textInLabelsWithData.append(car.locationCityName)
        textInLabelsWithData.append(car.addDate)
        textInLabelsWithData.append(car.color?.name ?? "Неизвестно")
        textInLabelsWithData.append(String(car.autoData?.year ?? 0))
        textInLabelsWithData.append(car.autoData?.race ?? "Неизвестно")
        textInLabelsWithData.append(car.autoData?.fuelName ?? "Неизвестно")
        textInLabelsWithData.append(car.autoData?.gearboxName ?? "Неизвестно")
        textInLabelsWithData.append(car.autoData?.driveName ?? "Неизвестно")
        textInLabelsWithData.append(car.subCategoryName)
        textInLabelsWithData.append(car.VIN)
        textInLabelsWithData.append(car.plateNumber ?? "Неизвестно")
    }
    
    private func getAllPhotos() -> [String]{
        var photos = [String]()
        guard let str = car?.photoData?.seoLinkF else { return [String]()}
        let url = str[..<(str.lastIndex(of: "_") ?? str.endIndex)]
        for photo in 0..<((car?.photoData?.all.count) ?? 0) {
            photos.append( url + "_" + String((car?.photoData?.all[photo])!) + "f.jpg")
        }
        return photos
    }
    private func fillingTheArray(arrayOfString: [String], arrayOfLabels:inout [UILabel]){
        for numberOfLablel in 0..<12 {
            let label = UILabel()
            label.text = arrayOfString[numberOfLablel]
            label.textAlignment = .right
            arrayOfLabels.append(label)
        }
    }
}

