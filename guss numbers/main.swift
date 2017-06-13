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
func substring(str:String?,start:Int,len:Int)->String{
    if len > 0 {
        if let str = str{
            let sLen = Int(strlen(str))
            let newstart = start > sLen ?sLen : start
            let lenth = len > (sLen - newstart) ? (sLen - newstart) : len
            let Findex = str.index(str.startIndex,offsetBy:newstart)
            let Eindex = str.index(str.startIndex,offsetBy:newstart + lenth)
            return str[Findex..<Eindex]
        }else{
            return ""
        }
    }else{
        if let str = str{
            let sLen = Int(strlen(str))
            let newstart = start > sLen ?sLen : start
            let Snum = (newstart+len) > 0 ? (newstart+len) : 0
            let Eindex = str.index(str.startIndex,offsetBy:newstart)
            let Findex = str.index(str.startIndex,offsetBy:Snum)
            return str[Findex..<Eindex]
        }else{
            return "" 
        }
    }

}

//HW3堅固
//func substring(str:String,start:Int,len:Int)->String{
//    //str.startIndex為什麼不能寫0因為這個欄位的type是string.Index
//    let sindex = str.index(str.startIndex, offsetBy: start)
//    let eindex = str.index(str.startIndex, offsetBy: start + len)
//    let range = sindex..<eindex
//    
//    return str[range]
//}

let args = CommandLine.arguments
var i = 0
//for arg in args {
//    
//    i += 1
//    print(i)
//    print(arg)
//}

//print(type(of:args[1]))
let d:Int? = Int(args[1])


//主流程
let answer = createAnswer(d ?? 0)
//print(answer)
var guess:String?
var isWin:Bool = false

for i in 1...10{
    var isWong:Bool = false
    repeat{
        print("\(i).請猜一數字", terminator:"")
        isWong = false
        var n = d ?? 0
        guess = readLine()
        
//        print(type(of:strlen(guess)))
        
//        print(type(of:guess))
        var check:[Bool] = Array(repeating:false,count:10)
        if let gus = guess {
            if var num = Int(gus) {
                // 		print(num)
                for i in 0..<n{
                    var index = num % (10)
                    num /= 10
                    // 			print(index)
                    isWong = check[index]
                    check[index] = true
                }
            }else{
                isWong = true
            }
        }else{
            isWong = true
        }
        var readn = Int(strlen(guess))
        
        if readn != n {
            isWong = true
        }
    }while isWong
    //檢查 1.[0-9] 2.no reapt  HW1
    if let gus = guess{
        let result = checkAB(answer: answer, guess: gus)
        print("\(answer)=>\(result)")
        if result == "\(d ?? 0)A0B" {
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






