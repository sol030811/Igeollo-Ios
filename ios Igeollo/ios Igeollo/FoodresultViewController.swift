//
//  ViewController.swift
//  food3
//
//  Created by 강희원 on 6/14/25.
//

import UIKit
import CoreData

class FoodresultViewController: UIViewController {
    
    //이전 화면에서 전달받을 카테고리
    var mainCategory: [String] = []
    var subCategory: [String] = []
    
    //결과 음식들 저장
    var foods: [FoodItem] = []
    
    @IBOutlet var ResultLabel1: UILabel!
    @IBOutlet var ResultLabel2: UILabel!
    @IBOutlet var ResultLabel3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchFoods()
        showRandomFoods()
    }
    
    //Core Data에서 해당 카테고리 음식들 fetch
    func fetchFoods() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<FoodItem> = FoodItem.fetchRequest()
        
        var predicates: [NSPredicate] = []
        
        if !mainCategory.isEmpty {
            predicates.append(NSPredicate(format: "mainCategory IN %@", mainCategory))
        }
        
        if !subCategory.isEmpty {
            predicates.append(NSPredicate(format: "subCategory IN %@", subCategory))
        }
        
        if !predicates.isEmpty {
            fetchRequest.predicate  = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        }
        
        do {
            foods = try context.fetch(fetchRequest)
            print("✅ \(foods.count)개의 음식 불러옴")
        } catch {
            print("❌ 음식 불러오기 실패: \(error.localizedDescription)")
        }
    }
    
    //랜덤으로 최대 3가지 음식 뽑아서 UI에 보여주기
    func showRandomFoods() {
        guard !foods.isEmpty else {
            ResultLabel1.text = "추천할 음식이 없습니다."
            ResultLabel2.text = ""
            ResultLabel3.text = ""
            return
        }
        
        // foods 배열을 셔플해서 최대 3개 선택
        let randomFoods = foods.shuffled().prefix(3)
        let names = randomFoods.map { $0.name ?? "이름없음" }
        
        ResultLabel1.text = names.indices.contains(0) ? "1. \(names[0])" : ""
        ResultLabel2.text = names.indices.contains(1) ? "2. \(names[1])" : ""
        ResultLabel3.text = names.indices.contains(2) ? "3. \(names[2])" : ""
    }
    
}

