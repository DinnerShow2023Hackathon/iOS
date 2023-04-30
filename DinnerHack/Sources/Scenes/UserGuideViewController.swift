//
//  UserGuideViewController.swift
//  DinnerHack
//
//  Created by creohwan on 2023/04/30.
//

import UIKit

class UserGuideViewController: UIViewController {
    
    private var textTitle: UILabel = {
        $0.text = "책걸이 사용 설명서"
        $0.textAlignment = .center
        $0.font = UIFont(name: "KimjungchulMyungjo-Regular", size: 20.0)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private var textViewPlaceHolder = """
1. 책을 읽는다, 고독을 음미하며
2. 기부하고 싶은 책을 가장 인상 깊었던 페이지와 함께 등록한다.
3. 이웃들이 무슨 책을 읽나 둘러보다 마음에 드는 대목을 발견한다
4. 기부자에게 연락한다.
5. 둘은 커피를 마시고 책을 주고 받는다.

공유 활동에 직접적으로 참여하지 않더라도
주변 사람들이 감명 깊게 읽은 한 페이지들을 즐긴다 :)
"""
    
    
    let closeBtn = UIButton().then{
        $0.setImage(UIImage(named: "closeBtn"), for: .normal)
    }
    
    private func pressBtn(){
        closeBtn.press {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
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
        $0.text = textViewPlaceHolder
        $0.textColor = .gray
        $0.font = UIFont(name: "KimjungchulMyungjo-Regular", size: 16.0)
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
        pressBtn()
        
        view.addSubview(textTitle)
        textTitle.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 120,
            paddingLeft: 20,
            paddingRight: 20
        )
        
        view.addSubview(shadowView)
        shadowView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 200,
            paddingLeft: 16,
            paddingRight: 16,
            height: 300
        )
        
        self.shadowView.addSubview(textContent)
        textContent.anchor(
            left: shadowView.leftAnchor,
            right: shadowView.rightAnchor,
            height: 300
        )
        
        view.addSubview(closeBtn)
        closeBtn.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 20,
            paddingRight: 20
        )
        
        
        
    }
    

}
