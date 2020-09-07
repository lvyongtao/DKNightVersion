//
//  DKAttribute.h
//  DKNightVersion
//
//  Created by TaoaiM on 2020/9/7.
//  Copyright © 2020 Draveness. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DKAttribute : NSObject


typedef NSString DKThemeVersion;

typedef NSDictionary *(^DKAttributePicker)(DKThemeVersion *themeVersion);

DKAttributePicker DKAttributePickerWithAttributes(NSDictionary *normal, ...);


@end

NS_ASSUME_NONNULL_END
