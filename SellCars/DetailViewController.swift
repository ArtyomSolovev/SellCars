//
//  DetailViewController.swift
//  SellCars
//
//  Created by Артем Соловьев on 27.12.2021.
//

import UIKit

class DetailViewController: UIViewController {

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
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.hexStringToUIColor(hex: Constants.Color.white)
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = car?.title
        
        self.view.addSubview(scrollView)

        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(galleryCollectionView)
        
        galleryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        galleryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        galleryCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        galleryCollectionView.heightAnchor.constraint(equalToConstant: view.bounds.height/2).isActive = true
        
        let arrayOfPhoto = getAllPhotos()
        
        self.galleryCollectionView.set(cells: arrayOfPhoto)
        
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

        let viewSupport = UIView()
        scrollView.addSubview(viewSupport)
        
        viewSupport.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewSupport.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        viewSupport.topAnchor.constraint(equalTo: galleryCollectionView.bottomAnchor, constant: 10).isActive = true
        viewSupport.heightAnchor.constraint(equalToConstant: StackView.bounds.height).isActive = true

        viewSupport.addSubview(StackView)
        NSLayoutConstraint.activate([
            StackView.topAnchor.constraint(equalTo: viewSupport.bottomAnchor),
            StackView.leftAnchor.constraint(equalTo: viewSupport.leftAnchor),
        ])
    }
    
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
