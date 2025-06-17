//
//  ViewController.swift
//  food2
//
//  Created by 강희원 on 6/12/25.
//

import UIKit

class FoodsubViewController: UIViewController {
    
    var selectedMainCategory: [String] = []
    var selectedSubCategories: [String] = []
    
    @IBOutlet var Ricebtn: UIButton!
    @IBOutlet var Noodlebtn: UIButton!
    @IBOutlet var Stewbtn: UIButton!
    @IBOutlet var Soupbtn: UIButton!
    @IBOutlet var Grillbtn: UIButton!
    @IBOutlet var Dietbtn: UIButton!
    @IBOutlet var Nextbtn: UIButton!
    
    
    var categoryNames: [UIButton: String] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        categoryNames = [
            Ricebtn: "밥",
            Noodlebtn: "면",
            Stewbtn: "찜/조림",
            Soupbtn: "국/찌개",
            Grillbtn: "구이",
            Dietbtn: "다이어트"
        ]
        
        setupButtons()
    }
    
    private func setupButtons() {
        for (button, name) in categoryNames {
            let title = "☐ \(name)"
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 25, weight: .semibold),
                .foregroundColor: UIColor.black
            ]
            let attributedTitle = NSAttributedString(string: title, attributes: attributes)
            button.setAttributedTitle(attributedTitle, for: .normal)
            button.contentHorizontalAlignment = .left
        }
    }
    
    private func toggleCategory(_ sender: UIButton) {
        guard let category = categoryNames[sender] else { return }
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 25, weight: .semibold),
            .foregroundColor: UIColor.black
        ]
        
        if selectedSubCategories.contains(category) {
            selectedSubCategories.removeAll { $0 == category }
            let uncheckedTitle = NSAttributedString(string: "☐ \(category)", attributes: attributes)
            sender.setAttributedTitle(uncheckedTitle, for: .normal)
        } else {
            guard selectedSubCategories.count < 3 else { return }
            selectedSubCategories.append(category)
            let checkedTitle = NSAttributedString(string: "✅ \(category)", attributes: attributes)
            sender.setAttributedTitle(checkedTitle, for: .normal)
        }
    }

    @IBAction func Ricebtn(_ sender: UIButton) {
        toggleCategory(sender)
    }
    
    @IBAction func Noodlebtn(_ sender: UIButton) {
        toggleCategory(sender)
    }
    
    @IBAction func Stewbtn(_ sender: UIButton) {
        toggleCategory(sender)
    }
    
    @IBAction func Soupbtn(_ sender: UIButton) {
        toggleCategory(sender)
    }
    
    @IBAction func Grillbtn(_ sender: UIButton) {
        toggleCategory(sender)
    }
    
    @IBAction func Dietbtn(_ sender: UIButton) {
        toggleCategory(sender)
    }
    
    @IBAction func Nextbtn(_ sender: UIButton) {
        if selectedSubCategories.isEmpty {
                    let alert = UIAlertController(title: "알림", message: "최소 한 개의 세부 카테고리를 선택해주세요.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default))
                    present(alert, animated: true)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult",
           let destinationVC = segue.destination as? FoodresultViewController {
            destinationVC.mainCategory = selectedMainCategory
            destinationVC.subCategory = selectedSubCategories
        }
    }
    
}

