//
//  LogViewController.swift
//  Gouda0916
//
//  Created by Michael Young on 11/14/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit

class LogViewController: UIViewController {
    
    let store = DataStore.sharedInstance
    let velocity = Velocity()
    let weeklyGraph = WeeklyGraphView()
    var menuIsShowing = false
    var isThisWeek: Bool = true
    
    @IBOutlet weak var dayOneLabel: UILabel!
    @IBOutlet weak var dayTwoLabel: UILabel!
    @IBOutlet weak var dayThreeLabel: UILabel!
    @IBOutlet weak var dayFourLabel: UILabel!
    @IBOutlet weak var dayFiveLabel: UILabel!
    @IBOutlet weak var daySixLabel: UILabel!
    @IBOutlet weak var daySevenLabel: UILabel!
    @IBOutlet weak var footerView: FooterView!
    @IBOutlet weak var weeklyView: WeeklyGraphView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var maskView: UIView!
    @IBOutlet weak var velocityScoreView: VelocityScoreView!
    @IBOutlet weak var blackCoverView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    func menuButtonPressed(_ sender: Any) {
        if !menuIsShowing {
            NotificationCenter.default.post(name: .unhideBar, object: nil)
            menuIsShowing = true
            UIView.animate(withDuration: 0.3) {
                self.blackCoverView.alpha = 0.8
                self.view.layoutIfNeeded()
            }
        } else {
            NotificationCenter.default.post(name: .hideBar, object: nil)
            menuIsShowing = false
            UIView.animate(withDuration: 0.3) {
                self.blackCoverView.alpha = 0.0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    @IBAction func dailyScoreButtonTouched(_ sender: UIButton) {
        let thisWeek = [Date(),
                        Velocity.yesterday,
                        Velocity.twoDaysAgo,
                        Velocity.threeDaysAgo,
                        Velocity.fourDaysAgo,
                        Velocity.fiveDaysAgo,
                        Velocity.sixDaysAgo]
        
        let lastWeek = [Velocity.sevenDaysAgo,
                        Velocity.eightDaysAgo,
                        Velocity.nineDaysAgo,
                        Velocity.tenDaysAgo,
                        Velocity.elevenDaysAgo,
                        Velocity.twelveDaysAgo,
                        Velocity.thirteenDaysAgo]
        
        var week: [Date]
        
        if isThisWeek {
            week = thisWeek
        } else {
            week = lastWeek
        }
        
        switch sender.tag {
        case 1:
            velocityScoreViewTransition(for: week[6])
            updateCurrentScoreLabel(withScoreFor: week[6])
            store.pointIndex = 1
            self.weeklyView.setNeedsDisplay()
        case 2:
            velocityScoreViewTransition(for: week[5])
            updateCurrentScoreLabel(withScoreFor: week[5])
            store.pointIndex = 2
            self.weeklyView.setNeedsDisplay()
        case 3:
            velocityScoreViewTransition(for: week[4])
            updateCurrentScoreLabel(withScoreFor: week[4])
            store.pointIndex = 3
            self.weeklyView.setNeedsDisplay()
        case 4:
            velocityScoreViewTransition(for: week[3])
            updateCurrentScoreLabel(withScoreFor: week[3])
            store.pointIndex = 4
            self.weeklyView.setNeedsDisplay()
        case 5:
            velocityScoreViewTransition(for: week[2])
            updateCurrentScoreLabel(withScoreFor: week[2])
            store.pointIndex = 5
            self.weeklyView.setNeedsDisplay()
        case 6:
            velocityScoreViewTransition(for: week[1])
            updateCurrentScoreLabel(withScoreFor: week[1])
            store.pointIndex = 6
            self.weeklyView.setNeedsDisplay()
        case 7:
            velocityScoreViewTransition(for: week[0])
            updateCurrentScoreLabel(withScoreFor: week[0])
            store.pointIndex = 7
            self.weeklyView.setNeedsDisplay()
        default:
            print("Failed during sender tag collection")
        }
    }
    
    
    @IBAction func weeklyScoreTouched(_ sender: UIButton) {
        if let week = sender.currentTitle {
            self.weeklyView.setNeedsDisplay()
            velocity.updateGraph(for: week)
            updateDailyScoreLabel(for: week)
            
            if week == "This Week" {
                isThisWeek = true
                velocityScoreViewTransition(for: Date())
                updateCurrentScoreLabel(withScoreFor: Date())
            } else if week == "Last Week" {
                isThisWeek = false
                velocityScoreViewTransition(for: Velocity.sevenDaysAgo)
                updateCurrentScoreLabel(withScoreFor: Velocity.sevenDaysAgo)
            }
        }
        store.pointIndex = 7
    }
    
    
    func updateCurrentScoreLabel(withScoreFor date: Date) {
        var score: Double = 0
        
        for (key, value) in store.velocityHistory {
            let order = Calendar.current.compare(key, to: date, toGranularity: .day)
            
            switch order {
            case .orderedDescending:
                print("DESCENDING")
            case .orderedAscending:
                print("ASCENDING")
            case .orderedSame:
                score = value
            }
        }
        
        velocityScoreView.velocityScoreLabel.text = "\(score)"
    }
    
    
    func updateDailyScoreLabel(for week: String){
        let calender = Calendar(identifier: .gregorian)
        let today = calender.component(.day, from: Date())
        let yesterday = calender.component(.day, from: Velocity.yesterday)
        let twoDaysAgo = calender.component(.day, from: Velocity.twoDaysAgo)
        let threeDaysAgo = calender.component(.day, from: Velocity.threeDaysAgo)
        let fourDaysAgo = calender.component(.day, from: Velocity.fourDaysAgo)
        let fiveDaysAgo = calender.component(.day, from: Velocity.fiveDaysAgo)
        let sixDaysAgo = calender.component(.day, from: Velocity.sixDaysAgo)
        let sevenDaysAgo = calender.component(.day, from: Velocity.sevenDaysAgo)
        let eightDaysAgo = calender.component(.day, from: Velocity.eightDaysAgo)
        let nineDaysAgo = calender.component(.day, from: Velocity.nineDaysAgo)
        let tenDaysAgo = calender.component(.day, from: Velocity.tenDaysAgo)
        let elevenDaysAgo = calender.component(.day, from: Velocity.elevenDaysAgo)
        let twelveDaysAgo = calender.component(.day, from: Velocity.twelveDaysAgo)
        let thirteenDaysAgo = calender.component(.day, from: Velocity.thirteenDaysAgo)
        
        if week == "This Week" {
            dayOneLabel.text = "\(today)\(daySuffix(from: Date()))"
            dayTwoLabel.text = "\(yesterday)\(daySuffix(from: Velocity.yesterday))"
            dayThreeLabel.text = "\(twoDaysAgo)\(daySuffix(from: Velocity.twoDaysAgo))"
            dayFourLabel.text = "\(threeDaysAgo)\(daySuffix(from: Velocity.threeDaysAgo))"
            dayFiveLabel.text = "\(fourDaysAgo)\(daySuffix(from: Velocity.fourDaysAgo))"
            daySixLabel.text = "\(fiveDaysAgo)\(daySuffix(from: Velocity.fiveDaysAgo))"
            daySevenLabel.text = "\(sixDaysAgo)\(daySuffix(from: Velocity.sixDaysAgo))"
        } else if week == "Last Week" {
            dayOneLabel.text = "\(sevenDaysAgo)\(daySuffix(from: Velocity.sevenDaysAgo))"
            dayTwoLabel.text = "\(eightDaysAgo)\(daySuffix(from: Velocity.eightDaysAgo))"
            dayThreeLabel.text = "\(nineDaysAgo)\(daySuffix(from: Velocity.nineDaysAgo))"
            dayFourLabel.text = "\(tenDaysAgo)\(daySuffix(from: Velocity.tenDaysAgo))"
            dayFiveLabel.text = "\(elevenDaysAgo)\(daySuffix(from: Velocity.elevenDaysAgo))"
            daySixLabel.text = "\(twelveDaysAgo)\(daySuffix(from: Velocity.twelveDaysAgo))"
            daySevenLabel.text = "\(thirteenDaysAgo)\(daySuffix(from: Velocity.thirteenDaysAgo))"
        }
    }
    
    
    func daySuffix(from date: Date) -> String {
        let calender = Calendar.current
        let dayOfMonth = calender.component(.day, from: date)
        
        switch dayOfMonth {
        case 1, 21, 31:
            return "st"
        case 2, 22:
            return "nd"
        case 3, 23:
            return "rd"
        default:
            return "th"
        }
    }
    
    
    func velocityScoreViewTransition(for date: Date) {
        UIView.animateKeyframes(withDuration: 0.3, delay: 0.0, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.1, animations: {
                self.velocityScoreView.layer.opacity = 0
                self.velocityScoreView.center.x += self.view.bounds.width
            })
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.1, animations: {
                self.velocityScoreView.center.x -= self.view.bounds.width * 2
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.1, animations: {
                self.velocityScoreView.layer.opacity = 1
                self.velocityScoreView.center.x = self.view.center.x
                self.velocityScoreView.velocityScoreLabel.text = ""
                self.velocityScoreView.velocityDayLabel.text = ""
            })
        }, completion: { success in
            if Calendar.current.isDateInToday(date){
                self.velocityScoreView.velocityDayLabel.text = "Current Velocity Score"
            } else {
                self.velocityScoreView.velocityDayLabel.text = "\(date.dayOfTheWeek())'s Velocity Score"
            }
        })
    }
    
    
    func setUpView() {
        updateDailyScoreLabel(for: "This Week")
        store.pointIndex = 7
        velocity.updateGraph(for: "This Week")
        isThisWeek = true
        velocityScoreView.velocityScoreLabel.text = "\(store.currentVelocityScore)"
        let menuGesture = UITapGestureRecognizer(target: self, action: #selector(menuButtonPressed))
        footerView.hamburgerMenuImageView.addGestureRecognizer(menuGesture)
        let blackCoverTG = UITapGestureRecognizer.init(target: self, action: #selector(menuButtonPressed))
        blackCoverView.addGestureRecognizer(blackCoverTG)
        navigationController?.navigationBar.isHidden = true
    }
}



