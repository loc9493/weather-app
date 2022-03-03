//
//  NetworkError.swift
//  openWeather
//
//  Created by Nguyen Loc on 3/3/22.
//

import Foundation


enum NetworkError: Error {
    /// Not connected to the internet.
    case ParseError
    
    /// Not connected to the internet.
    case NotConnectedToInternet
    
    /// BadRequest
    case BadRequest
    
    /// Cannot reach the server.
    case NotReachedServer
    
    /// Connection is lost.
    case ConnectionLost
    
    /// Incorrect data returned from the server.
    case IncorrectDataReturned
    
    /// Unknown or not supported error.
    case Unknown
    
    internal init(error: NSError) {
        if error.domain == NSURLErrorDomain {
            switch error.code {
            case NSURLErrorNotConnectedToInternet:
                self = .NotConnectedToInternet
            case NSURLErrorCannotFindHost, NSURLErrorCannotConnectToHost, NSURLErrorTimedOut, NSURLErrorDNSLookupFailed:
                self = .NotReachedServer
            case NSURLErrorNetworkConnectionLost:
                self = .ConnectionLost
            default:
                self = .Unknown
            }
        } else {
            self = .Unknown
        }
    }
}



extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .NotConnectedToInternet:
            return NSLocalizedString(
                "Can't connect to Internet. Please check again.",
                comment: ""
            )
        case .NotReachedServer:
            return NSLocalizedString(
                "Can't connect to Server. Please check again.",
                comment: ""
            )
        case .ConnectionLost:
            return NSLocalizedString(
                "Connection lost. Please check again.",
                comment: ""
            )
        case .IncorrectDataReturned:
            return NSLocalizedString(
                "Incorrect data returned. Please check again.",
                comment: ""
            )
        case .Unknown:
            return NSLocalizedString(
                "Unknown Error. Please check again.",
                comment: ""
            )
        case .BadRequest:
            return NSLocalizedString(
                "Unknown Error. Please check again.",
                comment: ""
            )
        case .ParseError:
            return NSLocalizedString(
                "Parse data error",
                comment: ""
            )
        }
    }
}
