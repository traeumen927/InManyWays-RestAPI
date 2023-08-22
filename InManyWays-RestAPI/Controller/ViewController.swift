//
//  ViewController.swift
//  InManyWays-RestAPI
//
//  Created by 홍정연 on 2023/08/15.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var viewModel: ViewModel!
    
    private var tableView: UITableView = {
        let view = UITableView(frame: CGRectZero, style: .insetGrouped)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.title = "Many ways in rest api"
        self.view.backgroundColor = .white
        
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var config = cell.defaultContentConfiguration()
        config.text = viewModel.WayAt(indexPath.row).rawValue
        config.secondaryText = viewModel.WayAt(indexPath.row).description
        
        cell.contentConfiguration = config
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let way = viewModel.WayAt(indexPath.row)
        let vc = NewsViewController(viewModel: way.viewModel)
        vc.title = way.rawValue
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

