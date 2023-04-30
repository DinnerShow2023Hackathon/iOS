//
//  DetailViewController.swift
//  DinnerHack
//
//  Created by creohwan on 2023/04/30.
//

import UIKit
import SnapKit
import Then

class DetailViewController: UIViewController {
    
    var bookdata = BookModel(title: "노인과 바다", contents: "행복합니다?", image: UIImage(named: "book1")!)
    
    private var textViewPlaceHolder = "이 책 베리 굿"
    
    private let pinImage: UIImageView = {
        $0.image = UIImage(named: "pinImg")
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = true
        return $0
    }(UIImageView())
    
    private lazy var bookImage: UIImageView = {
        $0.image = bookdata.image
        $0.contentMode = .scaleToFill
        $0.isUserInteractionEnabled = true
        return $0
    }(UIImageView())
    
    private let userId = UILabel().then{
        $0.text = "id: dinnerShow30"
        $0.font = UIFont(name: "KimjungchulMyungjo-Bold", size: 16.0)
    }
    
    private let userMessage = UILabel().then{
        $0.text = "책의 다음 주인에게,"
        $0.font = UIFont(name: "KimjungchulMyungjo-Regular", size: 16.0)
    }
    
    private lazy var bookTitle: UILabel = {
        $0.text = bookdata.title
        $0.textAlignment = .center
        $0.font = UIFont(name: "MapoFlowerIsland", size: 24.0)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private var shadowView: UIView = {
        $0.backgroundColor = .layerBrown
        $0.layer.cornerRadius = 10
        return $0
    }(UIView())
    
    private lazy var textContent: UITextView = {
        let linestyle = NSMutableParagraphStyle()
        linestyle.lineSpacing = 4.0
        $0.typingAttributes = [.paragraphStyle: linestyle]
        $0.backgroundColor = .layerBrown
        $0.text = bookdata.contents
        $0.textColor = .black
        $0.font = UIFont(name: "MapoFlowerIsland", size: 16.0)
        $0.textAlignment = .natural
        $0.textContainerInset = UIEdgeInsets(top: 14, left: 12, bottom: 14, right: 12)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 10
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        return $0
    }(UITextView())
    
    let closeBtn = UIButton().then{
        $0.setImage(UIImage(named: "closeBtn"), for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        pressBtn()
        
        self.view.addSubview(closeBtn)
        closeBtn.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 14,
            paddingRight: 20,
            width: 24,
            height: 24
        )
        
        self.view.addSubview(pinImage)
        pinImage.anchor(
            top: closeBtn.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
//            paddingTop: 10,
            paddingLeft: 10,
            paddingRight: 10,
            height: 550
        )
        
        self.pinImage.addSubviews([bookImage, bookTitle])
        bookImage.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(30)
            $0.width.equalTo(312)
            $0.height.equalTo(416)
        }
        
        bookTitle.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-30)
            $0.trailing.equalToSuperview().offset(-30)
        }
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchToPickPhoto))
        bookImage.addGestureRecognizer(tapGesture)
        
        view.addSubviews([userId, userMessage])
        
        userId.snp.makeConstraints{
            $0.top.equalTo(pinImage.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(34.adjustedW)
        }
        
        userMessage.snp.makeConstraints{
            $0.top.equalTo(userId.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(34.adjustedW)
        }
        
        self.view.addSubview(shadowView)
        self.shadowView.addSubview(textContent)
        
        shadowView.anchor(
            top: userMessage.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 6,
            paddingLeft: 20,
            paddingRight: 20,
            height: 80
        )

        textContent.anchor(
            left: shadowView.leftAnchor,
            right: shadowView.rightAnchor,
            height: 80
        )
        
    }
    
    private func pressBtn(){
        closeBtn.press {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func touchToPickPhoto() {
        let viewController = PostImageView()
        viewController.postImage = bookImage
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        self.present(viewController, animated: true)
    }
}
