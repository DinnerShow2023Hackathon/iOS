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
    var text: String?
    var book: String?
}

class PostingImageViewController: UIViewController {
    
    private var postData : CellItem = CellItem()
    private var imageBool = false
    
    private var titleText: UILabel = {
        $0.text = "인상깊었던 책 한 쪽을 올려주세요"
        $0.textAlignment = .center
        $0.font = UIFont(name: "KimjungchulMyungjo-Regular", size: 20.0)
        $0.textColor = .brown2
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private let pinImage: UIImageView = {
        $0.image = UIImage(named: "pinImage")
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = true
        return $0
    }(UIImageView())
    
    private let bookImage: UIImageView = {
        $0.image = UIImage(named: "Test04")
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = true
        return $0
    }(UIImageView())
    
    private let nextBTN: UIButton = {
        $0.backgroundColor = .brown1
        $0.isEnabled = false
        $0.setTitle("다음", for: .normal)
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(tapNextBTN), for: .touchUpInside)
        return $0
    }(UIButton())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        setupNavigationTitle()
        
        self.view.addSubview(titleText)
        titleText.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 50,
            paddingLeft: 50,
            paddingRight: 50,
            height: 35
        )
        
        self.view.addSubview(nextBTN)
        nextBTN.anchor(
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            height: 90
        )
        
        self.view.addSubview(pinImage)
        pinImage.anchor(
            top: titleText.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: nextBTN.topAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingLeft: 10,
            paddingRight: 10
        )
        
        
        self.view.addSubview(bookImage)
        bookImage.anchor(
            top: pinImage.topAnchor,
            left: pinImage.leftAnchor,
            bottom: pinImage.bottomAnchor,
            right: pinImage.rightAnchor,
            paddingLeft: 10,
            paddingRight: 10
        )
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchToPickPhoto))
        bookImage.addGestureRecognizer(tapGesture)
    }
    
    private func setupNavigationTitle() {
        navigationItem.title = "책 걸이 만들기"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @objc func tapNextBTN() {
        let PostingViewController = PostingWritingViewController()
        PostingViewController.postData = postData
        navigationController?.pushViewController(PostingViewController, animated: true)
    }
    
    @objc func touchToPickPhoto() {
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
    
    private func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        var scale = 0.0
        var newHeight = 0.0

        if newWidth < image.size.width {
            scale = newWidth / image.size.width
            newHeight = image.size.height * scale
            UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
            image.draw(in: CGRectMake(0, 0, newWidth, newHeight))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage!
        }
        return image
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
                        self?.nextBTN.backgroundColor = .brown2
                        self?.nextBTN.isEnabled = true
                        self?.postData = CellItem(image: image,
                                                  path: self!.resizeImage(image: image, newWidth: 800).jpegData(compressionQuality: 1.0))
                        self?.bookImage.image = image
                    }
                }
            }
        }
    }
}

