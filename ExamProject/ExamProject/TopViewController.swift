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
import Kingfisher

class TopViewController: UIViewController {
    
    var viewModel: TopViewModel!
    let dataSource: DataSource = DataSource()
    
    private let disposeBag = DisposeBag()

    @IBOutlet weak var clockView: ClockView!
    @IBOutlet weak var refreshButton: UIButton!
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
        _ = viewModel.results.subscribe(onNext: { [weak self] (repositories) in
            print("■■■■■💁<\(repositories.count) repositories found!!■■■■■")
            for repository in repositories {
                print("■ \(repository.name)")
                print("  - \(repository.url)")
            }
            print("■■■■■")
            self?.refreshButton.stopSpinAnimation()
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
        refreshButton.rx.tap.bindTo(viewModel.buttonTaps).addDisposableTo(disposeBag)
        _ = refreshButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.refreshButton.runSpinAnimation(withDuration: 1.0, doRepeat: true)
        })
        
        // 一秒ごとにカウントするタイマーを取得して現在日時を表示
        observer = viewModel.simpleTimer.subscribe(onNext: { next in
            let now = Date()
            self.clockView.timeLabel.text = now.toString(format: "yyyy/MM/dd HH:mm:ss")
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
    class DataSource: NSObject, RxCollectionViewDataSourceType, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
            cell.descriptionLabel.text = repo.description
            cell.urlLabel.text = repo.htmlUrl
            print("avatar: \(repo.owner.avatarUrl)")
            cell.iconImageView.kf.setImage(with: URL(string: repo.owner.avatarUrl))
            
            return cell
        }
        
        // MARK: - UICollectionViewDelegate
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print("\(indexPath.row) tapped.")
            let repo = repositories[indexPath.row]
            if let url = URL(string: repo.htmlUrl) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        // MARK: - UICollectionViewDelegateFlowLayout
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let parent = collectionView.bounds.size
            let minHeight: CGFloat = 200
            
            let itemsInColumn: CGFloat = CGFloat(Int(parent.height / minHeight))
            
            let cellWidth = parent.width/3
            let cellHeight = (parent.height - 10 * (itemsInColumn + 1)) / itemsInColumn
            
            return CGSize(width: cellWidth, height: cellHeight)
        }
    }

}
