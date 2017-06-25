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
    let dataSource: DataSource = DataSource()
    
    private let disposeBag = DisposeBag()

    @IBOutlet weak var clockView: ClockView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var observer: Any?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(self) viewDidLoad")
        
        setupViews()
        
        bindToRx()
    }
    
    // MARK: - Private Functions
    func setupViews() {
        let nibName = String(describing: RepoCollectionViewCell.self)
        collectionView.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: "Cell")
    }
    
    func bindToRx() {
        // ログ表示用
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
        
        // CollectionViewのデータをGitHubAPIの結果にバインド
        viewModel.results
            .bindTo(collectionView.rx.items(dataSource: dataSource))
            .addDisposableTo(disposeBag)
        collectionView.delegate = dataSource
        
        // 更新ボタン
        button.rx.tap.bindTo(viewModel.buttonTaps).addDisposableTo(disposeBag)
        
        // 一秒ごとにカウントするタイマーを取得して現在日時を表示
        observer = viewModel.simpleTimer.subscribe(onNext: { next in
            let now = Date()
            self.clockView.timeLabel.text = now.toString(format: "HH:mm:ss")
        }).addDisposableTo(disposeBag)
        
        print("\(self) viewModel binded.")
    }

    // MARK: - Memory Management
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - StatusBar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - UICollectionView Presenter
    class DataSource: NSObject, RxCollectionViewDataSourceType, UICollectionViewDataSource, UICollectionViewDelegate {
        typealias Element = [Repository]
        
        var repositories: Element = []
        
        func collectionView(_ collectionView: UICollectionView, observedEvent: Event<[Repository]>) {
            if case .next(let repositories) = observedEvent {
                self.repositories = repositories
                collectionView.reloadData()
            }
        }
        
        // MARK: - UICollectionViewDataSource
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return repositories.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! RepoCollectionViewCell
            print("cellForItemAt: \(repositories[indexPath.row].name)")
            let repo = repositories[indexPath.row]
            cell.nameLabel.text = repo.name
            
            return cell
        }
        
        // MARK: - UICollectionViewDelegate
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print("\(indexPath.row) tapped.")
        }
    }

}
