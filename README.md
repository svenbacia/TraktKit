# TraktKit
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

TraktKit is a wrapper for the [trakt.tv](https://trakt.tv) API written in Swift.

## Getting Started

### Initialization

```Swift
// Get your credentials at https://trakt.tv/oauth/applications
let credentials = Credentials(
  clientID: "clientID",
  clientSecret: "clientSecret",
  redirectURI: "redirect://uri"
)

let trakt = Trakt(credentials: credentials)
```

### Authorization
```Swift
// use the trakt.authorizationURL to login a new user
let safariViewController = SFSafariViewController(URL: trakt.authorizationURL)
presentViewController(safariViewController, animated: true, completion: nil)
```

Once the user completes the login, the response will be redirected back to the application. Call `trakt.open(url:completion)` which will exchange to code for an accessToken.

```Swift
func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
  trakt.open(url: url) { result in 
    switch result {
    case .Success:
      // successfully received an accessToken
    case .Failure(let error):
      // could not get an accessToken. Check the `error` for more information.
    }  
  }
}
```

### Requests




## License

The MIT License (MIT)

Copyright (c) 2016 Sven Bacia

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
