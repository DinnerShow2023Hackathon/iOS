import UIKit

import SnapKit

protocol PostImageViewControllerDelegate: AnyObject {
    func popToPostViewController()
}

class PostImageView: UIViewController {
    
    // MARK: - View
    
    weak var delegate: PostImageViewControllerDelegate?
    
    private lazy var scrollView: UIScrollView = {
        $0.frame = self.view.frame
        $0.zoomScale = 1.0
        $0.minimumZoomScale = 1.0
        $0.maximumZoomScale = 3.0
        $0.contentInsetAdjustmentBehavior = .never
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .black
        $0.delegate = self
        return $0
    }(UIScrollView())
    
    var postImage: UIImageView = {
        $0.image = UIImage(named: "test04")
        $0.isUserInteractionEnabled = true
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    // MARK: - Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
    }
    
    private func attribute() {
        postImage.frame = scrollView.bounds
        
        navigationItem.leftBarButtonItem = backBarButton(#selector(didTapBackButton))
    }
    
    private func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(postImage)
    }
    
    @objc func didTapBackButton() {
        delegate?.popToPostViewController()
    }
}

extension PostImageView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.postImage
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1 {
            guard let image = postImage.image else { return }
            guard let zoomView = viewForZooming(in: scrollView) else { return }
          
            let ratio = zoomView.frame.width / image.size.width

            let newHeight = image.size.height * ratio

            let top = 0.5 * ((newHeight * scrollView.zoomScale > zoomView.frame.height) ? (newHeight - zoomView.frame.height) : (scrollView.frame.height - scrollView.contentSize.height))

            scrollView.contentInset = UIEdgeInsets(top: top.rounded(), left: 0, bottom: top.rounded(), right: 0)
        } else {
            scrollView.contentInset = .zero
        }
    }
}

