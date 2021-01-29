//
//  CanvasView.swift
//  COWA
//
//  Created by Lucas Deane on 12/3/20.
//

import UIKit

class CanvasView: UIView {

    var lines = [TouchPointAndColor]()
    var tempLines = [TouchPointAndColor]()
    var strokeWidth: CGFloat = 2.5
    var strokeColor: UIColor = .black
    var canDraw = false
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        lines.forEach {
            (line) in
            for (i, p) in (line.points?.enumerated())! {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
                
                context.setStrokeColor(line.color?.withAlphaComponent(1.0).cgColor ?? UIColor.black.cgColor)
                context.setLineWidth(line.width ?? 1.0)
            }
            context.setLineCap(.round)
            context.strokePath()
        }
        update(state: state)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (canDraw && ableToEdit) {
            lines.append(TouchPointAndColor(color: UIColor(), points: [CGPoint]()))
            update(state: state)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (ableToEdit) {
        guard var touch = touches.first?.location(in: nil) else {
            return
       }
        
        guard var lastPoint = lines.popLast() else {
            return
        }
        
        touch.y -= 105
        lastPoint.points?.append(touch)
        lastPoint.color = strokeColor
        lastPoint.width = strokeWidth
        lines.append(lastPoint)
        update(state: state)
        
        setNeedsDisplay()
    }
    }

    func undoDraw() {
        if lines.count > 0 {
            update(state: state)
            tempLines.append(lines.popLast()!)
            setNeedsDisplay()
        }
    }
    
    func redoDraw() {
        if (tempLines.count > 0) {
            update(state: state)
            lines.append(tempLines.popLast()!)
            setNeedsDisplay()
        }
    }
    
    func update(state: String) {
        switch state {
        case currentForm[0]:
            print("intructions page")
        case currentForm[1]:
            master[assessment].lines1[pageNumber - 1] = lines
            master[assessment].tempLines1[pageNumber - 1] = tempLines
        case currentForm[2]:
            master[assessment].lines2[pageNumber - 1] = lines
            master[assessment].tempLines2[pageNumber - 1] = tempLines
        case currentForm[3]:
            master[assessment].lines3[pageNumber - 1] = lines
            master[assessment].tempLines3[pageNumber - 1] = tempLines
        default:
            print("canvas updating bad")
        }
    }
    
}
