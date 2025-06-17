//
//  ViewController.swift
//  Ai
//
//  Created by 강희원 on 6/5/25.
//

import UIKit
import CoreLocation

class AiViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var moodSegment: UISegmentedControl!
    
    @IBOutlet weak var indoorbtn: UIButton!
    @IBOutlet weak var outdoorbtn: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //시간 슬라이더
        timeSlider.minimumValue = 1
        timeSlider.maximumValue = 60
        timeSlider.value = 30
        updateTimeLabel()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    @IBAction func timeSliderChanged(_ sender: UISlider) {
        updateTimeLabel()
    }
    
    func updateTimeLabel() {
        let time = Int(timeSlider.value)
        timeLabel.text = "나의 남은 시간: \(time)분"
    }
    
    @IBAction func moodChanged(_ sender: UISegmentedControl) {
        let mood = getSelectedMood()
        moodLabel.text = "현재 기분은?: \(mood)"
    }
    
    func getSelectedMood() -> String {
        switch moodSegment.selectedSegmentIndex {
        case 0: return "기쁨"
        case 1: return "지루함"
        case 2: return "슬픔"
        case 3: return "불안함"
        case 4: return "화남"
        default: return "알 수 없음"
        }
    }
    
    @IBAction func indoorTapped(_ sender: UIButton) {
        locationLabel.text = "현재 위치는?: 실내에 있어요."
    }
    
    @IBAction func outdoorTapped(_ sender: UIButton) {
        locationLabel.text = "위치 확인 중..."
        locationManager.requestLocation()
    }
    
    //CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else{
            locationLabel.text = "위치 불러오기 실패"
            return
        }
        
        //위치를 주소로 변환
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let placemark = placemarks?.first {
                let city = placemark.locality ?? ""
                let detail = placemark.name ?? ""
                DispatchQueue.main.async {
                    self.locationLabel.text = "현재 위치: \(city) \(detail)"
                }
            } else {
                DispatchQueue.main.async {
                    self.locationLabel.text = "주소 정보 없음"
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationLabel.text = "위치 오류: \(error.localizedDescription)"
    }
}

