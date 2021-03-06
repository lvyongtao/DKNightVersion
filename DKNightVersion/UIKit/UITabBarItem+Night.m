//
//  UITabBarItem+Night.m
//  DKNightVersion
//
//  Created by TaoaiM on 2020/9/7.
//  Copyright © 2020 Draveness. All rights reserved.
//

#import "UITabBarItem+Night.h"

@interface UITabBarItem ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *pickers;


@end
@implementation UITabBarItem (Night)


- (void)dk_setTitleAttributePicker:(DKAttributePicker)picker forState:(UIControlState)state {
    [self setTitleTextAttributes:picker(self.dk_manager.themeVersion) forState:state];
    
    NSString *key = [NSString stringWithFormat:@"%@", @(state)];
    NSMutableDictionary *dictionary = [self.pickers valueForKey:key];
    if (!dictionary) {
        dictionary = [[NSMutableDictionary alloc] init];
    }
    [dictionary setValue:[picker copy] forKey:NSStringFromSelector(@selector(setTitleTextAttributes:forState:))];
    [self.pickers setValue:dictionary forKey:key];
}

- (void)dk_setImage:(DKImagePicker)picker forState:(UIControlState)state {
    
    if (UIControlStateNormal == state) {
        UIImage *image = picker(self.dk_manager.themeVersion);
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self setImage:image];
    } else if (UIControlStateSelected == state) {
        UIImage *image = picker(self.dk_manager.themeVersion);
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self setSelectedImage:image];
    }
    
    NSString *key = [NSString stringWithFormat:@"%@", @(state)];
    NSMutableDictionary *dictionary = [self.pickers valueForKey:key];
    if (!dictionary) {
        dictionary = [[NSMutableDictionary alloc] init];
    }
    
    if (UIControlStateNormal == state) {
        [dictionary setValue:[picker copy] forKey:NSStringFromSelector(@selector(setImage:))];
    } else if (UIControlStateSelected == state) {
        [dictionary setValue:[picker copy] forKey:NSStringFromSelector(@selector(setSelectedImage:))];
    }
    [self.pickers setValue:dictionary forKey:key];
}

- (void)night_updateColor {
    
    [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary<NSString *, DKAttributePicker> *dictionary = (NSDictionary *)obj;
            [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull selector, DKAttributePicker  _Nonnull picker, BOOL * _Nonnull stop) {
                UIControlState state = [key integerValue];
                if ([selector isEqualToString:NSStringFromSelector(@selector(setTitleTextAttributes:forState:))]) {
                    NSDictionary *attribute = picker(self.dk_manager.themeVersion);
                    [self setTitleTextAttributes:attribute forState:state];
                } else if ([selector isEqualToString:NSStringFromSelector(@selector(setImage:))]) {
                    if (UIControlStateNormal == state) {
                        UIImage *resultImage = ((DKImagePicker)picker)(self.dk_manager.themeVersion);
                        resultImage = [resultImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

                        [self setImage:resultImage];
                    }
                } else if ([selector isEqualToString:NSStringFromSelector(@selector(setSelectedImage:))]) {
                    if (UIControlStateSelected == state) {
                        UIImage *resultImage = ((DKImagePicker)picker)(self.dk_manager.themeVersion);
                        resultImage = [resultImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                        [self setSelectedImage:resultImage];
                    }
                }
            }];
        } else {
            SEL sel = NSSelectorFromString(key);
            DKAttributePicker picker = (DKAttributePicker)obj;
            NSDictionary *attribute = picker(self.dk_manager.themeVersion);
            [UIView animateWithDuration:DKNightVersionAnimationDuration
                             animations:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                                 [self performSelector:sel withObject:attribute];
#pragma clang diagnostic pop
                             }];
            
        }
    }];
}


@end
