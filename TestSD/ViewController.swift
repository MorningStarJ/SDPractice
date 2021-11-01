//
//  ViewController.swift
//  TestSD
//
//  Created by pingtouge on 2021/11/2.
//

import UIKit
import SDWebImageWebPCoder

class ViewController: UIViewController {
    private enum Dimensions {
        static var itemSize: CGSize {
            let horizontallyEdge: CGFloat = 5
            let itemRatio: CGFloat = 115 / 200
            let column: CGFloat = 3
            let itemWidth: CGFloat = ((UIScreen.main.bounds.width - horizontallyEdge * (column + 1)) / column).rounded(.towardZero)
            let itemHeight: CGFloat = itemWidth / itemRatio
            return CGSize(width: itemWidth, height: itemHeight)
        }
    }
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout! {
        didSet {
            flowLayout.itemSize = Dimensions.itemSize
        }
    }
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "Cell")
        }
    }
    
    let dataArray =  [
        "http://www.httpwatch.com/httpgallery/authentication/authenticatedimage/default.aspx?0.35786508303135633",     // requires HTTP auth, used to demo the NTLM auth
        "http://assets.sbnation.com/assets/2512203/dogflops.gif",
        "https://raw.githubusercontent.com/liyong03/YLGIFImage/master/YLGIFImageDemo/YLGIFImageDemo/joy.gif",
        "http://apng.onevcat.com/assets/elephant.png",
        "http://www.ioncannon.net/wp-content/uploads/2011/06/test2.webp",
        "https://swapface.mycolordiary.com/s/img/fd5c691aaca58d8ed7c87b950c23ae74",
        "https://swapface.mycolordiary.com/s/img/18fa464e31922aa531ee2ac57ed11cbf",
        "http://www.ioncannon.net/wp-content/uploads/2011/06/test9.webp",
        "http://littlesvr.ca/apng/images/SteamEngine.webp",
        "http://littlesvr.ca/apng/images/world-cup-2014-42.webp",
        "https://isparta.github.io/compare-webp/image/gif_webp/webp/2.webp",
        "https://nokiatech.github.io/heif/content/images/ski_jump_1440x960.heic",
        "https://nokiatech.github.io/heif/content/image_sequences/starfield_animation.heic",
        "https://s2.ax1x.com/2019/11/01/KHYIgJ.gif",
        "https://raw.githubusercontent.com/icons8/flat-color-icons/master/pdf/stack_of_photos.pdf",
        "https://nr-platform.s3.amazonaws.com/uploads/platform/published_extension/branding_icon/275/AmazonS3.png",
        "http://via.placeholder.com/200x200.jpg"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCell
        
        cell.imageView
            .sd_setImage(with: URL(string: dataArray[indexPath.row]),
                         placeholderImage: nil,
                         options: [.retryFailed],
                         context: [.imageThumbnailPixelSize:
                                    CGSize(width: Int(cell.bounds.size.width),
                                           height: Int(cell.bounds.size.height))])
        { receivedSize, expectedSize, targetUrl in
            
        } completed: { image, error, from, url in
            if let e = error {
                print(e)
            }
        }
        return cell
    }
}

class CustomCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imageView: SDAnimatedImageView = {
        let iv = SDAnimatedImageView()
        iv.shouldIncrementalLoad = true
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
}
