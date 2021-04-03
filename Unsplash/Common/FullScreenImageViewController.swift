//
//  FullScreenImageViewController.swift
//  TSystemsHomeAssignment
//
//  Created by Shikhar Varshney on 5/7/18.
//  Copyright © 2018 Shikhar Varshney. All rights reserved.
//

import UIKit
import AVFoundation

class FullScreenImageViewController: UIViewController {
    
    class func getFullScreenVC() -> FullScreenImageViewController{
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FullScreenImageViewController") as! FullScreenImageViewController
        return vc
    }

    @IBOutlet weak var imgView: UIImageView!
    private var selectedPhoto: UIImage?
    private var fullScreenURL: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showImage()
    }
    
    @IBAction func dismissBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func setupWithPhoto(photo: UIImage, andFullResImg imgUrl: String) {
        selectedPhoto = photo
        fullScreenURL = imgUrl
    }
    
    func showImage(){
        self.imgView.image = selectedPhoto
        // Now setting high res photo
        ImageDownloadManager.sharedInstance.addDownloadTaskFor(urlString: fullScreenURL) { [weak self] (url, image) in
            self?.imgView.image = image
        }

    }
}

extension FullScreenImageViewController: ImageTransitionProtocol {
    
    func tranisitionStarted(){
        imgView.isHidden = true
    }
    
    func tranisitionFinished(){
        imgView.isHidden = false
    }
    
    func imageFrame() -> CGRect{
        let imageRect = AVMakeRect(aspectRatio: imgView.image!.size, insideRect: imgView.bounds)
        return imgView.convert(imageRect, to: view)
    }

}
