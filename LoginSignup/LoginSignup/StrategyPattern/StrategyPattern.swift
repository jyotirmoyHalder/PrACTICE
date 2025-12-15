//
//  StrategyPattern.swift
//  LoginSignup
//
//  Created by jyotirmoy_halder on 15/12/25.
//

import SwiftUI

struct StrategyPattern: View {
    @State private var brightness = 0.75
    
    var body: some View {
        Slider(value: $brightness, in: 0...1) {
            Text("Brightness")
        } ticks: {
            SliderTick(0)
            SliderTick(0.25)
            SliderTick(0.50)
            SliderTick(0.75)
            SliderTick(1)
        }
        Text("Some text")
            .onAppear {
                //    var logger: Logger1 = Logger1(style: .uppercase)
                var logger = Logger(strategy: CapitalizedStrategy())
                logger.log("my first strategy")  // My First Strategy

                logger = Logger(strategy: UppercaseStrategy())
                logger.log("my first strategy")  // MY FIRST STRATEGY

                
                logger = Logger(strategy: LowercaseStrategy())
                logger.log("my first strategy")  // my first strategy
            }
    }
        
}

#Preview {
    StrategyPattern()
}


// we can implement like this using enum and switch block. The problem is if we want to add a new LogStyle then we have to update the enum also the switch cases
struct Logger1 {
    
    enum LogStyle {
        case lowercase
        case uppercase
        case capitalized
    }
    
    let style: LogStyle
    
    func log(_ message: String) {
        switch style {
        case .lowercase:
            print(message.lowercased())
        case .uppercase:
            print(message.uppercased())
        case .capitalized:
            print(message.capitalized)
        }
    }
}

// Instead what we can do to make it highly sclable

// What
protocol LoggerStrategy {
    func log(_ message: String)
}
// Who
struct Logger {
    let strategy: LoggerStrategy
    
    func log(_ message: String) {
        strategy.log(message)
    }
}
// How
struct LowercaseStrategy: LoggerStrategy {
    func log(_ message: String) {
        print(message.lowercased())
    }
}

struct UppercaseStrategy: LoggerStrategy {
    func log(_ message: String) {
        print(message.uppercased())
    }
}

struct CapitalizedStrategy: LoggerStrategy {
    func log(_ message: String) {
        print(message.capitalized)
    }
}

