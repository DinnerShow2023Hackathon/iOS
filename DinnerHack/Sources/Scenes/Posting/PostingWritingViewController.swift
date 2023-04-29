//
//  PostingWritingView.swift
//  Samsam
//
//  Created by creohwan on 2022/10/19.
//

import UIKit
import SnapKit
import PhotosUI

class PostingWritingViewController: UIViewController {
    
    var postData: CellItem = CellItem()
    private var textViewPlaceHolder = "1. 이 책이 나에게 어떤 의미인지 \n2. 이 쪽을 선택한 이유 \n등 자유롭게 작성해주세요 :)"
    
    // MARK: - View

    private var bookTitle: UILabel = {
        $0.text = "책 제목"
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private lazy var bookTitleField: UITextField = {
        $0.placeholder = " ex) 여행의 이유 (김영하)"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
//        $0.addTarget(self, action: #selector(buttonAttributeChanged), for: .editingChanged)
        return $0
    }(UITextField())
    
    private let bookTitleLine: UIView = {
        $0.setHeight(height: 1)
        $0.backgroundColor = .brown1
        return $0
    }(UIView())
    
    private var textTitle: UILabel = {
        $0.text = "다음 책 주인이 될 분을 위한 한 마디"
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .black
        return $0
    }(UILabel())

    
//    private let exampleLabel: UILabel = {
//        $0.text = """
//                    예시)
//                    - 거실 바닥 장판 철거, PE폼 깔기
//                    - 강화마루 설치
//                    - 특이사항 없음
//                    - 작업인원 0명
//                    """
//        $0.numberOfLines = 0
//        $0.textColor = .gray
//        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
//        return $0
//    }(UILabel())

    private lazy var textContent: UITextView = {
        let linestyle = NSMutableParagraphStyle()
        linestyle.lineSpacing = 4.0
        $0.typingAttributes = [.paragraphStyle: linestyle]
        $0.backgroundColor = .brown1
        $0.text = textViewPlaceHolder
        $0.textColor = .gray
        $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        $0.textAlignment = .natural
        $0.textContainerInset = UIEdgeInsets(top: 17, left: 12, bottom: 17, right: 12)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 10
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.delegate = self
        return $0
    }(UITextView())

    private var shadowView: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        return $0
    }(UIView())

    private let postBTN: UIButton = {
        $0.backgroundColor = .brown1
        $0.setTitle("책 걸기", for: .normal)
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(tapNextBTN), for: .touchUpInside)
        return $0
    }(UIButton())
    
    let closeBtn = UIButton().then{
        $0.setImage(UIImage(named: "closeBtn"), for: .normal)
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        hidekeyboardWhenTappedAround()
        attribute()
        layout()
        setupNotificationCenter()
    }
    
    private func attribute() {
        view.backgroundColor = .bg
        setupNavigationTitle()
    }
    
    private func layout() {
        
        self.view.addSubviews([bookTitle, bookTitleField, bookTitleLine, textTitle, shadowView, postBTN])
        self.shadowView.addSubview(textContent)
        
        bookTitle.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        bookTitleField.anchor(
            top: bookTitle.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 8,
            paddingLeft: 16,
            paddingRight: 16
        )
        
        bookTitleLine.anchor(
            top: bookTitle.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 30,
            paddingLeft: 16,
            paddingRight: 16
        )
        
        textTitle.anchor(
            top: bookTitleLine.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 25,
            paddingLeft: 16,
            paddingRight: 16
        )
        
//        exampleLabel.anchor(
//            top: textTitle.bottomAnchor,
//            left: view.safeAreaLayoutGuide.leftAnchor,
//            right: view.safeAreaLayoutGuide.rightAnchor,
//            paddingTop: 10,
//            paddingLeft: 16,
//            paddingRight: 16
//        )
        
        shadowView.anchor(
            top: textTitle.bottomAnchor,
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

        postBTN.anchor(
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            height: 90
        )
    }
    
    private func setupNavigationTitle() {
        navigationItem.title = "책 걸이 만들기"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: {
                self.postBTN.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 25)
            })
        }
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.postBTN.transform = .identity
        })
    }
    
    @objc func tapNextBTN() {
        postData.book = bookTitleField.text
        postData.text = textContent.text
//        self.navigationController?.popToRootViewController(animated: true)
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
   
}

extension PostingWritingViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == textViewPlaceHolder) {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if (textView.text == textViewPlaceHolder) ||
            (textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)  {
            postBTN.isEnabled = false
            postBTN.backgroundColor = .brown1
        } else {
            postBTN.isEnabled = true
            postBTN.backgroundColor = .brown2
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = .gray
        }
    }
}
