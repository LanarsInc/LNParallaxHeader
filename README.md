# LNParallaxHeader

[![Version](https://img.shields.io/cocoapods/v/LNParallaxHeader.svg?style=flat)](https://cocoapods.org/pods/LNParallaxHeader)
[![Platform](http://img.shields.io/badge/platform-iOS-green.svg?style=flat)](https://github.com/LanarsInc/LNParallaxHeader)
![Swift 5.0](https://img.shields.io/badge/Swift-5.0-orange.svg)
[![License](http://img.shields.io/badge/license-BSD-lightgrey.svg?style=flat)](https://github.com/LanarsInc/LNParallaxHeader/blob/master/LICENSE)

![Preview](https://github.com/LanarsInc/LNParallaxHeader/blob/master/Resources/Demo.gif)

## Requirements
- iOS 10.0+
- Xcode 11
- Swift 5

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate [LNParallaxHeader](https://github.com/LanarsInc/LNParallaxHeader) into your Xcode project using CocoaPods, specify it in your Podfile:

```ruby
pod 'LNParallaxHeader'
```

### Manually

If you prefer not to use any of the aforementioned dependency managers, you can integrate LNParallaxHeader into your project manually.

## Usage

1. You can add LNParallaxHeaderFlowLayout to CollectionViewFlowLayout

![Preview](https://github.com/LanarsInc/LNParallaxHeader/blob/master/Resources/ParallaxHeaderFlowLayout.png)

2. Or you can programmatically create

Import LNParallaxHeader module to your class 
```swift
import LNParallaxHeader
```
Сustomize for yourself

```swift
func prepareCollectionViewLayout() {
    let width = UIScreen.main.bounds.size.width
    let layout = LNParallaxHeaderFlowLayout(minSize: CGSize(width: width, height: 44.0), size: CGSize(width: width, height: 180.0))
    layout.itemSize = CGSize(width: width, height: layout.itemSize.height)
    layout.isAlwaysOnTop = true
    collectionView.collectionViewLayout = layout
}
```
Also check out an example project with [parallax header view](https://github.com/LanarsInc/LNParallaxHeader/tree/master/Example)

## License

Copyright © 2020 Lanars

https://lanars.com

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
