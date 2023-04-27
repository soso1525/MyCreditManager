//
//  Student.swift
//  MyCreditManager
//
//  Created by 소현 on 2023/04/27.
//

import Foundation

class Student: NSObject {
    var name: String
    var scores: [String : String] = [:]
    
    init (name: String) {
        self.name = name
    }
    
    func updateScore(subject: String, score: String) {
        scores.updateValue(score, forKey: subject)
    }
    
    func hasScore(subject: String) -> Bool {
        scores.keys.contains(subject)
    }
    
    func deleteScore(subject: String) {
        scores.removeValue(forKey: subject)
    }
    
    func printScoreAverage() {
        let sum = scores.map { subject, score in
            print("\(subject): \(score)")
            return score
        }.map { score in
            switch score {
            case "A+":
                return 4.5
            case "A":
                return 4.0
            case "B+":
                return 3.5
            case "B":
                return 3.0
            case "C+":
                return 2.5
            case "C":
                return 2.0
            case "D+":
                return 1.5
            case "D":
                return 1.0
            default:
                return 0.0
            }
        }.reduce(0.0, +)
        
        let average = String(format: "%.2f", sum / Double(scores.count))
        print("평점 : \(average)\n")
    }
}
