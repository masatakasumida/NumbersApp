//
//  NumbersViewController.swift
//  Numbers
//
//  Created by 住田雅隆 on 2022/06/29.
//

import UIKit
import RxSwift
import RxCocoa

class NumbersViewController: UIViewController {
    
    @IBOutlet private weak var textField1: UITextField!
    @IBOutlet private weak var textField2: UITextField!
    @IBOutlet private weak var textField3: UITextField!
    
    @IBOutlet private weak var answerLabel: UILabel!
    
    private var viewModel: NumbersViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    func setupViewModel() {
        viewModel = NumbersViewModel()
        textField1.rx.text.orEmpty
            .bind(to: viewModel.textField1)
            .disposed(by: disposeBag)
        
        textField2.rx.text.orEmpty
            .bind(to: viewModel.textField2)
            .disposed(by: disposeBag)
        
        textField3.rx.text.orEmpty
            .bind(to: viewModel.textField3)
            .disposed(by: disposeBag)
        
        viewModel.sumNumber()
            .bind(to: answerLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
}
final class NumbersViewModel {
    
    let textField1 = BehaviorRelay<String>(value: "")
    let textField2 = BehaviorRelay<String>(value: "")
    let textField3 = BehaviorRelay<String>(value: "")
    
    func sumNumber() -> Observable<String> {
        return Observable.combineLatest(textField1.asObservable(), textField2.asObservable(), textField3.asObservable())
            .map{ value1, value2, value3 in
                return "\(((Int(value1) ?? 0) + (Int(value2) ?? 0) + (Int(value3) ?? 0)))"
            }
    }
}
