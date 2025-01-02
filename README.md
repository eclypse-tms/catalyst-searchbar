<p align="center">
  <img width="150" height="150" src="./assets/app-icon.png">
</p>

<p align="center">
    <img src="https://img.shields.io/badge/Swift-5.x-orange?logo=swift" alt="Swift 5.x">
    <img src="https://img.shields.io/badge/iOS-15%2B-blue?logo=apple" alt="iOS 15+">
    <img src="https://img.shields.io/badge/macOS-12%2B-royalblue?logo=apple" alt="macOS 12+">
    <img src="https://img.shields.io/badge/License-MIT-lightgrey" alt="MIT License">
</p>

# macCatalyst Searchbar

This repository has been inspired by a Stackoverflow question where the OP was asking how to add UISearchBar in a toolbar for a macCatalyst app (using NSToolbarItem). This was a legitimate question as Apple did not provide any mechanism to roll your own UIView in a macCatalyst toolbar at the time of the question. Having encountered a similar situation before and noticing that as of macOS 13 you can now put any UIView in the toolbar, we decided to test this. To our surprise, embedding a custom UIView in toolbar did not work as expected. However, we didn't give up and with some tinkering we were able to embed a NSSearchBar from AppKit into our macCatalyst application. See the resuls below:

![NSSearchBar in action](https://github.com/eclypse-tms/catalyst-searchbar/assets/10276667/aac6ba0e-18cc-441c-9193-12abfa8a95e1)

## Implementation

We wrote a detailed blog on how to implement the search bar in your application [here](https://blog.eclypse.io/how-to-add-a-search-bar-to-a-maccatalyst-application-a0fde827be15). Please read the [linked blog](https://blog.eclypse.io/how-to-add-a-search-bar-to-a-maccatalyst-application-a0fde827be15) for additional details. This is a companion repository and an example project.

## Example Project

The repository includes an example project where you can run and see the implementation details. Feel free to use this solution in your project. However, the example uses bunch of shortcuts that are not central to the primary point of this project. Please note that this has been tested with macOS 13 and 14 while building with XCode 14 and 15.

## 3 Different Methods
There are 3 different methods showcased in this example project. There is a line in SceneDelegate that controls the searchbar flavor: `toolbarDelegate.searchBarVariant = .nsSearchBarCustom`. You may run the example with other variants and see how they are different from one and other. The other possibilities are:
```
enum SearchToolbarVariant: Int {
    /// uses UISearchBar from UIKit as a custom view in NSToolbarItem
    case uiSearchBar
    
    /// uses NSSearchBar from AppKit as a custom view in NSToolbarItem
    case nsSearchBarCustom
    
    /// uses prebuilt NSSearchToolbarItem from AppKit
    case nsSearchBarDefault
}
```

#### .uiSearchBar variant

<img width="600" alt="Search bar with UIKit" src="https://github.com/eclypse-tms/catalyst-searchbar/assets/10276667/2cc91d45-c8dc-4ce0-9778-6fcaf0ab0f22">

#### .nsSearchBarCustom / .nsSearchBarDefault variant

<img width="600" alt="Search bar with AppKit" src="https://github.com/eclypse-tms/catalyst-searchbar/assets/10276667/43902546-0859-496d-a646-a1129fb8343b">

## Troubleshooting

The example project does not have team or account settings configured. If you have trouble running the project or encounter errors while loading the framework's bundle, you may want to change the bundle identifier, configure a team and a provisioning profile according to your own account settings as shown below. 

#### Main Target
![Main Target](https://github.com/eclypse-tms/catalyst-searchbar/assets/10276667/7b2b13b4-adcf-4044-b028-244fcbee9839)

#### macOS Target
![macOS Framework](https://github.com/eclypse-tms/catalyst-searchbar/assets/10276667/c9de5d2a-5217-4e49-bc84-d00a19cc2fb5)

#### App entitlements
You can also disable App sandboxing and other settings as necessary in order to be able to load the linked framework.

![Entitlements file](https://github.com/eclypse-tms/catalyst-searchbar/assets/10276667/0a0a7c21-de95-42d5-846b-875242b873b1)
