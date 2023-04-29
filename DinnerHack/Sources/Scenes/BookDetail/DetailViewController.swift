//
//  DetailViewController.swift
//  DinnerHack
//
//  Created by creohwan on 2023/04/30.
//

import UIKit

class DetailViewController: UIViewController {
    
    var bookdata = BookModel(title: "1", contents: "2", image: "pinImage")
    
    private var textViewPlaceHolder = "이 책 베리 굿"
    
    private let pinImage: UIImageView = {
        $0.image = UIImage(named: "pinImage")
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = true
        return $0
    }(UIImageView())
    
    private lazy var bookImage: UIImageView = {
        $0.image = UIImage(named:bookdata.image)
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = true
        return $0
    }(UIImageView())
    
    private lazy var bookTitle: UILabel = {
        $0.text = bookdata.title
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private var shadowView: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        return $0
    }(UIView())
    
    private lazy var textContent: UITextView = {
        let linestyle = NSMutableParagraphStyle()
        linestyle.lineSpacing = 4.0
        $0.typingAttributes = [.paragraphStyle: linestyle]
        $0.backgroundColor = .brown1
        $0.text = bookdata.contents
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        $0.textAlignment = .natural
        $0.textContainerInset = UIEdgeInsets(top: 17, left: 12, bottom: 17, right: 12)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 10
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        return $0
    }(UITextView())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        
        self.view.addSubview(pinImage)
        pinImage.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingLeft: 10,
            paddingRight: 10,
            height: 400
        )
        
        self.pinImage.addSubview(bookImage)
        bookImage.anchor(
            top: pinImage.topAnchor,
            left: pinImage.leftAnchor,
            bottom: pinImage.bottomAnchor,
            right: pinImage.rightAnchor,
            paddingTop: 30,
            paddingLeft: 40,
            paddingBottom: 30,
            paddingRight: 40
        )
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchToPickPhoto))
        bookImage.addGestureRecognizer(tapGesture)
        
        self.view.addSubview(bookTitle)
        self.view.addSubview(shadowView)
        self.shadowView.addSubview(textContent)
        
        bookTitle.anchor(
            top: pinImage.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 20,
            paddingLeft: 16,
            paddingRight: 16
        )
        
        shadowView.anchor(
            top: bookTitle.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 10,
            paddingLeft: 16,
            paddingRight: 16,
            height: 215
        )

        textContent.anchor(
            left: shadowView.leftAnchor,
            right: shadowView.rightAnchor,
            height: 215
        )
        
    }
    
    @objc func touchToPickPhoto() {
        let viewController = PostImageView()
        viewController.postImage = bookImage
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        self.present(viewController, animated: true)
    }
}
