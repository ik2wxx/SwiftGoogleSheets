# SwiftGoogleSheets

I asked myself how to read and write data from Google Sheets from a Swift app, and found no tutorial and no info!
So I thought to add one myself when I have a working one.
This app is not about how to develop an app, and how to use all Google Sheets api, you have to learn this by yourself.

To make this app work, you'll need to:

Have Xcode and pod installed.

Download files
execute command 'pod install'

Please note that Toast-Swift is not required for Google Sheets Api, it's just for showing info in this app.

Get sheet id from sheet url (create a new sheet if you don't have one)
i.e. https://docs.google.com/spreadsheets/d/YOUR_SHEET_ID/edit#gid=0
get the part in place of YOUR_SHEET_ID and copy it into Globals.swift as "YOUR_SHEET_ID"

Go to https://console.cloud.google.com/ and create a new project
remember to add yourself as a tester

go to https://console.cloud.google.com/apis/library/sheets.googleapis.com?project=YOUR_PROJECT_NAME
(replace YOUR_PROJECT_NAME with yours) and enable "Google Sheets API" for project

go to https://console.cloud.google.com/apis/credentials/consent?project=YOUR_PROJECT_NAME
select user of "external" type and add required infos

go to https://console.cloud.google.com/apis/credentials?project=YOUR_PROJECT_NAME
add credentials of oauth type, fill all required fields and copy into Globals.swift as "YOUR_CLIENT_ID"

Client id must be added to app's Target/Info/Url Types/Url Schemes, in reverse order:

client id example: 123123123-aaabbbcccdddeeefff.apps.googleusercontent.com

reverse order example: com.googleusercontent.apps.123123123-aaabbbcccdddeeefff

go to https://console.cloud.google.com/apis/credentials?project=YOUR_PROJECT_NAME
add credentials of "api key" type and copy it into Globals.swift as YOUR_API_KEY

Run the app.
You will need to grant access to your Google account.
If "add scope" does not work, maybe you forgot to add yourself as project tester (go back in Google Cloud's project home and do it)
