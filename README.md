# catalyst-searchbar

This repository has been inspired by a Stackoverflow question where the OP was asking how to add UISearchBar in a toolbar for a macCatalyst app (using NSToolbarItem). This was a legitimate question as Apple did not provide any mechanism to roll your own UIView in a macCatalyst toolbar at the time of the question. Having encountered a similar situation before and noticing that as of macOS 13 you can now put any UIView in the toolbar, we decided to test this. To our surprise, embedding a custom UIView in toolbar did not work as expected. However, we didn't give up and with some tinkering we were able to embed a NSSearchBar from AppKit into our macCatalyst application. See the resuls below:

![NSSearchBar in action](https://github.com/eclypse-tms/catalyst-searchbar/assets/10276667/aac6ba0e-18cc-441c-9193-12abfa8a95e1)

## Example Project

The repository includes an example project where you can run and see the implementation details. Feel free to use this solution in your project. However, the example uses bunch of shortcuts that are not central to the primary point of this project. Please note that this has been tested with macOS 13. 

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
