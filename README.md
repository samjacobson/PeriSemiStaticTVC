# PeriSemiStaticTVC

[![CI Status](http://img.shields.io/travis/Sam Jacobson/PeriSemiStaticTVC.svg?style=flat)](https://travis-ci.org/Sam Jacobson/PeriSemiStaticTVC)
[![Version](https://img.shields.io/cocoapods/v/PeriSemiStaticTVC.svg?style=flat)](http://cocoadocs.org/docsets/PeriSemiStaticTVC)
[![License](https://img.shields.io/cocoapods/l/PeriSemiStaticTVC.svg?style=flat)](http://cocoadocs.org/docsets/PeriSemiStaticTVC)
[![Platform](https://img.shields.io/cocoapods/p/PeriSemiStaticTVC.svg?style=flat)](http://cocoadocs.org/docsets/PeriSemiStaticTVC)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

PeriSemiStaticTVC is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "PeriSemiStaticTVC"

## Author

Sam Jacobson, sam@eversoft.co.nz

## License

PeriSemiStaticTVC is available under the MIT license. See the LICENSE file for more info.

## About

Static TableViews in Storyboards are a very quick and expressive way to develop user interfaces. The downside is that the iOS SDK does not make it clear or easy to extend static tableviews with dynamic content.

PeriSemiStaticTVC attempts to fulfil this need. The technique that it utilises is to handle (and redirect) calls before they reach UITableViewController. For this to work your View Controller should inherit from PeriSemiStaticTVC instead of UITableViewController (PeriSemiStaticTVC is itself a subclass of UITableViewController).

There are many possible use cases for adding dynamic content to a storyboard/static tableview, but there are two which cover the majority of cases:

* The ability to *mask* (or hide) a cell in the tableview
* The ability to make a section of the tableview *dynamic* (i.e. driven by a data source) while leaving the rest of the tableview static.

## Masked rows

PeriSemiStaticTVC has a few methods for masking (hiding) rows:

    - (void)mask:(BOOL)mask staticPath:(NSIndexPath *)staticPath withRowAnimation:(UITableViewRowAnimation)animation;

This is the method that hides (or shows) the given row. The cell will be deleted or inserted into the tableview with the requested animation.

Also, for convenience the additional methods:

    - (void)toggleMaskStaticPath:(NSIndexPath *)staticPath withRowAnimation:(UITableViewRowAnimation)animation;
    - (BOOL)isStaticPathMasked:(NSIndexPath *)staticPath;


## Paths

When cells come and go (by being masked) from the table view the index paths of other cells obviously changes. PeriSemiStaticTVC differentiates between the current index path of a cell (a *tablePath*), and the original index path of the cell (a *staticPath*).

All requests to mask/unmask should reference the static path.

PeriSemiStaticTVC supplies a couple of methods to convert between them:

    - (NSIndexPath *)tablePathForStaticPath:(NSIndexPath *)staticPath;
    - (NSIndexPath *)staticPathForTablePath:(NSIndexPath *)tablePath;

## Tags

As a convenience, and in the general spirit of keeping a Storyboard alive throughout the lifespan of a project, PeriSemiStaticTVC provides a cell tagging facility.

It employs the "User Defined Runtime Attributes" feature of the Storyboard editor. To tag a cell supply a user defined attribute on the cell with the keypath "peritag" of type String.

Usage of tags from code is then straightforward:

    - (NSIndexPath *)staticPathForTag:(NSString *)tag;
    - (NSString *)tagForTablePath:(NSIndexPath *)tablePath;

## Dynamic Sections

Finally, a section of a PeriSemiStaticTVC can be set as dynamic.  The data source for the dynamic section is a little different to a normal UITableViewDataSource primarily because it provides only a single section of data. There is a gotcha when implementing dynamic sections because the path into the data may not necessarily reflect the path into the table, e.g. the dynamic section may be section-2 whereas the data that is backing it from core data uses a query that returns only a single section.

Use PeriSectionArrayDataSource or PeriSectionCoreDataSource for your dynamic sections, or use them as examples for implementing your own. The only requirement is that the dynamic section must subclass PeriDynamicSection.

It is not possible to include prototype cells in a static tableview in a storyboard. To workaround this for dynamic sections PeriSemiStaticTVC uses a xib file for dynamic cells. The Dynamic Section registers the xib with the tableview so it can use it as a prototype for cells.
