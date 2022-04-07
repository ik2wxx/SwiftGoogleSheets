//
//  Globals.swift
//  SwiftGoogleSheets
//
//  Created by Roberto Sonzogni on 07/04/22.
//

import Foundation
import GoogleAPIClientForREST
import GoogleSignIn
import GTMSessionFetcher

class Globals: NSObject {
    
    let YOUR_SHEET_ID = ""
    let YOUR_API_KEY = ""
    let YOUR_CLIENT_ID = ""

    var gUser = GIDGoogleUser()
    let sheetService = GTLRSheetsService()

    override init() {
    }

    static var shared = Globals()
}
