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
    var lines1: [TouchPointAndColor]
    var tempLines1: [TouchPointAndColor]
    var lines2: [TouchPointAndColor]
    var tempLines2: [TouchPointAndColor]
    var lines3: [TouchPointAndColor]
    var tempLines3: [TouchPointAndColor]
    
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
        lines1 = [TouchPointAndColor]()
        tempLines1 = [TouchPointAndColor]()
        lines2 = [TouchPointAndColor]()
        tempLines2 = [TouchPointAndColor]()
        lines3 = [TouchPointAndColor]()
        tempLines3 = [TouchPointAndColor]()
    }
    
}

var assessment = -1
var currentAssessment = -1
var detailAssessment = 0
var detailMode = false

var ableToEdit = true
var normalMode = false

var master = [Assessment]()
var state: String = ""
var currentForm = [String]()
var selectedAssessment: Assessment?

