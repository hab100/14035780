//
//  GameViewController.swift
//  FORMULAH1
//
//  Created by HAB on 03/04/2018.
//  Copyright © 2018 HAB. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
protocol subviewDelegate {
    func changesomething()
}

class GameViewController: UIViewController, subviewDelegate {
    
    @IBOutlet weak var Finalscore: UILabel!
    @IBOutlet weak var RUN: UIButton!
  
    var dynamicAnimator: UIDynamicAnimator!
    var dIBehaviour: UIDynamicItemBehavior!
    var gBehaviour: UIGravityBehavior!
    var cBehaviour: UICollisionBehavior!
    var gamecar: [UIImageView] = []
    var score = 0;
    var scoreArray: [UIImageView] = []
    let Gameover = UIImageView(image: nil)
  
         let CarArray = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
        
    @IBOutlet weak var CAR: Draggedimage!
    @IBOutlet weak var ROAD: UIImageView!
    
    @IBAction func REPLAY(_ sender: Any) {
        Finalscore.text = ""
        score = 0;
        Gameover.isHidden = true
        RUN.isHidden = true
        
        for i in gamecar {
            i.removeFromSuperview()
        }
        viewDidLoad()
    }
    func changesomething()
    {
        cBehaviour.removeAllBoundaries()
        cBehaviour.addBoundary(withIdentifier:" player" as NSCopying, for: UIBezierPath(rect: CAR.frame))
        
        
        for cars in scoreArray{
            if(CAR.frame.intersects(cars.frame)){
                score = score - 3
                self.Finalscore.text = String(self.score)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        var imageArray: [UIImage]!
        imageArray = [UIImage(named: "road1.png")!,
                      UIImage(named: "road2.png")!,
                      UIImage(named: "road3.png")!,
                      UIImage(named: "road4.png")!,
                      UIImage(named: "road5.png")!,
                      UIImage(named: "road6.png")!,
                      UIImage(named: "road7.png")!,
                      UIImage(named: "road8.png")!,
                      UIImage(named: "road9.png")!,
                      UIImage(named: "road10.png")!,
                      UIImage(named: "road11.png")!,
                      UIImage(named: "road12.png")!,
                      UIImage(named: "road13.png")!,
                      UIImage(named: "road14.png")!,
                      UIImage(named: "road15.png")!,
                      UIImage(named: "road16.png")!,
                      UIImage(named: "road17.png")!,
                      UIImage(named: "road18.png")!,
                      UIImage(named: "road19.png")!,
                      UIImage(named: "road20.png")!]
        
        self.ROAD.image = UIImage.animatedImage(with: imageArray, duration: 0.15)
        
        CAR.myDelegate = self
        
        self.view.addSubview(CAR)
        self.view.bringSubview(toFront: CAR)
        
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        dIBehaviour = UIDynamicItemBehavior(items: [])
        cBehaviour = UICollisionBehavior(items: [])
        
        for index in 0...19 {
            let delay = Double(self.CarArray[index])
            let when = DispatchTime.now() + delay
            
            DispatchQueue.main.asyncAfter(deadline: when){
                
                let obstacle = arc4random_uniform(6)
                let obstacleimage = UIImageView(image: nil)
                let screenwidth = UIScreen.main.bounds.width
                
                switch obstacle{
                case 1: obstacleimage.image = UIImage(named: "car6.png")
                case 2: obstacleimage.image = UIImage(named: "car5.png")
                case 3: obstacleimage.image = UIImage(named: "car3.png")
                case 4: obstacleimage.image = UIImage(named: "car2.png")
                case 5: obstacleimage.image = UIImage(named: "car1.png")
                    
                default:
                    obstacleimage.image = UIImage(named: "car6.png")
                    
                }
                obstacleimage.frame = CGRect(x: Int(arc4random_uniform(UInt32(screenwidth))), y:0, width: 40, height:65 )
                
                self.view.addSubview(obstacleimage)
                self.view.bringSubview(toFront: obstacleimage)
                
                self.dIBehaviour.addItem(obstacleimage)
                self.dIBehaviour.addLinearVelocity(CGPoint(x:0, y:300),for: obstacleimage)
                self.cBehaviour.addItem(obstacleimage)
                
                
                self.scoreArray.append((obstacleimage))
                self.score += 3
                self.Finalscore.text = String(self.score)
                
            }
        }
        
        
        dynamicAnimator.addBehavior(dIBehaviour)
        cBehaviour = UICollisionBehavior(items:[])
        cBehaviour.translatesReferenceBoundsIntoBoundary = false
        dynamicAnimator.addBehavior(cBehaviour)
        
        let end = DispatchTime.now() + 20
        DispatchQueue.main.asyncAfter(deadline: end) {
            
            self.Gameover.isHidden = false
            self.RUN.isHidden = false
            self.Gameover.image = UIImage (named: "game_over.jpg")
            self.Gameover.frame = UIScreen.main.bounds
            self.view.addSubview(self.Gameover)
            self.view.bringSubview(toFront: self.Gameover)
            self.view.bringSubview(toFront: self.RUN)
            
        }
        
    }
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    }
    

}

