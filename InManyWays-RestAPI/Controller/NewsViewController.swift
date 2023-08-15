//
//  NewsViewController.swift
//  InManyWays-RestAPI
//
//  Created by 홍정연 on 2023/08/15.
//

import UIKit

class NewsViewController: UIViewController {

    var viewModel: viewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layout()
    }
    
    init(viewModel: viewModelType!) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.view.backgroundColor = .white
    }
}
