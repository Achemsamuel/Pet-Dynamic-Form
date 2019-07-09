//
//  PetSuperViewController.swift
//  Pet-Dynamic-Form
//
//  Created by Achem Samuel on 7/7/19.
//  Copyright © 2019 Achem Samuel. All rights reserved.
//

import UIKit
import ChameleonFramework
import LabelSwitch
import SnapKit


class PetSuperViewController: UIViewController, UIScrollViewDelegate {

    private var pageViewController : UIPageViewController?
    
    private  var pageViewControllers: [UIViewController] = []
    
    private let pageControl = UIPageControl()
    
    private var currentPage: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil
        )
        self.pageViewController?.dataSource = self
        self.pageViewController?.delegate = self
    
        self.addChild(self.pageViewController!)
        self.view.addSubview(self.pageViewController!.view)
        self.pageViewController?.didMove(toParent: self)
        self.pageViewController?.view.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
    
        parseJson.getPetJsonData { (result) in
            setupPageViewController(response: result)
        }
        
        setupPageControl()
        
    }
    
    let parseJson = Parsejson()
    
    func setupPageViewController(response : Pet) {
        navigationItem.title = response.name
        for page in response.pages! {
            let vc = PageViewController(label: page.label ?? "empty", sections: page.sections ?? [])
            pageViewControllers.append(vc)
            
        }
        
        for vc in pageViewControllers {
            self.pageViewController?.addChild(vc)
            vc.didMove(toParent: pageViewController)
        }
        
        guard let firstVC = pageViewControllers.first  else {
            fatalError()
        }
        self.pageViewController?.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        
    }
    
    
    /*-----------------------------------
     Mark: Page Control
     -----------------------------------*/
    
    private func setupPageControl() {
        pageControl.numberOfPages = pageViewControllers.count
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.isUserInteractionEnabled = false
        pageControl.pageIndicatorTintColor = UIColor(hexString: "7e57c2")
        view.insertSubview(pageControl, at: 0)
        view.bringSubviewToFront(pageControl)
        
        pageControl.snp.makeConstraints { (make) in
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.centerX.equalTo(view)
            
            //make.bottom.equalTo(view.snp.bottom).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(8)
        }
    }
    
    
    /*-----------------------------------
     Mark: ScrollViewD Methods
     -----------------------------------*/
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if currentPage == 0 &&
            scrollView.contentOffset.x < scrollView.bounds.size.width {
            
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
        } else if currentPage == pageViewControllers.count - 1 &&
            scrollView.contentOffset.x > scrollView.bounds.size.width {
            
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
        }
    }
    
     func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
        ) {
        
        if currentPage == 0 &&
            scrollView.contentOffset.x <= scrollView.bounds.size.width {
            
            targetContentOffset.pointee = CGPoint(x: scrollView.bounds.size.width, y: 0)
        } else if currentPage == pageViewControllers.count - 1 &&
            scrollView.contentOffset.x >= scrollView.bounds.size.width {
            
            targetContentOffset.pointee = CGPoint(x: scrollView.bounds.size.width, y: 0)
        }
    }
    

}



/*-----------------------------------
 Mark: UIPageViewControllerDelegate
 -----------------------------------*/

extension PetSuperViewController : UIPageViewControllerDelegate {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageViewControllers.count
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        willTransitionTo pendingViewControllers: [UIViewController]
        ) {
        guard let index = pageViewControllers.firstIndex(of: pendingViewControllers[0]) else {
            return
        }
        pageControl.currentPage = index
    }
  
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
        ) {
        
        if !completed {
            // Go back
            guard let index = pageViewControllers.firstIndex(of: previousViewControllers[0]) else {
                return
            }
            
            currentPage = index // see comment above for explanation of why both are needed
            pageControl.currentPage = index
        }
        
        if completed {
            guard let vc = pageViewController.viewControllers?.first,
                let index = pageViewControllers.firstIndex(of: vc) else {
                    return
            }
            
            currentPage = index // see comment above for explanation of why both are needed
            pageControl.currentPage = index
        }
    }


}

/*------------------------------------
 Mark: UIPageViewControllerDataSource
 -------------------------------------*/

extension PetSuperViewController : UIPageViewControllerDataSource {
  
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
        ) -> UIViewController? {
        
        guard let index = pageViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = index - 1
        if previousIndex < pageViewControllers.count {
            navigationItem.rightBarButtonItem = nil
        }
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        return pageViewControllers[previousIndex]
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
        ) -> UIViewController? {
        
        guard let index = pageViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = index + 1
        
        guard nextIndex < pageViewControllers.count else {
            return nil
        }
        
        return pageViewControllers[nextIndex]
    }
    
    
    
}

