//
//  PostingWritingView.swift
//  Samsam
//
//  Created by creohwan on 2022/10/19.
//

import UIKit
import PhotosUI

class PostingWritingViewController: UIViewController {
    
    private var textViewPlaceHolder = "고객을 위해 쉽고 자세하게 설명해주세요."
    
    // MARK: - View

    private var textTitle: UILabel = {
        $0.text = "작업내용을 작성해주세요"
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private let exampleLabel: UILabel = {
        $0.text = """
                    예시)
                    - 거실 바닥 장판 철거, PE폼 깔기
                    - 강화마루 설치
                    - 특이사항 없음
                    - 작업인원 0명
                    """
        $0.numberOfLines = 0
        $0.textColor = .gray
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return $0
    }(UILabel())

    private lazy var textContent: UITextView = {
        let linestyle = NSMutableParagraphStyle()
        linestyle.lineSpacing = 4.0
        $0.typingAttributes = [.paragraphStyle: linestyle]
        $0.backgroundColor = .clear
        $0.text = textViewPlaceHolder
        $0.textColor = .lightGray
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
        $0.backgroundColor = .orange
        $0.setTitle("작성 완료", for: .normal)
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(tapNextBTN), for: .touchUpInside)
        return $0
    }(UIButton())
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        hidekeyboardWhenTappedAround()
        attribute()
        layout()
        setupNotificationCenter()
    }
    
    private func attribute() {
        view.backgroundColor = .lightGray
        setupNavigationTitle()
    }
    
    private func layout() {
        self.view.addSubview(textTitle)
        self.view.addSubview(exampleLabel)
        self.view.addSubview(shadowView)
        self.shadowView.addSubview(textContent)
        self.view.addSubview(postBTN)
    
        textTitle.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 20,
            paddingLeft: 16,
            paddingRight: 16
        )
        
        exampleLabel.anchor(
            top: textTitle.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 10,
            paddingLeft: 16,
            paddingRight: 16
        )
        
        shadowView.anchor(
            top: exampleLabel.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 10,
            paddingLeft: 16,
            paddingRight: 16,
            height: 240
        )

        textContent.anchor(
            left: shadowView.leftAnchor,
            right: shadowView.rightAnchor,
            height: 240
        )

        postBTN.anchor(
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            height: 90
        )
    }
    
    private func setupNavigationTitle() {
        navigationItem.title = "시공 상황 작성"
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
        self.navigationController?.popToRootViewController(animated: true)
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
            postBTN.backgroundColor = .gray
        } else {
            postBTN.isEnabled = true
            postBTN.backgroundColor = .blue
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = .lightGray
            
        }
    }
}
