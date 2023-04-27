//
//  main.swift
//  MyCreditManager
//
//  Created by 소현 on 2023/04/27.
//

import Foundation

let scores: [String] = ["A+", "A", "B+", "B", "C+", "C", "D+", "D", "F"]
var students: [String : Student] = [:]

loop: while (true) {
    print("원하는 기능을 입력해주세요")
    print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    
    guard let command = readLine() else {
        print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.\n")
        continue
    }
    
    switch Command(rawValue: command.uppercased()) {
    case .addStudent:
        print("추가할 학생의 이름을 입력해주세요")
        guard let name = readLine() else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.\n")
            continue
        }
    
        addStudent(name: name)
    case .removeStudent:
        print("삭제할 학생의 이름을 입력해주세요")
        guard let name = readLine() else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.\n")
            continue
        }
        
        removeStudent(name: name)
    case .changeScore:
        print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.")
        print("입력예) Mickey Swift A+")
        print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
        
        guard let studentScoreInfo = readLine() else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.\n")
            continue
        }
        
        changeScore(studentScoreInfo: studentScoreInfo)
    case .deleteScore:
        print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
        print("입력예) Mickey Swift")
        
        guard let studentScoreInfo = readLine() else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.\n")
            continue
        }
        
        deleteScore(studentScoreInfo: studentScoreInfo)
    case .showAverage:
        print("평점을 알고싶은 학생의 이름을 입력해주세요")
        
        guard let name = readLine() else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.\n")
            continue
        }
        
        guard let student = students[name] else {
            print("\(name) 학생을 찾지 못했습니다.\n")
            continue
        }
        
        student.printScoreAverage()
    case .quit:
        print("프로그램을 종료합니다...")
        break loop
    default:
        print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.\n")
    }
}

private func addStudent(name: String) {
    if name.isEmpty {
        print("입력이 잘못되었습니다. 다시 확인해주세요.\n")
        return
    }
    
    if (students.keys.contains(name)) {
        print("\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다.\n")
        return
    }
    
    students[name] = Student(name: name)
    print("\(name) 학생을 추가했습니다.\n")
}

private func removeStudent(name: String) {
    if name.isEmpty {
        print("입력이 잘못되었습니다. 다시 확인해주세요.\n")
        return
    }
    
    if !students.keys.contains(name) {
        print("\(name) 학생을 찾지 못했습니다.\n")
        return
    }
    
    students.removeValue(forKey: name)
    print("\(name) 학생을 삭제하였습니다.\n")
}

private func changeScore(studentScoreInfo: String) {
    let info = studentScoreInfo.split(separator: " ")
    
    if info.count != 3 {
        print("입력이 잘못되었습니다. 다시 확인해주세요.\n")
        return
    }
    
    let name = String(info[0])
    let subject = String(info[1])
    let score = String(info[2]).uppercased()
    
    guard let student = students[name] else {
        print("\(name) 학생을 찾지 못했습니다.\n")
        return
    }

    if !scores.contains(score) {
        // 성적이 잘못 입력됨
        print("입력이 잘못되었습니다. 다시 확인해주세요.\n")
        return
    }
    
    student.updateScore(subject: subject, score: score) 
    print("\(name) 학생의 \(subject) 과목이 \(score)로 추가(변경)되습니다.\n")
}

private func deleteScore(studentScoreInfo: String) {
    let info = studentScoreInfo.split(separator: " ")
    
    if info.count != 2 {
        print("입력이 잘못되었습니다. 다시 확인해주세요.\n")
        return
    }
    
    let name = String(info[0])
    let subject = String(info[1])
    
    guard let student = students[name] else {
        print("\(name) 학생을 찾지 못했습니다.\n")
        return
    }
    
    if !student.hasScore(subject: subject) {
        // 해당 과목의 성적이 없음.
        print("입력이 잘못되었습니다. 다시 확인해주세요.\n")
        return
    }
    
    student.deleteScore(subject: subject)
    print("\(name) 학생의 \(subject) 과목의 성적이 삭제되었습니다.\n")
}

