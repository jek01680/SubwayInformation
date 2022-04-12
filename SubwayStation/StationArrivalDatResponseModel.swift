//
//  StationArrivalDatResponseModel.swift
//  SubwayStation
//
//  Created by 정은경 on 2022/04/12.
//

import Foundation


struct StationArrivalDatResponseModel: Decodable {
    var realtimeArrivalList: [RealTimeArrival] = []

    struct RealTimeArrival: Decodable {
        let line: String /// ~행
        let remainTime: String /// 도착까지 남은 시간 or 전역 출발
        let currentStation: String /// 현재 위치

        enum CodingKeys: String, CodingKey {
            case line = "trainLineNm"
            case remainTime = "arvlMsg2"
            case currentStation = "arvlMsg3"
        }
    }
}