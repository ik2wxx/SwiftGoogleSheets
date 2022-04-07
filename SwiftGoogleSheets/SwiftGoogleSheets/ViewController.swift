//
//  ViewController.swift
//  SwiftGoogleSheets
//
//  Created by Roberto Sonzogni on 07/04/22.
//

import GoogleAPIClientForREST
import GoogleSignIn
import GTMSessionFetcher
import Toast_Swift
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signIn(sender: Any) {
        let signInConfig = GIDConfiguration(clientID: Globals.shared.YOUR_CLIENT_ID)
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else {
                self.view.makeToast("errore 1")
                return
            }

            // If sign in succeeded, display the app's main content View.
            guard
                let user = user
            else {
                self.view.makeToast("errore 2")
                return
            }

            // Your user is signed in!
            Globals.shared.gUser = user
            Globals.shared.sheetService.authorizer = Globals.shared.gUser.authentication.fetcherAuthorizer()
            print("logged in: \(user.profile?.name ?? "")")
            self.view.makeToast("logged in: \(user.profile?.name ?? "")")
        }
    }

    @IBAction func signOut(sender: Any) {
        GIDSignIn.sharedInstance.signOut()
        print("logged out")
        view.makeToast("logged out")
    }

    @IBAction func addScope() {
        let newScope = kGTLRAuthScopeSheetsSpreadsheets
        let grantedScopes = Globals.shared.gUser.grantedScopes

        if grantedScopes == nil || !grantedScopes!.contains(newScope) {
            view.makeToast("scope not present")

            // Request additional scope.
            let additionalScopes = [newScope]
            GIDSignIn.sharedInstance.addScopes(additionalScopes, presenting: self) { user, error in
                guard error == nil else {
                    self.view.makeToast("error 3")
                    return
                }
                guard let user = user else {
                    self.view.makeToast("error 4")
                    return
                }

                Globals.shared.gUser = user
                Globals.shared.sheetService.authorizer = Globals.shared.gUser.authentication.fetcherAuthorizer()

                // Check if the user granted access to the scopes you requested.
                let grantedScopes = Globals.shared.gUser.grantedScopes
                if grantedScopes!.contains(newScope) {
                    self.view.makeToast("scope added")
                }
            }
        } else {
            view.makeToast("scope already present")
        }
    }

    @IBAction func read() {
        let range = "B2"
        let query = GTLRSheetsQuery_SpreadsheetsValuesGet.query(withSpreadsheetId: Globals.shared.YOUR_SHEET_ID, range: range)
        Globals.shared.sheetService.executeQuery(query) { (_: GTLRServiceTicket, result: Any?, error: Error?) in
            if let error = error {
                print("Error", error.localizedDescription)
                self.view.makeToast(error.localizedDescription)
            } else {
                let data = result as? GTLRSheets_ValueRange
                let rows = data?.values as? [[String]] ?? [[""]]
                for row in rows {
                    print("row: ", row)
                    self.view.makeToast("value \(row.first ?? "") read in \(range)")
                }
                print("success")
            }
        }
    }

    @IBAction func write() {
        let range = "B2"
        let valueRange = GTLRSheets_ValueRange(json: [
            "majorDimension": "ROWS",
            "range": range,
            "values": [
                [
                    10,
                ],
            ],
        ])

        let query = GTLRSheetsQuery_SpreadsheetsValuesUpdate.query(withObject: valueRange, spreadsheetId: Globals.shared.YOUR_SHEET_ID, range: range)
        query.valueInputOption = "USER_ENTERED"
        query.includeValuesInResponse = true

        Globals.shared.sheetService.executeQuery(query) { (_: GTLRServiceTicket, result: Any?, error: Error?) in
            if let error = error {
                print("Error", error.localizedDescription)
                self.view.makeToast(error.localizedDescription)
            } else {
                let data = result as? GTLRSheets_UpdateValuesResponse
                let rows = data?.updatedData?.values as? [[String]] ?? [[""]]
                for row in rows {
                    print("row: ", row)
                    self.view.makeToast("value \(row.first ?? "") wrote in \(range)")
                }
                print("success")
            }
        }
    }
}
