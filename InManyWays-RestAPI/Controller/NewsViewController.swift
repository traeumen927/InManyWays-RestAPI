//
//  NewsViewController.swift
//  InManyWays-RestAPI
//
//  Created by 홍정연 on 2023/08/15.
//

import UIKit
import RxSwift

class NewsViewController: UIViewController {
    
    var viewModel: any NewsViewModelType
    var disposeBag = DisposeBag()
    var articles = [article]()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(NewsCell.self, forCellReuseIdentifier: NewsCell.cellId)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .clear
        view.separatorStyle = .none
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        bind()
    }
    
    init(viewModel: any NewsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.view.backgroundColor = .systemGray6
        
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func bind() {
        self.viewModel.input.loadData.onNext(())
        
        self.viewModel.output.items.subscribe(onNext: { [weak self] news in
            guard let self = self else { return }
            self.articles = news.articles
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }).disposed(by: disposeBag)
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.cellId, for: indexPath) as! NewsCell
        cell.bind(article: articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController(viewModel: DetailViewModel(article: articles[indexPath.row]))
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
