import UIKit

import SnapKit

class PostImageView: UIViewController {
    
    // MARK: - View
    
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
    
    let closeBtn = UIButton().then{
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
        $0.setImage(UIImage(systemName: "xmark.circle", withConfiguration: imageConfig)?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
    }
    
    private func pressBtn(){
        closeBtn.press {
        
            let vc = UserGuideViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion:nil)
        }
    }
    
    // MARK: - Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        attribute()
        layout()
    }
    
    private func attribute() {
        postImage.frame = scrollView.bounds

    }
    
    private func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(postImage)
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

