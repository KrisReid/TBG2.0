//
//  PlayerDetailViewController.swift
//  TBG2
//
//  Created by Kris Reid on 02/12/2019.
//  Copyright © 2019 Kris Reid. All rights reserved.
//

import UIKit

class PlayerDetailViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var ivPlayerIProfilePic: UIImageView!
    @IBOutlet weak var lblPlayerName: UILabel!
    @IBOutlet weak var lblPlayerAge: UILabel!
    @IBOutlet weak var lblPlayerPosition: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var vScrollView: UIView!
    
    var playerProfilePic: UIImage = UIImage()
    var playerName: String = String()
    var playerAge: Int = Int()
    var playerPosition: String = String()
    
    var slides:[Slide] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ivPlayerIProfilePic.layer.cornerRadius = ivPlayerIProfilePic.frame.width / 2
        ivPlayerIProfilePic.layer.masksToBounds = true
        ivPlayerIProfilePic.layer.borderWidth = 1.0
        ivPlayerIProfilePic.layer.borderColor = UIColor( red: 98/255, green: 190/255, blue:204/255, alpha: 1.0 ).cgColor
        
        ivPlayerIProfilePic.image = playerProfilePic
        lblPlayerName.text = playerName
        lblPlayerAge.text = "\(playerAge) years old"
        lblPlayerPosition.text = playerPosition
        
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        
        scrollView.delegate = self
        
        vScrollView.layer.shadowColor = UIColor.black.cgColor
        vScrollView.layer.shadowOpacity = 1
        vScrollView.layer.shadowRadius = 10
        
        
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor( red: 67/255, green: 131/255, blue:140/255, alpha: 1.0 )
        
    }
    
    func createSlides() -> [Slide] {
        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.lblTest.text = "A real-life bear"
        
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.lblTest.text = "A real-life monkey"
        
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.lblTest.text = "A real-life goat"
        
        return [slide1, slide2, slide3]
    }
    
    func setupSlideScrollView(slides : [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: vScrollView.frame.height / 2)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }

}
