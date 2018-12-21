//
//  Meals.swift
//  CaloriesTracker
//
//  Created by Ky Nguyen Coinhako on 12/21/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

class CTMealsDashboard: knListController<CTMealCell, CTMeal> {
    override var datasource: [CTMeal] { didSet { tableView.reloadData() }}
    let ui = UI()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchData()
    }
    
    override func setupView() {
        navigationController?.hideBar(true)
        tableView.estimatedRowHeight = 300
        super.setupView()
        tableView.backgroundColor = UIColor.bg
        tableView.setHeader(ui.makeHeaderView(), height: 695)
        view.addFill(tableView)
    }
    
    override func fetchData() {
        ui.thisWeekView.datasource = [
            CTMeal(image: "https://imagesvc.timeincapp.com/v3/mm/image?url=https%3A%2F%2Fimg1.cookinglight.timeinc.net%2Fsites%2Fdefault%2Ffiles%2Fstyles%2F4_3_horizontal_-_1200x900%2Fpublic%2Fimage%2F2015%2F04%2Fmain%2F1501p77-salmon-lime-hoisin-glaze-crunchy-bok-choy-slaw.jpg%3Fitok%3DXciqhRnH&w=1000&c=sc&poi=face&q=70",
                   name: "Beef Tenderloin with Horseradish Cream and Glazed Carrots",
                   ingredient: "Beef tenderloin is worthy splurge when you want a special entrée in less time; the cut is so meltingly tender already that it takes just 8 minutes to cook. We use the same pan to cook and glaze the carrots for easy clean up. The horseradish sauce is the tangy, creamy, pungent element this dish needs.", calory: 170, date: "2018-12-21", mealType: .breakfast),
            CTMeal(image: "https://greenhealthycooking.com/wp-content/uploads/2017/08/Healthy-Meal-Prep-Bowl-Photo.jpg", name: "Grilled Flank Steak Gyros", ingredient: "You can indulge your fast-food craving with a healthier sandwich that packs the same irresistible meaty-creamy combo you get from a street cart.", calory: 210, date: "2018-12-21", mealType: .breakfast),
            CTMeal(image: "https://ludafit.com/wp-content/uploads/2018/08/Cilantro-Lime-Shrimp-with-Zucchini-Noodles-recipe.jpg", name: "Orange and Tomato Simmered Chicken with Couscous", ingredient: "you can have it all—tender, slow-simmered chicken layered with complex flavors. Use free time on Saturday and Sunday to plan ahead for weekday meals. Make a double batch of the chicken, freeze half for the 27th, and make a second serving of couscous and add to salads for a quick whole-grain lunch throughout the week.", calory: 210, date: "2018-12-21", mealType: .lunch),
            CTMeal(image: "http://images.media-allrecipes.com/images/71852.jpg", name: "One-Pot Pasta with Spinach and Tomatoes", ingredient: "Explore the depth of flavor in fresh, seasonal vegetables each week with meatless Mondays. Here, we made pasta night easier by cooking the noodles right in the sauce. This not only saves on cleanup; the stock also infuses the pasta with flavor as it cooks, and the starch helps to thicken the sauce so it clings.", calory: 210, date: "2018-12-21", mealType: .dinner),
            CTMeal(image: "https://imagesvc.timeincapp.com/v3/mm/image?url=https%3A%2F%2Fimg1.cookinglight.timeinc.net%2Fsites%2Fdefault%2Ffiles%2Fstyles%2F4_3_horizontal_-_1200x900%2Fpublic%2Fimage%2F2017%2F03%2Fmain%2Fspinach-pesto-pasta-shrimp_0_1_0.jpg%3Fitok%3DiEn-0uVj%261530126200&w=1000&c=sc&poi=face&q=70", name: "Peppery Shrimp with Grits and Greens", ingredient: "The best weeknight dinners don't require special cooking skills or out-of-the-ordinary ingredients, yet are still delicious and nourishing. This comforting classic makes the most of an unsung pantry hero: black pepper. It brings pungent heat to this 10-ingredient dinner.", calory: 210, date: "2018-12-21", mealType: .dinner),
        ]
        
        datasource = [
            CTMeal(image: "https://imagesvc.timeincapp.com/v3/mm/image?url=https%3A%2F%2Fimg1.cookinglight.timeinc.net%2Fsites%2Fdefault%2Ffiles%2Fstyles%2F4_3_horizontal_-_1200x900%2Fpublic%2Fimage%2F2015%2F04%2Fmain%2F1501p77-salmon-lime-hoisin-glaze-crunchy-bok-choy-slaw.jpg%3Fitok%3DXciqhRnH&w=1000&c=sc&poi=face&q=70",
                   name: "Beef Tenderloin with Horseradish Cream and Glazed Carrots",
                   ingredient: "Beef tenderloin is worthy splurge when you want a special entrée in less time; the cut is so meltingly tender already that it takes just 8 minutes to cook. We use the same pan to cook and glaze the carrots for easy clean up. The horseradish sauce is the tangy, creamy, pungent element this dish needs.", calory: 170, date: "2018-12-21", mealType: .breakfast),
            CTMeal(image: "https://greenhealthycooking.com/wp-content/uploads/2017/08/Healthy-Meal-Prep-Bowl-Photo.jpg", name: "Grilled Flank Steak Gyros", ingredient: "You can indulge your fast-food craving with a healthier sandwich that packs the same irresistible meaty-creamy combo you get from a street cart.", calory: 210, date: "2018-12-21", mealType: .breakfast),
            CTMeal(image: "https://ludafit.com/wp-content/uploads/2018/08/Cilantro-Lime-Shrimp-with-Zucchini-Noodles-recipe.jpg", name: "Orange and Tomato Simmered Chicken with Couscous", ingredient: "you can have it all—tender, slow-simmered chicken layered with complex flavors. Use free time on Saturday and Sunday to plan ahead for weekday meals. Make a double batch of the chicken, freeze half for the 27th, and make a second serving of couscous and add to salads for a quick whole-grain lunch throughout the week.", calory: 210, date: "2018-12-21", mealType: .lunch),
            CTMeal(image: "http://images.media-allrecipes.com/images/71852.jpg", name: "One-Pot Pasta with Spinach and Tomatoes", ingredient: "Explore the depth of flavor in fresh, seasonal vegetables each week with meatless Mondays. Here, we made pasta night easier by cooking the noodles right in the sauce. This not only saves on cleanup; the stock also infuses the pasta with flavor as it cooks, and the starch helps to thicken the sauce so it clings.", calory: 210, date: "2018-12-21", mealType: .dinner),
            CTMeal(image: "https://imagesvc.timeincapp.com/v3/mm/image?url=https%3A%2F%2Fimg1.cookinglight.timeinc.net%2Fsites%2Fdefault%2Ffiles%2Fstyles%2F4_3_horizontal_-_1200x900%2Fpublic%2Fimage%2F2017%2F03%2Fmain%2Fspinach-pesto-pasta-shrimp_0_1_0.jpg%3Fitok%3DiEn-0uVj%261530126200&w=1000&c=sc&poi=face&q=70", name: "Peppery Shrimp with Grits and Greens", ingredient: "The best weeknight dinners don't require special cooking skills or out-of-the-ordinary ingredients, yet are still delicious and nourishing. This comforting classic makes the most of an unsung pantry hero: black pepper. It brings pungent heat to this 10-ingredient dinner.", calory: 210, date: "2018-12-21", mealType: .dinner),
        ]
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        isStatusBarHidden = scrollView.contentOffset.y > 0
        setNeedsStatusBarAppearanceUpdate()
    }
}


