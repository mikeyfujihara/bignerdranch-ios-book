//
//  QuizAppDelegate.h
//  Quiz
//
//  Created by Mikey Fujihara on 4/30/13.
//  Copyright (c) 2013 Mikey Fujihara. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuizViewController;

@interface QuizAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) QuizViewController *viewController;

@end
