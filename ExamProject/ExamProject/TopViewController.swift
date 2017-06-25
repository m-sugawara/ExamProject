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

    @IBOutlet weak var clockView: ClockView!
    @IBOutlet weak var button: UIButton!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(self) viewDidLoad")
        
        bindToRx()
    }
    
    // MARK: - Private Functions
    func bindToRx() {
        _ = viewModel.results.subscribe(onNext: { (repositories) in
            print("■■■■■💁<\(repositories.count) repositories found!!■■■■■")
            for repository in repositories {
                print("■ \(repository.name)")
                print("  - \(repository.url)")
            }
            print("■■■■■")
        }, onError: { (error) in
            print("error occurred.")
        }, onCompleted: { 
            
        }).addDisposableTo(disposeBag)
        
        button.rx.tap.bindTo(viewModel.buttonTaps).addDisposableTo(disposeBag)
        
        _ = viewModel.currentDate.subscribe(onNext: { next in
            print("date: \(next)")
            let now = Date()
            self.clockView.timeLabel.text = now.toString(format: "HH:mm:ss")
        })
        
        print("\(self) viewModel binded.")
        self.clockView.timeLabel.text = "aaa"
    }

    // MARK: - Memory Management
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

