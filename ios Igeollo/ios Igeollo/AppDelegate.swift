//
//  AppDelegate.swift
//  ios Igeollo
//
//  Created by 강희원 on 6/5/25.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        insertSampleFoodsAlways()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    //MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FoodModel")
        container.loadPersistentStores(completionHandler: {(storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), (error.userInfo)")
            }
        })
        return container
    }()

    //MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Sample Data 삽입
    func insertSampleFoodsAlways() {
        let context = persistentContainer.viewContext
        
        let sampleData: [(String, String, String)] = [
            ("김치찌개", "한식", "국/찌개"),
            ("짜장면", "중식", "면"),
            ("리조또", "양식", "밥"),
            ("샐러드", "패스트푸드", "다이어트"),
            ("숯불 치킨", "야식", "구이"),
            ("찜닭", "한식", "찜/조림"),
            ("마제소바", "일식", "면"),
            ("김밥", "분식", "밥"),
            ("똠양꿍", "아시안", "국/찌개"),
            ("순두부찌개", "한식", "국/찌개"),
            ("파스타", "양식", "면"),
        ]
        for (name, main, sub) in sampleData {
            let food = FoodItem(context: context)
            food.name = name
            food.mainCategory = main
            food.subCategory = sub
        }
        
        do {
            try context.save()
            print("✅ 무조건 샘플 데이터 추가 완료")
        } catch {
            print("⚠️ 샘플 데이터 저장 실패: \(error.localizedDescription)")
        }
    }
    
    func fetchFoods(mainCategory: String?, subCategory: String?) -> [FoodItem] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<FoodItem> = FoodItem.fetchRequest()
        
        var predicates = [NSPredicate]()
        
        if let main = mainCategory {
            predicates.append(NSPredicate(format: "mainCategory == %@", main))
        }
        if let sub = subCategory {
            predicates.append(NSPredicate(format: "subCategory == %@", sub))
        }
        
        if !predicates.isEmpty {
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        }
        
        do {
            let foods = try context.fetch(fetchRequest)
            return foods
        } catch {
            print("Error fetching foods: \(error)")
            return []
        }
    }
    
    func getRandomFoods(mainCategory: String?, subCategory: String?) -> [FoodItem] {
        let allFoods = fetchFoods(mainCategory: mainCategory, subCategory: subCategory)
                let shuffled = allFoods.shuffled()
                let count = min(3, shuffled.count)
                return Array(shuffled.prefix(count))
    }
}
