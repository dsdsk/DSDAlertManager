# DSDAlertManager

<!-- [![CI Status](http://img.shields.io/travis/dsdsk/DSDAlertManager.svg?style=flat)](https://travis-ci.org/dsdsk/DSDAlertManager) -->

[![Version](https://img.shields.io/cocoapods/v/DSDAlertManager.svg?style=flat)](http://cocoapods.org/pods/DSDAlertManager)
[![License](https://img.shields.io/cocoapods/l/DSDAlertManager.svg?style=flat)](http://cocoapods.org/pods/DSDAlertManager)
[![Platform](https://img.shields.io/cocoapods/p/DSDAlertManager.svg?style=flat)](http://cocoapods.org/pods/DSDAlertManager)

DSDAlertManager is intended to simplify the dialog display in iOS.

## Requirements

* iOS 8.0+

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

DSDAlertManager is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "DSDAlertManager"
```

## Usage

### OK button only

```
[DSDAlertManager showAlert:self
                     title:@"title"
                   message:@"message"
                        ok:^{
                            NSLog(@"OK tap!");
                        }];
```

### OK button only (Customize button label)

```
[DSDAlertManager showAlert:self
                     title:@"title"
                   message:@"message"
                   okLabel:@"CustomOK"
                        ok:^{
                            NSLog(@"OK tap!");
                        }];
```

### OK and Cancel buttons

```
[DSDAlertManager showAlert:self
                     title:@"title"
                   message:@"message"
                        ok:^{
                            NSLog(@"OK tap!");
                        }
                    cancel:^{
                        NSLog(@"Cancel tap!");
                    }];
```

### YES and NO buttons

```
[DSDAlertManager showAlert:self
                     title:@"title"
                   message:@"message"
                       yes:^{
                           NSLog(@"YES tap!");
                       }
                        no:^{
                            NSLog(@"NO tap!");
                        }];
```

### YES and NO buttons (Customize button label)

```
[DSDAlertManager showAlert:self
                     title:@"title"
                   message:@"message"
                  yesLabel:@"CustomYES"
                       yes:^{
                           NSLog(@"YES tap!");
                       }
                   noLabel:@"CustomNO"
                        no:^{
                            NSLog(@"NO tap!");
                        }];
```

### Possible value input

```
[DSDAlertManager showEditAlert:self
                         title:@"title"
                       message:@"message"
                         value:_dataSources[4].value
                            ok:^(NSString *value) {
                                NSLog(@"OK(%@) tap!", value);
                            }
                        cancel:^{
                            NSLog(@"Cancel tap!");
                        }];
```

## Author

dsdsk

## License

DSDAlertManager is available under the MIT license. See the LICENSE file for more info.
