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

@property (nullable, nonatomic, copy, setter = dk_setImagePicker:) DKImagePicker dk_imagePicker;

@property (nullable, nonatomic, copy, setter = dk_setSelectedImagePicker:) DKImagePicker dk_selectedImagePicker;

- (void)dk_setTitleAttributePicker:(DKAttributePicker)picker forState:(UIControlState)state;

@end

NS_ASSUME_NONNULL_END
