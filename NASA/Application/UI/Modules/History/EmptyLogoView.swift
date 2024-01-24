//
//  EmptyLogoView.swift
//  NASA
//
//  Created by    Sergey on 24.01.2024.
//

import UIKit

@IBDesignable
final class EmptyLogoView: UIView {

    @IBInspectable var firstColor: UIColor = .gray
    @IBInspectable var secondColor: UIColor = .lightGray

    override func draw(_ rect: CGRect) {
        drawBackground(in: rect)
        drawCenterFigure(in: rect)
        drawTopFigure(in: rect)
        drawBottomFigure(in: rect)
        drawCircle(in: rect)
    }

    private func drawCircle(in rect: CGRect) {
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = rect.width / 2
        let path = UIBezierPath(arcCenter: center,
                                radius: radius + 10,
                                startAngle: 0,
                                endAngle: CGFloat.pi * 2,
                                clockwise: true)
        path.lineWidth = 40
        backgroundColor?.setStroke()
        path.stroke()
    }

    private func drawCenterFigure(in rect: CGRect) {
        let newRect = CGRect(x: 0, y: rect.height / 3, width: rect.width, height: rect.height / 2)
        let path = UIBezierPath(rect: newRect)
        secondColor.setFill()
        path.fill()
    }

    private func drawBackground(in rect: CGRect) {
        let path = UIBezierPath(rect: rect)
        backgroundColor?.setFill()
        path.fill()
    }

    private func drawTopFigure(in rect: CGRect) {
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = rect.width / 2
        let path = UIBezierPath(arcCenter: center,
                                radius: radius,
                                startAngle: 7 * CGFloat.pi / 6.4,
                                endAngle: 11 * CGFloat.pi / 5.7,
                                clockwise: true)
        let endPoint = CGPoint(x: rect.width - 175, y: center.y - 45)
        let firstControlPoint = CGPoint(x: center.x + 20, y: center.y - 50)
        let secondControlPoint = CGPoint(x: center.x - 1, y: center.y + 40)
        path.addCurve(to: endPoint, controlPoint1: firstControlPoint, controlPoint2: secondControlPoint)
        path.lineWidth = 20
        backgroundColor?.setStroke()
        path.stroke()
        firstColor.setFill()
        path.fill()
    }

    private func drawBottomFigure(in rect: CGRect) {
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = rect.width / 2
        let path = UIBezierPath(arcCenter: center,
                                radius: radius,
                                startAngle: 6 * CGFloat.pi / 7,
                                endAngle: 12 * CGFloat.pi / 5.7,
                                clockwise: false)

        let endPoint = CGPoint(x: rect.width - 170, y: center.y + 35)
        let firstControlPoint = CGPoint(x: center.x + 10, y: center.y + 70)
        let secondControlPoint = CGPoint(x: center.x - 10, y: center.y + 10)
        path.addCurve(to: endPoint, controlPoint1: firstControlPoint, controlPoint2: secondControlPoint)
        path.lineWidth = 20
        backgroundColor?.setStroke()
        firstColor.setFill()
        path.stroke()
        path.fill()
    }
}
