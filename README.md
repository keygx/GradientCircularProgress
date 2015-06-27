# Gradient Circular Progress

Customizable progress indicator library in Swift

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

Please make your original style

![](images/properties.png)

- Inheritance Style class and override properties

```swift
import GradientCircularProgress

public class MyStyle : Style {
    
    override init() {
        super.init()
        /*** style properties **********************************************************************************/
        // Progress Size
        self.progressSize = 200
        
        // Gradient Circular
        self.arcLineWidth = 18.0
        self.startArcColor = UIColor.darkGrayColor()
        self.endArcColor = UIColor.greenColor()
        
        // Base Circular
        self.baseLineWidth = 19.0
        self.baseArcColor = UIColor.darkGrayColor()
        
        // Percentage
        self.ratioLabelFont = UIFont(name: "Verdana-Bold", size: 16.0)!
        self.ratioLabelFontColor = UIColor.whiteColor()
        
        // Message
        self.messageLabelFont = UIFont.systemFontOfSize(16.0)
        self.messageLabelFontColor = UIColor.whiteColor()
        
        // Background
        self.backgroundStyle = .Dark
        /*** style properties **********************************************************************************/
    }
}

```

## Usage
```swift
import GradientCircularProgress
```
```swift
var gcp = GCProgress()

let ratio: CGFloat = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)        

gcp.showAtRatio(style: MyStyle())
gcp.updateRatio(ratio)
gcp.dismiss()
```
```swift
GCProgress().show(message: "Loading...", MyStyle())
GCProgress().dismiss()
```

## API
```swift
public func showAtRatio(display: Bool = true, style: Style = Style())

public func updateRatio(ratio: CGFloat)

public func show(style: Style = Style())

public func show(#message: String, style: Style = Style())

public func dismiss()
```

## License

Gradient Circular Progress is released under the MIT license. See LICENSE for details.

## Author

Yukihiko Kagiyama (keygx) <https://twitter.com/keygx>

