//
//  ContainerViewController.swift
//  HikingAI
//
//  Created by Yaroslav Spirin on 16/11/2019.
//  Copyright © 2019 Yaroslav Spirin. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    @IBAction func selectButtonTapped(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: MagneticViewController.self)) else {
            return
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func backItemTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    let dataSource = ["nuuksio_huy", "pallas_huy"]
    
    var currentViewControllerIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSelectButton()
        configureContainerView()
        configureNavigationBar()
        configurePageViewController()
    }
    
    private func configureSelectButton() {
        self.selectButton.layer.cornerRadius = 6.0
    }
    
    private func configureContainerView() {
        self.containerView.clipsToBounds = true
    }
    
    private func configureNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .systemIndigo
        self.navigationItem.title = "Select National Park"
        self.navigationItem.hidesBackButton = true
    }
    
    private func configurePageViewController() {
        
        guard let pageVC = storyboard?.instantiateViewController(withIdentifier: String(describing: MovePageViewController.self)) as? MovePageViewController else {
            return
        }
        
        pageVC.delegate = self
        pageVC.dataSource = self
        
        addChild(pageVC)
        pageVC.didMove(toParent: self)
        
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(pageVC.view)
        
        let views : [String : Any] = ["pageView" : pageVC.view as Any]
        
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[pageView]-0-|",
                                                                    options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                    metrics: nil,
                                                                    views: views))
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[pageView]-0-|",
                                                                    options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                    metrics: nil,
                                                                    views: views))
        
        guard let startingViewController = detailViewControllerAt(index: currentViewControllerIndex) else {
            return
        }
        
        pageVC.setViewControllers([startingViewController], direction: .forward, animated: true)
    }
    
    func detailViewControllerAt(index: Int) -> DataViewController? {
        
        guard let dataVC = storyboard?.instantiateViewController(withIdentifier: String(describing: DataViewController.self)) as? DataViewController else {
            return nil
        }
        
        dataVC.index = index
        UserDefaults.standard.set(dataSource[dataVC.index], forKey: "park")
        dataVC.imagePath = dataSource[index]
        
        return dataVC
    }
}

extension ContainerViewController : UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentViewControllerIndex
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return dataSource.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let dataVC = viewController as? DataViewController
        
        guard var currentIndex = dataVC?.index else {
            return nil
        }
        
        currentViewControllerIndex = currentIndex
        
        if currentIndex == 0 {
            return nil
        }
        
        currentViewControllerIndex = currentIndex
        currentIndex -= 1
        
        return detailViewControllerAt(index: currentIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let dataVC = viewController as? DataViewController
        
        guard var currentIndex = dataVC?.index else {
            return nil
        }
        
        if currentIndex + 1 == dataSource.count {
            return nil
        }
        
        currentIndex += 1
        currentViewControllerIndex = currentIndex
        
        return detailViewControllerAt(index: currentViewControllerIndex)
    }
}
