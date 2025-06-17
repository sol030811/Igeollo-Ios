//
//  ViewController.swift
//  food1
//
//  Created by 강희원 on 6/12/25.
//

import UIKit

class FoodmainViewController: UIViewController {
    
    @IBOutlet var Koreanbtn: UIButton!
    @IBOutlet var Chinesebtn: UIButton!
    @IBOutlet var Westernbtn: UIButton!
    @IBOutlet var Schoolbtn: UIButton!
    @IBOutlet var Japanesebtn: UIButton!
    @IBOutlet var Asianbtn: UIButton!
    @IBOutlet var Fastbtn: UIButton!
    @IBOutlet var Midnightbtn: UIButton!
    @IBOutlet var Nextbtn: UIButton!
    
    var selectedCategories: [String] = []
    var categoryNames: [UIButton: String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        categoryNames = [
            Koreanbtn: "한식",
            Chinesebtn: "중식",
            Westernbtn: "양식",
            Schoolbtn: "분식",
            Japanesebtn: "일식",
            Asianbtn: "아시안",
            Fastbtn: "패스트푸드",
            Midnightbtn: "야식"
        ]
        setupButton()
    }
    
    private func setupButton() {
        for (button, name) in categoryNames {
            let fullTitle = "☐ \(name)"
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 25, weight: .semibold),
                .foregroundColor: UIColor.black
            ]
            let attributedTitle = NSAttributedString(string: fullTitle, attributes: attributes)
            button.setAttributedTitle(attributedTitle, for: .normal)
            button.contentHorizontalAlignment = .left
        }
    }
    
    private func toggleCategory(_ sender: UIButton, category: String) {
        guard let category = categoryNames[sender] else { return }
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 25, weight: .semibold),
            .foregroundColor: UIColor.black
        ]
        
        if selectedCategories.contains(category) {
            //선택 해제
            selectedCategories.removeAll { $0 == category }
            let uncheckedTitle = NSAttributedString(string: "☐ \(category)", attributes: attributes)
            sender.setAttributedTitle(uncheckedTitle, for: .normal)
        } else {
            //최대 3개까지만 선택
            guard selectedCategories.count < 3 else { return }
            selectedCategories.append(category)
            let checkedTitle = NSAttributedString(string: "✅  \(category)", attributes: attributes)
            sender.setAttributedTitle(checkedTitle, for: .normal)
        }
    }
    
    @IBAction func Koreanbtn(_ sender: UIButton) {
        toggleCategory(sender, category: "한식")
    }
    
    @IBAction func Chinesebtn(_ sender: UIButton) {
        toggleCategory(sender, category: "중식")
    }
    
    @IBAction func Westernbtn(_ sender: UIButton) {
        toggleCategory(sender, category: "양식")
    }
    
    @IBAction func Schoolbtn(_ sender: UIButton) {
        toggleCategory(sender, category: "분식")
    }
    
    @IBAction func Japanesebtn(_ sender: UIButton) {
        toggleCategory(sender, category: "일식")
    }
    
    @IBAction func Asianbtn(_ sender: UIButton) {
        toggleCategory(sender, category: "아시안")
    }
    
    @IBAction func Fastbtn(_ sender: UIButton) {
        toggleCategory(sender, category: "패스트푸드")
    }
    
    @IBAction func Midnightbtn(_ sender: UIButton) {
        toggleCategory(sender, category: "야식")
    }
    
    @IBAction func Nextbtn(_ sender: UIButton) {
        if selectedCategories.isEmpty {
            let alert = UIAlertController(title: "알림", message: "최소 1개 이상의 카테고리를 선택해주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            present(alert, animated: true)
        }
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSubCategory" {
            if let destinationVC = segue.destination as? FoodsubViewController {
                destinationVC.selectedMainCategory = selectedCategories
            }
        }
        
    }
}
