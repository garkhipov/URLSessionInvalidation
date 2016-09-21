//
//  XCUIApplication+SpringBoard.h
//  URLSessionInvalidation
//
//  Created by Gleb Arkhipov on 21.09.16.
//  Copyright © 2016 Gleb Arkhipov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface XCUIElement (Tests)

- (instancetype)initPrivateWithPath:(nullable id)path
                           bundleID:(NSString*)bundleID;

- (void)resolve;

@end


@interface XCUIApplication (SpringBoard)

+ (instancetype)fb_SpringBoard;

- (void)fb_tapApplicationWithIdentifier:(NSString *)identifier;

@end



NS_ASSUME_NONNULL_END
