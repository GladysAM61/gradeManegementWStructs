//
//  main.swift
//  gradeManagementWStructs
//
//  Created by StudentAM on 2/6/24.
//

//creating a struct containt the student info that will be needed
struct Student{
    var name: String
//    an array of strings
    var grades:[String]
    var finalGrades: Double
}

//create an empty array to append the info into
var students: [Student] = []

import Foundation
import CSV

//grabbing the file with all the data
//doing this by using a do statement
do{
//    picking the grade file
    let stream = InputStream(fileAtPath: "/users/studentAM/Desktop/grades.csv")
//creating a csvReader to grab data from the file
    let csv = try CSVReader(stream: stream!)
//creating a while loop to grab the data from the stream
    while let row = csv.next(){
        manageData(data: row)
    }
}
catch{
   print("wrong")
}

//array name is data
func manageData( data : [String]){
//creating a variable to hold the row of array
    var tempGrades: [String] = []
    var names: String = ""
    var finalGrade: Double = 0.0
//    creating a for loop to append the indices
   for i in data.indices{
      if i==0{
          names=data[i]
        }
      else{
           tempGrades.append(data[i])
            
        }
    }
    finalGrade = calcFinalGrades(grades: tempGrades)
    var studentInfo = Student(name: names, grades: tempGrades, finalGrades: finalGrade)
    students.append(studentInfo)
    
}



//creating a function to print out the questions
func startingQuestions(){
    print("Welcome to the Grade Manager! What would you like to do today?")
    print("1.) Display a grade for a student")
    print("2.) Display all grades for a student")
    print("3.) Display all grades for all students")
    print("4.) Average of the class")
    print("5.) Average of an assignment")
    print("6.) Lowest grade of the class")
    print("7.) Highest grade of the class")
    print("8.) Filter students by grade range")
    print("9.) Quit")
    
    if let userInput = readLine(){
//        if the user types 0, run the display one grade function
        if userInput == "1"{
           studentGrade()
        }
//        if the user types 2, run the oneGrade function
        if userInput == "2"{
            oneGradeOneStudent()
        }
//    if the user types 3, run the displayAllGrades function
        if userInput == "3"{
            displayAllGrades()
        }
        if userInput == "4"{
            averageClass()
        }
        if userInput == "5"{
            assignmentAverage()
        }
        if userInput == "6"{
            lowestGrade()
        }
        if userInput == "7"{
            highestGrade()
        }
        if userInput == "8"{
            filterByGrade()
        }
        if userInput == "9"{
            quit()
        }
    }
    
}

startingQuestions()


//creating a function to display the final grades for one student
func calcFinalGrades(grades:[String])-> Double{
        var sum: Int = 0
//    converting the strings into a int
        for everyGrade in grades{
            if let intGrades = Int(everyGrade){
//                adding all the grades in the sum string
                sum += intGrades
            }
        }
    var finalGrades = sum/grades.count
    return Double(finalGrades)
}

//creating a function to display the final grade for one student
func studentGrade(){
    print("Which student's grades would you like to print?")
    if let userInput = readLine(){
        for i in students.indices{
//            students[i].name to grab the name of the ith
//            .lowercased so that no matter how the user types the name it will still be good
            if students[i].name.lowercased() == userInput.lowercased(){
                print("\(students[i].name) final grade is: \(students[i].finalGrades)")
                return startingQuestions()
           }
        }
    }
}

func oneGradeOneStudent(){
    print("Which student's grades would you like to print?")
    //  allowing us to grab the userInput
    if let userInput = readLine(){
        for i in students.indices{
//            .lowercased so that no matter how the user types the name it will still be good
            if students[i].name.lowercased() == userInput.lowercased(){
                for j in students[i].grades{
                    //                two d array you need to go more into the array to take out the numbers
                    var newGradesString: String =  students[i].grades.joined(separator: ", ")
                    print(newGradesString)
                    
                    //                returning to stop the for loop so it doesn't keep running
                    return startingQuestions()
                }
            }
        }
    }
}

//creating a function to diplay all of the grades for all students
func displayAllGrades(){
    //    creating a for loop to go through all the names and all the grades
    for i in students.indices{
//        turning the grades array into strings
        var gradesString: String = students[i].grades.joined(separator: ", ")

        print("\(students[i].name) grades are: \(gradesString)")
        
    }
    return startingQuestions()
}

//creating a function to average the class
func averageClass(){
    var sum: Double = 0
//    student is storing the student info one by on temperalily
    for student in students{
        sum += student.finalGrades
    }
    var averageClassGrades = sum/Double(students.count)
//    format thing to making it only 2 decimals spaces
    print("The class average is \(String(format: "%.2f",averageClassGrades))")
    return startingQuestions()
}

//creating a function to find the average grade for one assignment
func assignmentAverage(){
    var assignmentAv: Double = 0
    var sum : Double = 0
    var userIndex : Int = 0
    print("What assignment number do you want to find the average for?(1-9)")
    if let userInput = readLine(), let index = Int(userInput){
        userIndex += index
//        for i in students.indices{
            for student in students{
                //            += to add to all of the sums and not just one
                //              turning grades string into an Int
                if let gradesNum = Double(student.grades[index - 1]){
                    sum += gradesNum
                }
                }
            }
//        }
        assignmentAv = sum/Double(students.count)
    print("The average grade for assignment \(userIndex) is: \(String(format: "%.2f",assignmentAv))")
    return startingQuestions()
}

//creating a function to find the lowest grade
func lowestGrade(){
//    creating a variable storing the first grade assuming its the lowest grade
    var lowest : Double = students[0].finalGrades
//    creating an index
    var index : Int = 0
//    for loop to go through the grades and find the lowest one
//    students.indices is going through the index
    for i in students.indices{
        if students[i].finalGrades < lowest{
                lowest = students[i].finalGrades
                index = i
            }
    }
    print("\(students[index].name) has the lowest grade: \(lowest)")
   return startingQuestions()
}

//creating a function to find the lowest grade
func highestGrade(){
//    creating a variable storing the first grade assuming its the lowest grade
    var highest : Double = students[0].finalGrades
//    creating an index
    var index : Int = 0
//    for loop to go through the grades and find the lowest one
//    students.indices is going through the index
    for i in students.indices{
        if students[i].finalGrades > highest{
                highest = students[i].finalGrades
                index = i
            }
    }
    print("\(students[index].name) has the highest grade: \(highest)")
   return startingQuestions()
}

//function to filter the grade by range
func filterByGrade(){
    print("Enter the low range you would like to use?")
    //    inside the if statement to get access for both
    if let userInput = readLine(), let lowRange = Int(userInput){
        print("Enter the high range you would like to use?")
        if let userInput = readLine(), let highRange = Int(userInput){
            //            checking the i in final grades
            for i in students.indices{
                //                for stu in students[i].finalGrades{
                if lowRange < Int(students[i].finalGrades) && Int(students[i].finalGrades) < highRange{
                    print("\(students[i].name): \(students[i].finalGrades)")
                }
             }
           }

        
        }
    return startingQuestions()
}
    
    //creating a function so they can quit the management function
func quit(){
        print("Have a great rest of your day!")
    }
