//
//  LeaveBookCVC.swift
//  DinnerHack
//
//  Created by saint on 2023/04/29.
//

import UIKit
import SnapKit
import Moya
import Then

class LeaveBookCVC: UICollectionViewCell {
    
    // MARK: - Properties
    private let bookInfoView = UIView()
    
    private let bookImage = UIImageView()
    
    private let pinImage = UIImageView().then{
        $0.image = UIImage(named: "redclip")
    }
    
    private let titleLabel = UILabel().then{
        $0.font = UIFont(name: "MapoFlowerIsland", size: 14.0)
        $0.textColor = .brown2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        cellShape()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LeaveBookCVC{
    
    // MARK: - Layout Helpers
    private func setLayout() {
        backgroundColor = .clear
        contentView.backgroundColor = .white
        contentView.addSubviews([bookImage, pinImage, titleLabel])
        
        bookImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(7)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(144.adjustedW)
            $0.height.equalTo(191.adjustedW)
        }
        
        pinImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(21.adjustedW)
            $0.height.equalTo(21.adjustedW)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(bookImage.snp.bottom).offset(14)
            $0.trailing.equalToSuperview().offset(-8)
        }
    }
    
    func cellShape() {
        contentView.layer.borderColor = UIColor.brown2.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentView.layer.masksToBounds = false
    }
    
    func dataBind(model: BookModel) {
        bookImage.image = UIImage(named: model.image)
        titleLabel.text = model.title
    }
}


