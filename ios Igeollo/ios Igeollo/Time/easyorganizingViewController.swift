//
//  ViewController.swift
//  easyorganizing
//
//  Created by 강희원 on 6/16/25.
//

import UIKit

class easyorganizingViewController: UIViewController {
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var progressView: UIProgressView!
    
    @IBOutlet var startbtn: UIButton!
    @IBOutlet var pausebtn: UIButton!
    @IBOutlet var resumebtn: UIButton!
    @IBOutlet var resetbtn: UIButton!
    @IBOutlet var youtubebtn: UIButton!
    
    var timer: Timer?
    var totalTime: Int = 300
    var remainingTime: Int = 300
    var isPaused: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        progressView.progress = 0.0
        updateTimeLabel()
        updateButtonStates(started: false, paused: false)
    }
    
    @IBAction func startTimer(_ sender: UIButton) {
        remainingTime = totalTime
        startCountdown()
        updateButtonStates(started: true, paused: false)
    }
    
    @IBAction func pauseTimer(_ sender: UIButton) {
        timer?.invalidate()
        isPaused = true
        updateButtonStates(started: true, paused: true)
    }
    
    @IBAction func resumeTimer(_ sender: UIButton) {
        startCountdown()
        isPaused = false
        updateButtonStates(started: true, paused: false)
    }
    
    @IBAction func resetTimer(_ sender: UIButton) {
        timer?.invalidate()
        timer = nil
        isPaused = false
        remainingTime = totalTime
        updateTimeLabel()
        progressView.setProgress(0.0, animated: true)
        updateButtonStates(started: false, paused: false)
    }
    
    @IBAction func youtubeLink(_ sender: UIButton) {
        if let url = URL(string: "https://youtu.be/8Oo6h_m8xdQ?si=cNhpsFmL0Nx3RdZJ") {
            UIApplication.shared.open(url)
        }
    }
    
    func startCountdown() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.remainingTime -= 1
            self.updateTimeLabel()
            
            let progress = Float(self.totalTime - self.remainingTime) / Float(self.totalTime)
            self.progressView.setProgress(progress, animated: true)
            
            if self.remainingTime <= 0 {
                self.timer?.invalidate()
                self.timer = nil
                self.updateButtonStates(started: false, paused: false)
                self.progressView.setProgress(1.0, animated: true)
            }
        }
    }
    
    func updateTimeLabel() {
        let minutes = remainingTime / 60
        let seconds = remainingTime % 60
        timeLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }
    
    func updateButtonStates(started: Bool, paused: Bool) {
        startbtn.isEnabled = !started
        pausebtn.isEnabled = started && !paused
        resumebtn.isEnabled = started && paused
        resetbtn.isEnabled = started || paused
    }
}

