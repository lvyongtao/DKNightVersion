//
//  UITabBarItem+Night.h
//  DKNightVersion
//
//  Created by TaoaiM on 2020/9/7.
//  Copyright © 2020 Draveness. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+Night.h"
#import "DKAttribute.h"
#import <DKNightVersion/DKNightVersion.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBarItem (Night)

- (void)dk_setTitleAttributePicker:(DKAttributePicker)picker forState:(UIControlState)state;
- (void)dk_setImage:(DKImagePicker)picker forState:(UIControlState)state;

@end

NS_ASSUME_NONNULL_END
