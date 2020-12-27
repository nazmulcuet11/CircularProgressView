//
//  ViewController.swift
//  CircularProgressView
//
//  Created by Nazmul's Mac Mini on 27/12/20.
//

import UIKit

class ViewController: UIViewController {

    private lazy var progressView: CircularProgressView = {
        let cp = CircularProgressView()
        cp.translatesAutoresizingMaskIntoConstraints = false
        return cp
    }()
    private lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        return label
    }()

    private var totalSeconds: CGFloat = 0
    private var elapsedSeconds: CGFloat = 0
    private var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(progressView)
        view.addSubview(progressLabel)

        NSLayoutConstraint.activate([
            progressView.widthAnchor.constraint(equalToConstant: 100),
            progressView.heightAnchor.constraint(equalToConstant: 100),
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            progressLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        progressView.progress = 0

        totalSeconds = 10
        elapsedSeconds = 0

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {
            _ in
            self.handleTimer()
        })
    }

    private func handleTimer() {
        print(#function)

        elapsedSeconds += 1
        if elapsedSeconds >= totalSeconds {
            self.timer?.invalidate()
            self.timer = nil
        }

        let progress = CGFloat(elapsedSeconds / totalSeconds)
        progressView.progress = CGFloat(progress)
        progressLabel.text = String(format: "%.2lf %", progress)
    }
}

