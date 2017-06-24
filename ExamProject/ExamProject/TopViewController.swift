//
//  TopViewController.swift
//  ExamProject
//
//  Created by M_Sugawara on 2017/06/22.
//  Copyright © 2017年 Sugawar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya

class TopViewController: UIViewController {
    
    var viewModel: TopViewModel!
    
    private let disposeBag = DisposeBag()

    @IBOutlet weak var button: UIButton!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(self) viewDidLoad")
        
        bindToRx()
    }
    
    // MARK: - Private Functions
    func bindToRx() {
        button.rx.tap.bindTo(viewModel.triggerRefresh).addDisposableTo(disposeBag)
        
        print("\(self) viewModel binded.")
    }

    // MARK: - Memory Management
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

