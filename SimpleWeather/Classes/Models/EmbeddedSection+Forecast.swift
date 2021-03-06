//
//  EmbeddedSection+Forecast.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/24/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

extension EmbeddedSection {

    static func from(forecast: Forecast) -> EmbeddedSection? {
        guard let hourly = forecast.hourly?.sorted(by: { $0.date < $1.date }),
            let sunrise = forecast.astronomy?.sunrise,
            let sunset = forecast.astronomy?.sunset
            else { return nil }

        var viewModels = [ForecastHourCellViewModel]()
        let limit = 12
        for hour in hourly {
            let timeOfDay = hour.date.timeOfDay(sunrise: sunrise, sunset: sunset)
            let viewModel = ForecastHourCellViewModel(
                date: hour.date,
                temp: hour.temp,
                conditionImageName: hour.condition.icon(night: timeOfDay == .night),
                chancePrecip: hour.pop
            )
            viewModels.append(viewModel)
            if viewModels.count >= limit { break }
        }
        return EmbeddedSection(identifier: "hourly" as NSString, items: viewModels)
    }
    
}

