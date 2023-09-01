# catalyst-searchbar

This repository has been inspired by a Stackoverflow question where the OP was asking how to add UISearchBar in a toolbar for a macCatalyst app (using NSToolbarItem). This was a legitimate question as Apple did not provide any mechanism to roll your own UIView in a macCatalyst toolbar at the time of the question. Having encountered a similar situation before and noticing that as of macOS 13 you can now put any UIView in the toolbar, we decided to test this. To our surprise, sanctioned way of doing this did not quite work as expected. However, we didn't give up and with some tinkering we were able to embed a NSSearchBar from AppKit into our macCatalyst application. See the resuls below:

![NSSearchBar in action](https://github.com/eclypse-tms/catalyst-searchbar/assets/10276667/aac6ba0e-18cc-441c-9193-12abfa8a95e1)

## Example Project

The repository includes an example project where you can run and see the implementation details. Feel free to use this solution in your project. However, the example uses bunch of shortcuts that are not central to the primary point of this project. Please note that this has been tested with macOS 13. 
