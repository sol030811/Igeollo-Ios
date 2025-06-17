//
//  ViewController.swift
//  Time1
//
//  Created by 강희원 on 6/16/25.
//

import UIKit

class TimeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var oneminbtn: UIButton!
    @IBOutlet var fiveminbtn: UIButton!
    @IBOutlet var tenminbtn: UIButton!
    @IBOutlet var fifteenminbtn: UIButton!
    @IBOutlet var thirtyminbtn: UIButton!
    @IBOutlet var onehourbtn: UIButton!
    
    @IBOutlet var tabelview: UITableView!
    
    let activityDict: [String: [String]] = [
        "1 분": ["심호흡 하기", "스트레칭", "물 마시기"],
        "5 분": ["간단한 명상", "계획 점검", "가벼운 정리"],
        "10 분": ["산책", "간식 먹기", "독서 시작하기"],
        "15 분": ["정리정돈", "간단 운동", "다이어리 쓰기"],
        "30 분": ["운동 루틴", "집안일", "짧은 영상 시청"],
        "1 시간": ["집중 작업", "독서", "요리하기"]
    ]
    
    var currentActivities: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tabelview.dataSource = self
        tabelview.delegate = self
        
        // 초기에는 빈 배열로 세팅
        currentActivities = []
        tabelview.reloadData()
    }
    // 버튼 클릭 시
    @IBAction func timeButtonTapped(_ sender: UIButton) {
        guard let time = sender.titleLabel?.text,
              let activities = activityDict[time] else { return }
        
        currentActivities = activities
        tabelview.reloadData()
    }
    
    // TabelViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentActivities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath)
        cell.textLabel?.text = currentActivities[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedActivity = currentActivities[indexPath.row]
        print("선택한 활동: \(selectedActivity)")
        
        tabelview.deselectRow(at: indexPath, animated: true)
        
        // 활동별로 화면 전환
        switch selectedActivity {
        case "심호흡 하기":
            if let vc = storyboard?.instantiateViewController(withIdentifier: "BreathingVC"){
                navigationController?.pushViewController(vc, animated: true)
            }
        case "스트레칭":
            if let vc = storyboard?.instantiateViewController(withIdentifier: "StretchingVC") {
                navigationController?.pushViewController(vc, animated: true)
            }
        case "물 마시기":
            if let vc = storyboard?.instantiateViewController(withIdentifier: "DrinkingVC") {
                navigationController?.pushViewController(vc, animated: true)
            }
        case "간단한 명상":
            if let vc = storyboard?.instantiateViewController(withIdentifier: "MeditatingVC") {
                navigationController?.pushViewController(vc, animated: true)
            }
        case "계획 점검":
            if let vc = storyboard?.instantiateViewController(withIdentifier: "PlanningVC") {
                navigationController?.pushViewController(vc, animated: true)
            }
        case "가벼운 정리":
            if let vc = storyboard?.instantiateViewController(withIdentifier: "easyorganizingVC") {
                navigationController?.pushViewController(vc, animated: true)
            }
        case "산책":
            if let vc = storyboard?.instantiateViewController(withIdentifier: "walkingVC") {
                navigationController?.pushViewController(vc, animated: true)
            }
        case "간식 먹기":
            if let vc = storyboard?.instantiateViewController(withIdentifier: "eatingVC") {
                navigationController?.pushViewController(vc, animated: true)
            }
        case "독서 시작하기":
            if let vc = storyboard?.instantiateViewController(withIdentifier: "readingVC") {
                navigationController?.pushViewController(vc, animated: true)
            }
        case "정리정돈":
            if let vc = storyboard?.instantiateViewController(withIdentifier: "organizingVC") {
                navigationController?.pushViewController(vc, animated: true)
            }
        case "간단 운동":
            if let vc = storyboard?.instantiateViewController(withIdentifier: "easyexerciseVC") {
                navigationController?.pushViewController(vc, animated: true)
            }
        case "다이어리 쓰기":
            if let vc = storyboard?.instantiateViewController(withIdentifier: "writingVC") {
                navigationController?.pushViewController(vc, animated: true)
            }
        case "운동 루틴":
            if let vc = storyboard?.instantiateViewController(withIdentifier: "exerciseVC") {
                navigationController?.pushViewController(vc, animated: true)
            }
        case "집안일":
            if let vc = storyboard?.instantiateViewController(withIdentifier: "houseworkVC") {
                navigationController?.pushViewController(vc, animated: true)
            }
        case "짧은 영상 시청":
            if let vc = storyboard?.instantiateViewController(withIdentifier: "watchingVC") {
                navigationController?.pushViewController(vc, animated: true)
            }
        case "집중 작업":
            if let vc = storyboard?.instantiateViewController(withIdentifier: "workingVC") {
                navigationController?.pushViewController(vc, animated: true)
            }
        case "독서":
            if let vc = storyboard?.instantiateViewController(withIdentifier: "readVC") {
                navigationController?.pushViewController(vc, animated: true)
            }
        case "요리하기":
            if let vc = storyboard?.instantiateViewController(withIdentifier: "cookingVC") {
                navigationController?.pushViewController(vc, animated: true)
            }
        default :
            
            break
        }
    }

}

