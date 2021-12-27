//
//  DetailViewController.swift
//  SellCars
//
//  Created by Артем Соловьев on 27.12.2021.
//

import UIKit

class DetailViewController: UIViewController {

    private var car = Car()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    init(car: Car) {
        self.car = car
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
