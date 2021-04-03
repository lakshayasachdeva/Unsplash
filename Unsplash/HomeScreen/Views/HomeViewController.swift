//
//  HomeViewController.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 02/04/21.
//

import UIKit


public enum ScreenType: Int{
    case search
    case home
}


class HomeViewController: UIViewController, ImagesScreenViewProtocol {
    
    
    
    
    
    // MARK: IBOutlets
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    var imagesArray: [ImageModel]?
    var presenter: ImagesScreenPresenterProtocol?
    private let twoColumnsLayout = ImageColumnFlowLayout(cellsPerRow: 2, minimumInteritemSpacing: 20, minimumLineSpacing: 20, sectionInset: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
    private var currentPage = 1
    private var selectedIndex = 0
    private var selectedImage: UIImage!
    private var animationController = ImageTransitionController()
    private var hasNext = true
    var screenType: ScreenType = .home


    
    
    // MARK: View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionViewCellNibs()
        setupCollectionView()
        HomeScreenModule.create(viewRef: self)
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        setScreenTitle()
    }
    
    func registerCollectionViewCellNibs(){
        imagesCollectionView.register(ImageCollectionViewCell.cellNib, forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier)
        imagesCollectionView.register(SearchBarCollectionReusableView.cellNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader.self, withReuseIdentifier: SearchBarCollectionReusableView.reuseIdentifier)
    }
    
    
    func setScreenTitle(){
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = AppConstants.kHomeScreenTitle
    }
    
    func setupCollectionView(){
        imagesCollectionView.collectionViewLayout = twoColumnsLayout
        twoColumnsLayout.sectionHeadersPinToVisibleBounds = true
        twoColumnsLayout.headerReferenceSize = CGSize(width: self.view.bounds.width, height: AppConstants.kSearchViewHeaderHeight)
        twoColumnsLayout.sectionHeadersPinToVisibleBounds = false
    }
    
    func showImages(withImageData data: [ImageModel]?) {
        guard let newImageData = data else {return}
        let previousCount = self.imagesArray?.count ?? 0
        if imagesArray == nil{
            imagesArray = newImageData
        } else{
            if (data?.count ?? 0) == 0{
                hasNext = false
                return
            } else{
                hasNext = true
                self.imagesArray!.append(contentsOf: newImageData)
            }
        }
        
        if self.currentPage == 1 {
            imagesCollectionView.reloadData()
        }else {
            var indexPaths = [IndexPath]()
            for i in previousCount..<imagesArray!.count {
                let indexPath = IndexPath(item: i, section: 0)
                indexPaths.append(indexPath)
            }
            imagesCollectionView.insertItems(at: indexPaths)
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard segue.identifier == "fullScreenImageSegue" else {
//            return
//        }
//        let destinationVC = segue.destination as! FullScreenImageViewController
//        destinationVC.transitioningDelegate = self
//        destinationVC.setupWithPhoto(photo: selectedImage)
//    }
    
}




//MARK: UICollection view methods
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        cell.imgView.image = nil
        ImageDownloadManager.sharedInstance.addDownloadTaskFor(urlString: imagesArray![indexPath.row].urls!.thumb!) { [weak self] (url, image) in
            if url == self?.imagesArray![indexPath.row].urls!.thumb! {
                cell.imgView.image = image
            }
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind:
                            String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier:
                                                                        SearchBarCollectionReusableView.reuseIdentifier, for: indexPath) as! SearchBarCollectionReusableView
        header.delegate = self
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return header
        default:
            assert(false, "Unexpected element kind")
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == imagesArray!.count - 2 && hasNext == true{
            currentPage = currentPage + 1
            presenter?.getImages(forPageNum: currentPage)
        }
        ImageDownloadManager.sharedInstance.increasePriorityFor(urlString: imagesArray![indexPath.row].urls!.thumb!)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //Check if index path is still valid
        if indexPath.row < imagesArray!.count {
            ImageDownloadManager.sharedInstance.decreasePriorityFor(urlString: imagesArray![indexPath.row].urls!.thumb!)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
        guard let image = cell.imgView.image else {
            return
        }
        selectedIndex = indexPath.row
        selectedImage = image
       // performSegue(withIdentifier: "fullScreenImageSegue", sender: self)
        presenter?.showFullImageScreen(withSelectedImage: selectedImage, andFullImageUrl: imagesArray![indexPath.row].urls!.full!, presentFrom: self)
    }
    
    func setFilterIconVisibility(toBeShown status: Bool, withIamge image: UIImage?) {
        // do nothing...
    }
}



// MARK: Delegates

extension HomeViewController: SearchHeaderViewProtocol{
    
    func didTapOnView() {
        presenter?.showSearchScreen()
    }
    
    
}




extension HomeViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let photoViewController = presented as! FullScreenImageViewController
        animationController.setupImageTransition( image: selectedImage!,
                                                  fromDelegate: self,
                                                  toDelegate: photoViewController)
        return animationController
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let photoViewController = dismissed as! FullScreenImageViewController
        animationController.setupImageTransition( image: selectedImage!,
                                                  fromDelegate: photoViewController,
                                                  toDelegate: self)
        return animationController
    }
}

extension HomeViewController: ImageTransitionProtocol {
    
    func tranisitionStarted() {
        
    }
    
    func tranisitionFinished() {
        
    }
    
    func imageFrame() -> CGRect{
        let indexPath = IndexPath(row: selectedIndex, section: 0)
        let attributes = imagesCollectionView.layoutAttributesForItem(at: indexPath)
        let cellRect = attributes!.frame
        return imagesCollectionView.convert(cellRect, to: self.navigationController?.view)
    }
}

