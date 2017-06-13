//
//  main.swift
//  guss numbers
//
//  Created by user on 2017/6/12.
//  Copyright © 2017年 user. All rights reserved.
//

import Foundation

//產生謎底

func createAnswer(_ num:Int)->String{
    var rs = Set<Int>()
    var rand:Int
    while rs.count < num{
        rand = Int(arc4random_uniform(10))
        rs.insert(rand)
    }
    var ret = ""
    for v in rs{
        ret.append(String(v))
    }
    
    return ret
}

//比對 ->String =>(A:Int,B:Int)
func checkAB(answer:String,guess:String)->String{
    var A = 0,B = 0
    var ca=String() , cg=String()
    for i in 0..<answer.characters.count{
        ca = substring(str: answer, start: i, len: 1)
        cg = substring(str: guess, start: i, len: 1)
        if cg == ca {
            A += 1
        }else if answer.contains(cg){
            B += 1
        }
    }
    
    
    return "\(A)A\(B)B"
}
//HW3堅固
func substring(str:String,start:Int,len:Int)->String{
    //str.startIndex為什麼不能寫0因為這個欄位的type是string.Index
    let sindex = str.index(str.startIndex, offsetBy: start)
    let eindex = str.index(str.startIndex, offsetBy: start + len)
    let range = sindex..<eindex
    
    return str[range]
}

//let args = CommandLine.arguments
//var i = 0
////for arg in args {
////    
////    i += 1
////    print(i)
////    print(arg)
////}
//
////print(type(of:args[1]))
//let d:Int? = Int(args[1])


//主流程
let answer = createAnswer(3)
print(answer)
var guess:String?
var isWin:Bool = false

for i in 1...10{
    var isWong:Bool = false
    print("\(i).請猜一數字", terminator:"")
    repeat{
        guess = readLine()
        
        print(type(of:guess))
        
        var check = Set<Int>()
        if let gus = guess{
            for ck in 0..<gus.characters.count{
                if Int(ck) < 10 {
                    isWong = true
                }else{
                  check.insert(Int(ck))
//                    isWong = true
                }
            }
        }else{
            isWong = true
        }
    }while(isWong)
    
    
    
    
    //檢查 1.[0-9] 2.no reapt  HW1
    
    if let gus = guess{
        let result = checkAB(answer: answer, guess: gus)
        print("\(answer)=>\(result)")
        if result == "\(3)A0B" {
            isWin=true
            break
        }
        
    }
}

if isWin{
    print("win")
}else{
    print("lose ans:\(answer)")
}






