//
//  DKAttribute.h
//  DKNightVersion
//
//  Created by TaoaiM on 2020/9/7.
//  Copyright © 2020 Draveness. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSString DKThemeVersion;

typedef NSDictionary *_Nonnull(^DKAttributePicker)(DKThemeVersion *themeVersion);

DKAttributePicker DKAttributePickerWithAttributes(NSDictionary *normal, ...);


@interface DKAttribute : NSObject

@end

NS_ASSUME_NONNULL_END
