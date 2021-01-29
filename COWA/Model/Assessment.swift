//
//  TouchPointAndColor.swift
//  COWA
//
//  Created by Lucas Deane on 12/10/20.
//

import UIKit

class TouchPointAndColor {
    
    var color: UIColor? = nil
    var width: CGFloat? = nil
    var points: [CGPoint]? = nil
    
    init(color: UIColor, points: [CGPoint]) {
        self.color = color
        self.points = points
    }
}

class Assessment {
    var AID: String
    var SID: String
    var visitNum: Int
    var visitDate: String
    var formNum: Int
    var T1R: Int
    var T1E: Int
    var T1T: Int
    var T2R: Int
    var T2E: Int
    var T2T: Int
    var T3R: Int
    var T3E: Int
    var T3T: Int
    var sumR: Int
    var sumE: Int
    var sumT: Int
    
    var exported: Int
    var checked: Bool
    var lines1: [[TouchPointAndColor]]
    var tempLines1: [[TouchPointAndColor]]
    var lines2: [[TouchPointAndColor]]
    var tempLines2: [[TouchPointAndColor]]
    var lines3: [[TouchPointAndColor]]
    var tempLines3: [[TouchPointAndColor]]
    
    init?(AID: String, SID: String, visitNum: Int, visitDate: String, formNum: Int) {
        self.AID = AID
        self.SID = SID
        self.visitNum = visitNum
        self.visitDate = visitDate
        self.formNum = formNum
        
        T1R = 0
        T1E = 0
        T1T = 0
        T2R = 0
        T2E = 0
        T2T = 0
        T3R = 0
        T3E = 0
        T3T = 0
        sumR = 0
        sumE = 0
        sumT = 0
        
        exported = 0
        checked = false
        lines1 = [[TouchPointAndColor]]()
        tempLines1 = [[TouchPointAndColor]]()
        lines2 = [[TouchPointAndColor]]()
        tempLines2 = [[TouchPointAndColor]]()
        lines3 = [[TouchPointAndColor]]()
        tempLines3 = [[TouchPointAndColor]]()
        
        let emptyLineArray11 = [TouchPointAndColor]()
        let emptyLineArray12 = [TouchPointAndColor]()
        let emptyLineArray13 = [TouchPointAndColor]()
        let emptyLineArray21 = [TouchPointAndColor]()
        let emptyLineArray22 = [TouchPointAndColor]()
        let emptyLineArray23 = [TouchPointAndColor]()
        let emptyLineArray31 = [TouchPointAndColor]()
        let emptyLineArray32 = [TouchPointAndColor]()
        let emptyLineArray33 = [TouchPointAndColor]()
        let emptyTempLineArray11 = [TouchPointAndColor]()
        let emptyTempLineArray12 = [TouchPointAndColor]()
        let emptyTempLineArray13 = [TouchPointAndColor]()
        let emptyTempLineArray21 = [TouchPointAndColor]()
        let emptyTempLineArray22 = [TouchPointAndColor]()
        let emptyTempLineArray23 = [TouchPointAndColor]()
        let emptyTempLineArray31 = [TouchPointAndColor]()
        let emptyTempLineArray32 = [TouchPointAndColor]()
        let emptyTempLineArray33 = [TouchPointAndColor]()
        lines1.append(emptyLineArray11)
        lines1.append(emptyLineArray12)
        lines1.append(emptyLineArray13)
        lines2.append(emptyLineArray21)
        lines2.append(emptyLineArray22)
        lines2.append(emptyLineArray23)
        lines3.append(emptyLineArray31)
        lines3.append(emptyLineArray32)
        lines3.append(emptyLineArray33)
        tempLines1.append(emptyTempLineArray11)
        tempLines1.append(emptyTempLineArray12)
        tempLines1.append(emptyTempLineArray13)
        tempLines2.append(emptyTempLineArray21)
        tempLines2.append(emptyTempLineArray22)
        tempLines2.append(emptyTempLineArray23)
        tempLines3.append(emptyTempLineArray31)
        tempLines3.append(emptyTempLineArray32)
        tempLines3.append(emptyTempLineArray33)
    }
    
}

var assessment = -1
var currentAssessment = -1
var detailAssessment = 0
var detailMode = false

var ableToEdit = true
var normalMode = false

var pageNumber = 1

var master = [Assessment]()
var state: String = ""
var currentForm = [String]()
var selectedAssessment: Assessment?

