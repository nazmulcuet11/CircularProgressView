//
//  CircularProgressView.swift
//  CircularProgressView
//
//  Created by Nazmul's Mac Mini on 27/12/20.
//

import UIKit

class CircularProgressView: UIView {

    private lazy var progressLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = .round

        return layer
    }()

    private lazy var trackLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = .round
        return layer
    }()

    var trackColor: UIColor = UIColor.systemBlue.withAlphaComponent(0.5) {
        didSet {
            setNeedsLayout()
        }
    }

    var progressColor: UIColor = .systemBlue {
        didSet {
            setNeedsLayout()
        }
    }

    var lineWidth: CGFloat = 10.0 {
        didSet {
            setNeedsLayout()
        }
    }

    var progress = CGFloat(0.0) {
        didSet {
            if progress < 0 {
                progress = 0
            } else if progress > 1 {
                progress = 1
            }

            setNeedsLayout()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() -> Void {
        layer.addSublayer(trackLayer)
        layer.addSublayer(progressLayer)

        trackLayer.frame = self.bounds
        progressLayer.frame = self.bounds
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configureLayers()
    }

    private func configureLayers() {
        let path = getCircularPath(progress: 1.0)

        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = lineWidth
        trackLayer.path = path.cgPath
        trackLayer.strokeStart = 0.0
        trackLayer.strokeEnd = 1.0

        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = lineWidth
        progressLayer.path = path.cgPath
        progressLayer.strokeStart = 0.0
        progressLayer.strokeEnd = progress
    }

    private func getCircularPath(progress: CGFloat) -> UIBezierPath {
        let centerPoint = CGPoint(x: self.bounds.width / 2.0, y: self.bounds.height / 2.0)
        let radius = min(frame.width, frame.height) / 2.0

        let startAngle = -(CGFloat.pi / 2.0)
        let endAngle = getAdjustedEndAngle(progress: progress, startAngle: startAngle)

        let path = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        return path
    }

    private func getAdjustedEndAngle(progress: CGFloat, startAngle: CGFloat) -> CGFloat {
        let endAngle = progress * 2 * CGFloat.pi
        let adjustedEndAngle = endAngle + startAngle
        return adjustedEndAngle
    }

}

