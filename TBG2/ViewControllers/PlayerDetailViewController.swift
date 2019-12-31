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
    
    var colours = Colours()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ivPlayerIProfilePic.circle(colour: colours.primaryBlue.cgColor)
        
        ivPlayerIProfilePic.image = playerProfilePic
        lblPlayerName.text = playerName
        lblPlayerAge.text = "\(playerAge) years old"
        
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
        pageControl.currentPageIndicatorTintColor = colours.secondaryBlue
        
    }
    
    func createSlides() -> [Slide] {
        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.lblTitle.text = "All Seasons"
        slide1.lblGamesPlayedResult.text = "77"
        slide1.lblMOTMResult.text = "7"
        slide1.lblGoalsScoredResult.text = "14"
        
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.lblTitle.text = "2018 / 2019"
        slide2.lblGamesPlayedResult.text = "25"
        slide2.lblMOTMResult.text = "2"
        slide2.lblGoalsScoredResult.text = "3"
        
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.lblTitle.text = "2017 / 2018"
        slide3.lblGamesPlayedResult.text = "52"
        slide3.lblMOTMResult.text = "5"
        slide3.lblGoalsScoredResult.text = "11"
        
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
