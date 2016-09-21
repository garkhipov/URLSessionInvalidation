//
//  XCUIApplication+SpringBoard.m
//  URLSessionInvalidation
//
//  Created by Gleb Arkhipov on 21.09.16.
//  Copyright © 2016 Gleb Arkhipov. All rights reserved.
//

#import "XCUIApplication+SpringBoard.h"

/// Source: https://github.com/facebook/WebDriverAgent/blob/8a251d5c309d98671be36469d6ff64f4598198b8/XCTWebDriverAgentLib/Categories/XCUIApplication%2BSpringBoard.m
@implementation XCUIApplication (SpringBoard)

+ (instancetype)fb_SpringBoard
{
    XCUIApplication *springboard = [[XCUIApplication alloc] initPrivateWithPath:nil bundleID:@"com.apple.springboard"];
    [springboard resolve];
    return springboard;
}

- (void)fb_tapApplicationWithIdentifier:(NSString *)identifier
{
    NSLog(@"%@", [self descendantsMatchingType:XCUIElementTypeAny]);
    XCUIElement *appElement = [[self descendantsMatchingType:XCUIElementTypeAny]
                               elementMatchingPredicate:[NSPredicate predicateWithFormat:@"identifier = %@", identifier]
                               ];
    [appElement tap];
}

@end
