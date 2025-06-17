//
//  ViewController.swift
//  Timer
//
//  Created by 강희원 on 6/5/25.
//

import UIKit

class TimerViewController: UIViewController {

    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var progressView: UIProgressView!
    
    @IBOutlet var startbtn: UIButton!
    @IBOutlet var pausebtn: UIButton!
    @IBOutlet var resumebtn: UIButton!
    @IBOutlet var resetbtn: UIButton!
    @IBOutlet var pickTimebtn: UIButton!
    
    var timer: Timer?
        var totalTime: Int = 60 //기본 1분
        var remainingTime: Int = 60
        var isPaused: Bool = false
        var selectedMinutes: Int = 1
        
        let pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(0, inComponent: 0, animated: false) // 5분이 기본 선택
                
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
        totalTime = 300
        remainingTime = 300
        updateTimeLabel()
        progressView.setProgress(0.0, animated: true)
                
        updateButtonStates(started: false, paused: false)
    }
    
    @IBAction func showTimePickerPopup(_ sender: UIButton) {
        let alert = UIAlertController(title: "시간 선택", message: "\n\n\n\n\n\n", preferredStyle: .alert)
                
        pickerView.frame = CGRect(x: 5, y: 30, width: 250, height: 140)
        alert.view.addSubview(pickerView)
                
        pickerView.selectRow(selectedMinutes - 1, inComponent: 0, animated: false)
                
        let selectAction = UIAlertAction(title: "선택", style: .default){ _ in
            self.totalTime = self.selectedMinutes * 60
            self.remainingTime = self.totalTime
            self.updateTimeLabel()
                    
            self.pickTimebtn.setTitle("선택된 시간: \(self.selectedMinutes)분", for: .normal)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                
        alert.addAction(selectAction)
        alert.addAction(cancelAction)
                
        present(alert, animated: true, completion: nil)
    }
    
    //Timer Logic
    func startCountdown(){
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){ _ in
        self.remainingTime -= 1
        self.updateTimeLabel()
               
        let progress = Float(self.totalTime - self.remainingTime) / Float(self.totalTime)
        self.progressView.setProgress(progress, animated: true)
               
        if self.remainingTime <= 0{
            self.timer?.invalidate()
            self.timer = nil
            self.updateButtonStates(started: false, paused: false)
            self.progressView.setProgress(1.0, animated: true)
            //추후 알림/진동 추가 가능
            }
        }
    }
    
    func updateTimeLabel(){
        let minutes = remainingTime / 60
        let seconds = remainingTime % 60
        timeLabel.text = String(format: "%02d:%02d", minutes, seconds)
        }
        
    func updateButtonStates(started: Bool, paused: Bool){
        startbtn.isEnabled = !started
        pausebtn.isEnabled = started && !paused
        resumebtn.isEnabled = started && paused
        resetbtn.isEnabled = started || paused
        pickTimebtn.isEnabled = !started
    }
}

//UIPickerView 설정
extension TimerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 60 //1분~60분
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)분"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedMinutes = (row + 1)
    }
}

