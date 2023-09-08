//
//  PlayMapper.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 9/8/23.
//

import Foundation
import Models
import SwiftMLB

struct PlayMapper {
    let dataObject: MLBPlay?
    
    let dateFormatter = DateFormatter.iso8601TimeZoneOmitted
    
    func toDomain() -> Play? {
        guard let playDTO = dataObject, let matchupDTO = playDTO.matchup else {
            return nil
        }
        
        let result = Play.Result(type: playDTO.result.type,
                                 event: playDTO.result.event,
                                 eventType: playDTO.result.eventType,
                                 description: playDTO.result.description,
                                 rbi: playDTO.result.rbi ?? 0,
                                 awayScore: playDTO.result.awayScore,
                                 homeScore: playDTO.result.homeScore,
                                 isOut: playDTO.result.isOut ?? false)
        
        let endTime: Date? = dateFormatter.date(from: playDTO.about.endTime)
        let about = Play.Detail(atBatIndex: playDTO.about.atBatIndex,
                                halfInning: playDTO.about.halfInning,
                                inning: playDTO.about.inning,
                                hasOut: playDTO.about.hasOut ?? false,
                                endTime: endTime,
                                isScoringPlay: playDTO.about.isScoringPlay ?? false)
        
        let matchup = Play.Matchup(batter: .init(id: matchupDTO.batter.id,
                                                 fullName: matchupDTO.batter.fullName),
                                   pitcher: .init(id: matchupDTO.pitcher.id,
                                                  fullName: matchupDTO.pitcher.fullName))
        var count: Count?
        if let countDto = playDTO.count {
            count = Count(balls: countDto.balls,
                          strikes: countDto.strikes,
                          outs: countDto.outs)
        }
        
        let eventsDTO = playDTO.playEvents ?? []
        
        let events = eventsDTO.compactMap { eventDto in
            return mapPlayEvent(dto: eventDto)
        }
        
        let play = Play(result: result,
                        about: about,
                        matchup: matchup,
                        count: count,
                        events: events)
        
        return play
    }
    
    private func mapPlayEvent(dto eventDTO: MLBPlay.Event) -> Play.Event? {
        
        var pitchData: Play.PitchInfo?
        if let pitchInfoDto = eventDTO.pitchData, let startSpeed = pitchInfoDto.startSpeed, let endSpeed = pitchInfoDto.endSpeed {
            pitchData = Play.PitchInfo(pitchStartSpeed: startSpeed,
                                           pitchEndSpeed: endSpeed)
        }
        
        var count: Count?
        if let countDto = eventDTO.count {
            count = Count(balls: countDto.balls,
                          strikes: countDto.strikes,
                          outs: countDto.outs)
        }
        
        var hitData: Play.HitInfo?
        if let hitDataDto = eventDTO.hitData {
            hitData = Play.HitInfo(launchSpeed: hitDataDto.launchAngle,
                                   launchAngle: hitDataDto.launchAngle,
                                   totalDistance: hitDataDto.totalDistance)
        }
        
        let event = Play.Event(count: count,
                               pitchInfo: pitchData,
                               hitInfo: hitData,
                               callCode: eventDTO.details?.call?.code ?? "",
                               callDescription: eventDTO.details?.call?.description ?? "" ,
                               pitchTypeCode: eventDTO.details?.type?.code ?? "",
                               pitchTypeDescription: eventDTO.details?.type?.description ?? "",
                               isInPlay: eventDTO.details?.isInPlay ?? false,
                               isStrike: eventDTO.details?.isStrike ?? false,
                               isBall: eventDTO.details?.isBall ?? false)
        
        return event

    }
}

struct PlayDetailMapper {
    
    let dataObject: MLBPlays
    
    func toDomain() -> PlayDetail {
        
        let allPlaysDto = dataObject.allPlays
        let plays = allPlaysDto.compactMap { playDto in
            return mapPlay(from: playDto)
        }
        
        var currentPlay: Play?
        if let currentPlayDto = dataObject.currentPlay {
            currentPlay = mapPlay(from: currentPlayDto)
        }
        
        return PlayDetail(allPlays: plays,
                          currentPlay: currentPlay)
    }
    
    func mapPlay(from playDTO: MLBPlay) -> Play? {
        
        let mapper = PlayMapper(dataObject: playDTO)
        return mapper.toDomain()
    }
}

extension DateFormatter {
    static let iso8601TimeZoneOmitted: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter
    }()
}
