//
//  CassiniViewController.swift
//  Cassini
//
//  Created by TOPvigoss on 2019/2/21.
//  Copyright © 2019 TOPvigoss. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController,UISplitViewControllerDelegate {
    
    override func awakeFromNib() {
        splitViewController?.delegate=self
    }

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        
        if let cvc=secondaryViewController.contents as? ImageViewController{
            if cvc.imageURL==nil{
                return true
            }
        }
        return false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private let urls = ["Cassini":URL(string:"https://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg"),"Earth":URL(string: "https://www.nasa.gov/sites/default/files/wave_earth_mosaic_3.jpg")]
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier{
            if let url = urls[identifier]{
                if let imageVC = segue.destination.contents as? ImageViewController{
                    imageVC.imageURL = url
                    imageVC.title = (sender as? UIButton)?.currentTitle
                }
            }
        }
    
        
        
        
        
    }


}


extension UIViewController{
    var contents:UIViewController{
        if let navcon = self as?UINavigationController{
            return navcon.visibleViewController ?? self
        }else{
            return self
        }
    }
}
