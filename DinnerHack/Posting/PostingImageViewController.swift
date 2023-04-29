//
//  PostingImageViewController.swift
//  Samsam
//
//  Created by creohwan on 2022/10/18.
//
import UIKit
import PhotosUI

struct CellItem {
    var image: UIImage?
    var path: Data?
}

class PostingImageViewController: UIViewController {
    
    private var titleText: UILabel = {
        $0.text = "책 사진 올리세요"
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.textColor = .lightGray
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private let bookImage: UIImageView = {
        $0.image = UIImage(named: "Test04")
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = true
        return $0
    }(UIImageView())
    
    private let nextBTN: UIButton = {
        $0.backgroundColor = .lightGray
        $0.setTitle("다음", for: .normal)
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(tapNextBTN), for: .touchUpInside)
        return $0
    }(UIButton())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        
        self.view.addSubview(titleText)
        titleText.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 12,
            paddingLeft: 50,
            paddingRight: 50,
            height: 50
        )
        
        self.view.addSubview(nextBTN)
        nextBTN.anchor(
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            height: 90
        )
        
        self.view.addSubview(bookImage)
        bookImage.anchor(
            top: titleText.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: nextBTN.topAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingLeft: 30,
            paddingRight: 30
        )
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchToPickPhoto))
        bookImage.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapNextBTN() {
        let PostingViewController = PostingWritingViewController()
        navigationController?.pushViewController(PostingViewController, animated: true)
    }
    
    @objc func touchToPickPhoto() {
        print("yes")
        uploadPhoto()
    }
    
    @objc func uploadPhoto() {
        var configure = PHPickerConfiguration()
        configure.selectionLimit = 1
        configure.selection = .ordered
        configure.filter = .images
        let picker = PHPickerViewController(configuration: configure)
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
}

extension PostingImageViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)

        for result in results.reversed() {
            let itemProvider = result.itemProvider
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self](image, error) in
                    DispatchQueue.main.async {
                        guard let image = image as? UIImage else { return }
                        self?.bookImage.image = image

                    }
                }
            }
        }
    }
}

