//
//  DetailViewController.swift
//  InManyWays-RestAPI
//
//  Created by 홍정연 on 2023/08/22.
//

import UIKit
import RxSwift
import Kingfisher

class DetailViewController: UIViewController {

    var viewModel: DetailViewModel!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layout()
        bind()
    }
    

    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.view.backgroundColor = .systemGray6
        self.title = "News"
    }

    private func bind() {
        self.viewModel.output.item
            .subscribe(onNext: { [weak self] news in
                guard let self = self else { return }
            }).disposed(by: disposeBag)
    }
}
