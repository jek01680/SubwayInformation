//
//  StationListViewCell.swift
//  SubwayStation
//
//  Created by 정은경 on 2022/04/11.
//

import UIKit
import SnapKit

final class StationListViewCell: UICollectionViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .label
        return label
    }()
    
    func setup(with realTimeArraival: StationArrivalDatResponseModel.RealTimeArrival){
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
        
        backgroundColor = .systemBackground
        
        [titleLabel, detailLabel].forEach{ addSubview($0) }
        
        titleLabel.snp.makeConstraints{
            $0.leading.top.equalToSuperview().inset(16)
        }
        
        detailLabel.snp.makeConstraints{
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        titleLabel.text = realTimeArraival.line
        detailLabel.text = realTimeArraival.remainTime
        
    }
}
