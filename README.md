# TraktKit
[![Build Status](https://travis-ci.org/svenbacia/TraktKit.svg?branch=master)](https://travis-ci.org/svenbacia/TraktKit)
[![codecov](https://codecov.io/gh/svenbacia/TraktKit/branch/master/graph/badge.svg)](https://codecov.io/gh/svenbacia/TraktKit)
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

Optionally you can also pass in a custom `URLSession`, `Keychain` and/or `Configuration`.

### Authorization
```Swift
// use the trakt.authorizationURL to login a new user
let safariViewController = SFSafariViewController(URL: trakt.authorizationURL)
presentViewController(safariViewController, animated: true, completion: nil)
```

Once the user completes the login, the response will be redirected back to the application. Call `trakt.exchangeAccessToken(for:completion:)` which will exchange the code for an accessToken.

```Swift
func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {

  guard let query = url.query else { return false }
  guard let code = query.components(separatedBy: "=").last else { return false }

  trakt.exchangeAccessToken(for: code) { result in 
    switch result {
    case .success(let token):
      // successfully received an accessToken.
    case .failure(let error):
      // could not get an accessToken. Check the `error` for more information.
    }  
  }
}
```

### Requests
All endpoints can be requested via the `trakt.load(resource:authenticated:completion:)` function. The `resource` parameter describes an endpoint. For example:

```swift
trakt.load(resource: trakt.resources.explore.shows.trending(), authenticated: false) { (result) in                                                                       	switch result {
	case .success(let shows):
		// [TrendingShow]
	case .failure(let error):
		// oh no, something unexpected happend. Check the error for more information.
	}
}
```
`TraktKit` will automically parse the JSON response for nearly all endpoints. In this case the JSON will be decoded to an array of `TrendingShow` objects.

#### Endpoints
The `resources` property helps to find the endpoint you are looking for. For example, the endpoint for the summary of a specific episode can be accessed like this:

```swift
trakt.resources.show(107717).season(1).episode(1).summary()
```

Looking for the comments of the same episode? Just swap out the last `summary()` function with the `comments()` function and pass the resource to the `load(resource:completion:)` function.

## License

The MIT License (MIT)

Copyright (c) 2018 Sven Bacia

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
