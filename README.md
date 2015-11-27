# Gradient Circular Progress

Customizable progress indicator library in Swift

## Requirements
- Swift 2.0
- iOS 8.0 or later

## Screen Shots

- Preset style: [BlueDarkStyle.swift](https://github.com/keygx/GradientCircularProgress/blob/master/Source/BlueDarkStyle.swift)

![](images/scr_BlueDarkStyle_01.png)  ![](images/scr_BlueDarkStyle_02.png)

- All preset styles

![](images/styles_01.png) 
![](images/styles_02.png) 

## Installation

###CocoaPods

* PodFile [Sample/PodFile]

```PodFile
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'GradientCircularProgress', :git => 'https://github.com/keygx/GradientCircularProgress'
```
* install

```
$ pod install
```

###Carthage

* Cartfile

```Cartfile
github "keygx/GradientCircularProgress"
```

```
$ carthage update
```
* install

To integrate "GradientCircularProgress.framework" into your Xcode project


## Style Settings

Please make your original styles

![](images/properties.png)

- Define custom style structs that implements the StyleProperty Protocol

[MyStyle.swift](https://github.com/keygx/GradientCircularProgress/blob/master/Sample/MyStyle.swift)

```swift
import GradientCircularProgress

public struct MyStyle : StyleProperty {
    /*** style properties **********************************************************************************/
    
    // Progress Size
    public var progressSize: CGFloat = 200
    
    // Gradient Circular
    public var arcLineWidth: CGFloat = 18.0
    public var startArcColor: UIColor = UIColor.clearColor()
    public var endArcColor: UIColor = UIColor.orangeColor()
    
    // Base Circular
    public var baseLineWidth: CGFloat? = 19.0
    public var baseArcColor: UIColor? = UIColor.darkGrayColor()
    
    // Ratio
    public var ratioLabelFont: UIFont? = UIFont(name: "Verdana-Bold", size: 16.0)
    public var ratioLabelFontColor: UIColor? = UIColor.whiteColor()
    
    // Message
    public var messageLabelFont: UIFont? = UIFont.systemFontOfSize(16.0)
    public var messageLabelFontColor: UIColor? = UIColor.whiteColor()
    
    // Background
    public var backgroundStyle: BackgroundStyles = .Dark
    
    /*** style properties **********************************************************************************/
    
    public init() {}
}

```

![](images/scr_MyStyle.png)

## Usage
```swift
import GradientCircularProgress
```
```swift
let progress = GradientCircularProgress()

let ratio: CGFloat = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)        

progress.showAtRatio(style: MyStyle())
progress.updateRatio(ratio)
progress.dismiss()
```
```swift
let progress = GradientCircularProgress()

progress.show(message: "Loading...", MyStyle())
progress.dismiss()
```

## Download Progress Examples

### NSURLSession

```swift
let progress = GradientCircularProgress()

~~

progress.showAtRatio(style: BlueDarkStyle())
        
let url = NSURL(string: "http://example.com/download/dummy.mp4")
let config = NSURLSessionConfiguration.defaultSessionConfiguration()
let session = NSURLSession(configuration: config, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
let task = session.downloadTaskWithURL(url!)
task.resume()

~~

// Delegate
func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
    let ratio: CGFloat = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
    progress.updateRatio(ratio)
}
// Delegate
func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
    progress.dismiss()
}
```

### Alamofire

```swift
let progress = GradientCircularProgress()

~~

progress.showAtRatio(style: BlueDarkStyle())

Alamofire.request(.GET, "http://example.com/download/dummy.mp4")
    .response { (request, response, data, error) in
        
        self.progress.dismiss()
}
    .progress { (bytesRead, totalBytesRead, totalBytesExpectedToRead) in
        let ratio: CGFloat = CGFloat(totalBytesRead) / CGFloat(totalBytesExpectedToRead)
        // Call main thread.
        dispatch_async(dispatch_get_main_queue(), {
            self.progress.updateRatio(ratio)
        })
}
```

## API
```swift
public func showAtRatio(display display: Bool = true, style: StyleProperty = Style()) -> Void

public func updateRatio(ratio: CGFloat)

public func show(style style: StyleProperty = Style()) -> Void

public func show(message message: String, style: StyleProperty = Style()) -> Void

public func dismiss() -> Void

public func dismiss(completionHandler: () -> Void) -> ()
```

## License

Gradient Circular Progress is released under the MIT license. See LICENSE for details.

## Author

Yukihiko Kagiyama (keygx) <https://twitter.com/keygx>

