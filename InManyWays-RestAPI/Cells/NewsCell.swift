//
//  NewsCell.swift
//  InManyWays-RestAPI
//
//  Created by 홍정연 on 2023/08/21.
//

import UIKit
import SnapKit
import Kingfisher

class NewsCell: UITableViewCell {
    
    // MARK: Cell ID
    static let cellId = "NewsCell"
    
    private var newsView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 24.0
        v.layer.applySketchShadow(color: .black, alpha: 0.3, x: 0, y: 0, blur: 13, spread: 0)
        return v
    }()
    
    // MARK: 뉴스 썸네일 이미지
    private var thumbnailImage: UIImageView = {
        let v = UIImageView()
        v.layer.cornerRadius = 24.0
        v.clipsToBounds = true
        return v
    }()
    
    // MARK: 뉴스 제목
    private var titleLabel: UILabel = {
        let v = UILabel()
        v.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        v.textColor = .black
        v.numberOfLines = 0
        return v
    }()
    
    // MARK: 뉴스 내용
    private var contentLabel: UILabel = {
        let v = UILabel()
        v.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        v.textColor = .black
        v.numberOfLines = 15
        return v
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: setup layout
    private func layout() {
        
        self.contentView.addSubview(newsView)
        self.contentView.backgroundColor = .systemGray6
        
        [thumbnailImage, titleLabel, contentLabel].forEach(newsView.addSubview(_:))
        
        newsView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        thumbnailImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(thumbnailImage.snp.width).multipliedBy(0.8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImage.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-36)
        }
    }
    
    // MARK: Data Bind
    func bind(article: article) {
        thumbnailImage.kf.setImage(with: article.urlToImage,
                                   placeholder: UIImage(systemName: "photo.fill")
        )
        titleLabel.text = article.title
        contentLabel.text = article.content
    }
}
