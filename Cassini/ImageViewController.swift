//
//  ImageViewController.swift
//  Cassini
//
//  Created by TOPvigoss on 2019/2/21.
//  Copyright © 2019 TOPvigoss. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController , UIScrollViewDelegate {
    var imageURL:URL?{
        didSet{
            image=nil
            if view.window != nil{
                fetchImage()
            }
        }
    }

    

    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        if ImageView.image == nil{
            fetchImage()
        }
    }
    
    private func fetchImage() {
        if let url = imageURL {
            spinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async {[weak self] in
                let data = try? Data.init(contentsOf: url)
                if let imagedata = data ,url == self?.imageURL{
                    DispatchQueue.main.async {
                        self?.image=UIImage.init(data: imagedata)
                    }
                    
                }
                    
            }

            
            
        }
    }
    

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var ScrollView: UIScrollView!{
        didSet{
            ScrollView.addSubview(ImageView)
            ScrollView.maximumZoomScale=4
            ScrollView.minimumZoomScale=1/25
            ScrollView.delegate=self
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return ImageView
    }
    
    var ImageView = UIImageView()
    
    
    private var image:UIImage?{
        get {
            return ImageView.image
        }
        set {
            ImageView.image=newValue
            ImageView.sizeToFit()
            ScrollView?.contentSize=ImageView.frame.size
            spinner?.stopAnimating()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        if imageURL == nil {
//            imageURL = URL.init(string: "https://y1.ifengimg.com/4c275ba6e7227b2d/2015/0818/rdn_55d2d58cc8c91.jpg")
//        }
    }


}
