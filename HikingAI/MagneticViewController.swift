//
//  MagneticViewController.swift
//  HikingAI
//
//  Created by Yaroslav Spirin on 16/11/2019.
//  Copyright © 2019 Yaroslav Spirin. All rights reserved.
//

import UIKit
import Magnetic

class MagneticViewController: UIViewController {
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        for bubble in bubbles {
            if let initialColor = bubble.initialColor {
                bubble.isSelected = false
                bubble.color = initialColor
            }
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: MapViewController.self)) else {
            return
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBOutlet weak var magneticView: MagneticView! {
        didSet {
            magnetic.magneticDelegate = self
        }
    }
    
    var magnetic: Magnetic {
        return magneticView.magnetic
    }
    
    @IBOutlet weak var magneticContainer: UIView!
    
    var bubbles = [ColoredNode]()
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBubbles()
    }
    
    private func configureBubbles() {
        let hikingNode = ColoredNode(text: "Hiking",
                                     image: UIImage(named: "hiking"),
                                     color: .red,
                                     radius: 45.0)
        hikingNode.initialColor = .red
        bubbles.append(hikingNode)
        
        let cyclingNode = ColoredNode(text: "Cycling",
                                     image: UIImage(named: "cycling"),
                                     color: .blue,
                                     radius: 55.0)
        cyclingNode.initialColor = .blue
        bubbles.append(cyclingNode)
        
        let skiingNode = ColoredNode(text: "Skiing",
                                     image: UIImage(named: "skiing"),
                                     color: .green,
                                     radius: 65.0)
        skiingNode.initialColor = .green
        bubbles.append(skiingNode)
        
        let fireplaceNode = ColoredNode(text: "Fireplace",
                                        image: UIImage(named: "fireplace"),
                                        color: .brown,
                                        radius: 60.0)
        fireplaceNode.initialColor = .brown
        bubbles.append(fireplaceNode)
        
        let fishingNode = ColoredNode(text: "Fishing",
                                      image: UIImage(named: "fishing"),
                                      color: .cyan,
                                      radius: 45.0)
        fishingNode.initialColor = .cyan
        bubbles.append(fishingNode)
        
        let beginnerNode = ColoredNode(text: "Beginner",
                                       image: UIImage(named: "beginner"),
                                        color: .systemIndigo,
                                        radius: 30.0)
        beginnerNode.initialColor = .systemIndigo
        bubbles.append(beginnerNode)
        
        let viewpointsNode = ColoredNode(text: "Viewpoints",
                                         image: UIImage(named: "viewpoints"),
                                         color: .systemTeal,
                                         radius: 55.0)
        viewpointsNode.initialColor = .systemTeal
        bubbles.append(viewpointsNode)
        
        let canoeingNode = ColoredNode(text: "Canoeing",
                                       image: UIImage(named: "canoeing"),
                                       color: .orange,
                                       radius: 40.0)
        canoeingNode.initialColor = .orange
        bubbles.append(canoeingNode)
        
        let runningNode = ColoredNode(text: "Running",
                                    image: UIImage(named: "running"),
                                    color: .gray,
                                    radius: 50.0)
        runningNode.initialColor = .gray
        bubbles.append(runningNode)
        
        bubbles.forEach {
            magnetic.addChild($0)
        }
    }
}

extension MagneticViewController : MagneticDelegate {
    func magnetic(_ magnetic: Magnetic, didSelect node: Node) {
        node.color = .white
        return
    }
    
    func magnetic(_ magnetic: Magnetic, didDeselect node: Node) {
        guard let node = node as? ColoredNode,
            let initialColor = node.initialColor else {
            return
        }
        
        node.color = initialColor
    }
}
