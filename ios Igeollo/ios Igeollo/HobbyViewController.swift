//
//  ViewController.swift
//  hobby
//
//  Created by 강희원 on 6/17/25.
//

import UIKit

struct Hobby {
    let name: String
    let description: String
    let duration: String
    let materials: String
    let link: String
}

class HobbyViewController: UIViewController {
    
    @IBOutlet var hobbyTitleLabel: UILabel!
    @IBOutlet var hobbyDetailTextView: UITextView!
    @IBOutlet var recommendHobbybtn: UIButton!
    
    let hobbies: [Hobby] = [
        Hobby(
            name: "스케치🎨", description: "주변을 마음 가는 대로 간단하게 드로잉 해보세요.", duration: "10~20분", materials: "종이, 연필 또는 펜", link: "https://www.youtube.com/results?search_query=스케치+기초"
             ),
        Hobby(
            name: "사진 찍기📷", description: "집 안에서 예쁜 구도를 찾아보거나 산책하며 사진을 찍어보세요.", duration: "15분 이상", materials: "스마트폰 카메라", link: "https://www.youtube.com/results?search_query=사진+구도+기초"
             ),
        Hobby(
            name: "짧은 일기 쓰기📖", description: "오늘 느낀 감정이나 하고 싶은 말을 짧게 적어보세요.", duration: "5분~10분", materials: "노트, 펜 (또는 메모 앱)", link: "https://www.youtube.com/results?search_query=짧은+글쓰기+팁"
        ),
        Hobby(
            name: "컬러링북 색칠하기🖼️", description: "컬러링북 또는 앱으로 마음을 안정시켜보세요.", duration: "10분~30분", materials: "컬러링북, 색연필 / 컬러링 앱", link: "https://www.youtube.com/results?search_query=컬러링북"
             ),
        Hobby(
            name: "짧은 DIY 만들기✂️", description: "간단한 종이 공예나 방 꾸미기 소품을 만들어 보세요.", duration: "20분~30분", materials: "가위, 풀, 종이 등", link: "https://www.youtube.com/results?search_query=간단한+DIY"
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        hobbyTitleLabel.text = ""
        hobbyDetailTextView.text = ""
    }
    
    @IBAction func recommendHobby(_ sender: UIButton) {
        let selectedHobby = hobbies.randomElement()!
        
        hobbyTitleLabel.text = "🎯 \(selectedHobby.name)"
        hobbyDetailTextView.text = """
        📝 설명: \(selectedHobby.description)

        ⏱️ 추천 시간: \(selectedHobby.duration)
        📦 준비물: \(selectedHobby.materials)

        🔗 참고 링크:
        \(selectedHobby.link)
        """
    }
    

}

