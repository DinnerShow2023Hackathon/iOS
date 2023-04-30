//
//  LoginVC.swift
//  DinnerHack
//
//  Created by saint on 2023/04/30.
//

import UIKit
import SnapKit
import Then
import Moya

class LoginVC: UIViewController {
    
    var checkTextfield : Bool = false
    
    private let appLabel = UILabel().then{
        $0.text = "책거리"
        $0.textColor = .brown2
        $0.font = UIFont(name: "MapoFlowerIsland", size: 36.0)
    }
    
    private let introLabel = UILabel().then{
        $0.text = "당신의 한 페이지는 무엇인가요?"
        $0.textColor = .brown2
        $0.font = UIFont(name: "MapoFlowerIsland", size: 18.0)
    }
    
    private let idTextField = UITextField().then{
        $0.backgroundColor = .clear
        $0.placeholder = "카톡 아이디"
        $0.font = UIFont(name: "MapoFlowerIsland", size: 20.0)
        $0.textColor = .brown1
    }
    
    private let idUnderLine = UIView().then{
        $0.backgroundColor = .brown1
    }
    
    private let phoneTextField = UITextField().then{
        $0.backgroundColor = .clear
        $0.placeholder = "휴대폰 번호"
        $0.font = UIFont(name: "MapoFlowerIsland", size: 20.0)
        $0.textColor = .brown1
    }
    
    private let phoneUnderLine = UIView().then{
        $0.backgroundColor = .brown1
    }
    
    private let loginBtn = UIButton().then {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.brown2.cgColor
        $0.titleLabel?.font = UIFont(name: "MapoFlowerIsland", size: 18.0)
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.brown2, for: .normal)
        $0.isUserInteractionEnabled = false
    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        pressBtn()
        phoneTextField.delegate = self
    }

}

extension LoginVC{
    func setLayout(){
        view.backgroundColor = .bg
        view.addSubViews([appLabel, introLabel, idTextField, idUnderLine, phoneTextField, phoneUnderLine, loginBtn])
        
        appLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(245)
            $0.centerX.equalToSuperview()
        }
        
        introLabel.snp.makeConstraints{
            $0.top.equalTo(appLabel.snp.bottom).offset(37)
            $0.centerX.equalToSuperview()
        }
        
        idTextField.snp.makeConstraints{
            $0.top.equalTo(appLabel.snp.bottom).offset(69)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(288)
            $0.height.equalTo(60)
        }
        
        idUnderLine.snp.makeConstraints{
            $0.bottom.equalTo(idTextField.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(288)
            $0.height.equalTo(1)
        }
        
        phoneTextField.snp.makeConstraints{
            $0.top.equalTo(idTextField.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(288)
            $0.height.equalTo(60)
        }
        
        phoneUnderLine.snp.makeConstraints{
            $0.bottom.equalTo(phoneTextField.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(288)
            $0.height.equalTo(1)
        }
        
        loginBtn.snp.makeConstraints{
            $0.top.equalTo(phoneUnderLine.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(107)
            $0.height.equalTo(44)
        }
    }
    
    func pressBtn(){
        loginBtn.press {
            self.dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: NSNotification.Name("DismissLoginView"), object: nil, userInfo: nil)
        }
    }
}

// MARK: - UITextFieldDelegate
extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.becomeFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            checkTextfield = false
        }else{
            checkTextfield = true
            print(1)
            loginBtn.titleLabel?.font = UIFont(name: "MapoFlowerIsland", size: 18.0)
            loginBtn.setTitleColor(.white, for: .normal)
            loginBtn.isUserInteractionEnabled = true
            loginBtn.backgroundColor = .brown2
        }   }
}
