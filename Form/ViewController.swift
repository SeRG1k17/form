//
//  ViewController.swift
//  Form
//
//  Created by Sergey Pugach on 07.06.2018.
//  Copyright © 2018 Сергей Пугач. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier = String(describing: CustomTableViewCell.self)
    
    var user = User()
    var dataSource = [FieldType]()
    
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let cellNib = UINib(nibName: cellIdentifier, bundle: Bundle.main)
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
        
//        dataSource = [
//            FieldType.age(\User.age),
//            FieldType.email(\User.email),
//            FieldType.name(\User.name),
//            FieldType.password(\User.password),
//            FieldType.age(\User.age),
//            FieldType.email(\User.email),
//            FieldType.name(\User.name),
//            FieldType.password(\User.password),
//            FieldType.age(\User.age),
//            FieldType.email(\User.email),
//            FieldType.name(\User.name),
//            FieldType.password(\User.password)
//        ]
        
        dataSource = [
            FieldType.age,
            FieldType.email,
            FieldType.name,
            FieldType.password,
            FieldType.age,
            FieldType.email,
            FieldType.name,
            FieldType.password,
            FieldType.age,
            FieldType.email,
            FieldType.name,
            FieldType.password
        ]
        
        
        let data = Observable.just(dataSource)
        
        data.bind(to: tableView.rx.items(cellIdentifier: cellIdentifier, cellType: CustomTableViewCell.self)) { index, model, cell in
            
            self.configure(cell, by: model)
        }
        .disposed(by: bag)
    }
    
    func configure(_ cell: CustomTableViewCell, by field: FieldType) {
        
        cell.titleLabel?.text = field.title
        
        var value: String?
        switch field {
        case .age:
            if let v = user.age {
            value = "\(v)"
            }
        case .name: value = user.password
        case .email: value = user.email
        case .password: value = user.password
        }
        
        cell.textfield.keyboardType = field.keyboardType
        cell.textfield.text = value
        
        cell.textfield.rx.text.asObservable()
            .map { $0 ?? "" }
            .subscribe(onNext: { text in
                switch field {
                case .age:
                    if let age = UInt(text) {
                    self.user.age = age
                    }
                case .name: self.user.name = text
                case .email: self.user.email = text
                case .password: self.user.password = text
                }
            })
        .disposed(by: bag)
    }


}

//extension ViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return dataSource.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
//
//        let field = dataSource[indexPath.row]
//        configureCell(cell, by: field)
//
//        return cell
//    }
//
//    func configureCell(_ cell: CustomTableViewCell, by field: FieldType) {
//
//        print(field)
//        var value: String?
//        switch field {
//
//        case let .age(keyPath):
//
//            if let v = user[keyPath: keyPath] {
//                value = "\(v)"
//            }
//        case let.name(keyPath): value = user[keyPath: keyPath]
//        case let.email(keyPath): value = user[keyPath: keyPath]
//        case let .password(keyPath): value = user[keyPath: keyPath]
//        }
//
//        cell.titleLabel.text = field.title
//        cell.textfield.text = value
//
//        cell.update = { [weak cell] in
//
//            let text = cell!.textfield.text!
//
//            switch field {
//
//            case let .age(keyPath): self.user[keyPath: keyPath] = UInt(text)!
//            case let.name(keyPath): self.user[keyPath: keyPath] = text
//            case let.email(keyPath): self.user[keyPath: keyPath] = text
//            case let .password(keyPath): self.user[keyPath: keyPath] = text
//            }
//        }
//    }
//}

