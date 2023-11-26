//
//  MonthlyEmotionAnalysisCVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/14/23.
//

import UIKit

import SnapKit
import Then
import DGCharts

final class MonthlyEmotionAnalysisCVC: UICollectionViewCell {
    
    // MARK: - Properties

    private var values: [Double] = [0, 0, 0]
    private var emotions: [String] = ["😶", "☺️", "😢"]
    private var colors: [UIColor] = [.mainColor, .sub1, .sub2]
    
    private var largestEmotionString = String()
    
    // MARK: - UI Components
    
    private let monthlyEmotionLabel = UILabel().then {
        $0.text = "월간 감정 분석"
        $0.font = .subTitle2
        $0.textColor = .font1
    }
        
    private lazy var pieChartView = PieChartView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let largestEmotionLabel = UILabel().then {
        $0.font = .body2
        $0.textColor = .font2
    }
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension MonthlyEmotionAnalysisCVC {
    func setData(model: EmotionPercentages) {
        self.values[0] = model.neutral
        self.values[1] = model.positive
        self.values[2] = model.negative
        updatePieChart()
        setLargestEmotionLabel()
    }
    
    private func setLargestEmotionLabel() {
        if let maxIndex = values.firstIndex(of: values.max() ?? 0) {
            switch maxIndex {
            case 0:
                self.largestEmotionString = "일반"
            case 1:
                self.largestEmotionString = "긍정"
            case 2:
                self.largestEmotionString = "부정"
            default:
                self.largestEmotionString = "보통"
            }
        }
        
        self.largestEmotionLabel.text = "\(largestEmotionString)적인 감정을 가장 많이 느꼈어요."
    }
    
    private func updatePieChart() {
        var dataEntries: [PieChartDataEntry] = []

        for (index, value) in values.enumerated() {
            let dataEntry = PieChartDataEntry(value: value, label: emotions[index])
            dataEntries.append(dataEntry)
        }

        let dataSet = PieChartDataSet(entries: dataEntries, label: "Emotions")
        let data = PieChartData(dataSet: dataSet)
        
        dataSet.colors = colors
        dataSet.xValuePosition = .insideSlice
        dataSet.yValuePosition = .insideSlice

        // 파이 차트 포맷
        pieChartView.data = data
        pieChartView.drawHoleEnabled = false
        pieChartView.transparentCircleColor = .clear
        pieChartView.usePercentValuesEnabled = true
        pieChartView.highlightPerTapEnabled = false
        
        // 범례 숨기기
        pieChartView.legend.enabled = false
        
        // 값 포맷터 설정
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 0
        formatter.multiplier = 1.0 /// 퍼센트 값으로 표시
        formatter.percentSymbol = "%"
        data.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        
        // 라벨 위치 조정
        pieChartView.entryLabelColor = .black
        pieChartView.entryLabelFont = .systemFont(ofSize: 12)
    }
}

// MARK: - UI & Layout

extension MonthlyEmotionAnalysisCVC {
    private func setUI() {
        self.backgroundColor = .white
    }
    
    private func setLayout() {
        self.addSubviews(monthlyEmotionLabel, pieChartView, largestEmotionLabel)
        
        monthlyEmotionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(27)
        }
        
        pieChartView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(170)
            make.top.equalTo(monthlyEmotionLabel.snp.bottom).offset(5)
        }
        
        largestEmotionLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
    }
}
