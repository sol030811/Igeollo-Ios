//
//  ViewController.swift
//  ios Igeollo
//
//  Created by 강희원 on 6/5/25.
//

import UIKit

class AppmainViewController: UIViewController {
    
    @IBOutlet var mainTitle: UILabel!
    
    @IBOutlet var Aibtn: UIButton!
    @IBOutlet var timebtn: UIButton!
    @IBOutlet var foodbtn: UIButton!
    @IBOutlet var hobbybtn: UIButton!
    @IBOutlet var timerbtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func Aibtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let aiVC = storyboard.instantiateViewController(withIdentifier: "AiViewController") as? AiViewController {
            navigationController?.pushViewController(aiVC, animated: true)
        }
    }
    
    @IBAction func timebtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "TimeViewController") as? TimeViewController{
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func foodbtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let foodMainVC = storyboard.instantiateViewController(withIdentifier: "FoodmainViewController") as? FoodmainViewController {
            navigationController?.pushViewController(foodMainVC, animated: true)
        }
    }
    
    @IBAction func hobbybtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let hobbyVC = storyboard.instantiateViewController(withIdentifier: "HobbyViewController") as? HobbyViewController {
            navigationController?.pushViewController(hobbyVC, animated: true)
        }
    }
    
    @IBAction func timerbtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let timerVC = storyboard.instantiateViewController(withIdentifier: "TimerViewController") as? TimerViewController {
            navigationController?.pushViewController(timerVC, animated: true)
        }
    }
    
}

