//
//  UITabBarItem+Night.m
//  DKNightVersion
//
//  Created by TaoaiM on 2020/9/7.
//  Copyright © 2020 Draveness. All rights reserved.
//

#import "UITabBarItem+Night.h"
#import "DKNightVersionManager.h"
#import <objc/runtime.h>

@interface UITabBarItem ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *pickers;


@end
@implementation UITabBarItem (Night)


- (DKImagePicker)dk_imagePicker
{
    return objc_getAssociatedObject(self, @selector(dk_imagePicker));
}

- (DKImagePicker)dk_selectedImagePicker
{
    return objc_getAssociatedObject(self, @selector(dk_selectedImagePicker));
}

- (void)dk_setImagePicker:(DKImagePicker)picker
{
    objc_setAssociatedObject(self, @selector(dk_imagePicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.image = picker(self.dk_manager.themeVersion);

    NSString *key = NSStringFromSelector(@selector(setImage:));
    [self.pickers setValue:[picker copy] forKey:key];
}

- (void)dk_setSelectedImagePicker:(DKImagePicker)picker
{
    objc_setAssociatedObject(self, @selector(dk_imagePicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.selectedImage = picker(self.dk_manager.themeVersion);

    NSString *key = NSStringFromSelector(@selector(setSelectedImage:));
    [self.pickers setValue:[picker copy] forKey:key];
}


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

- (void)night_updateColor {

    [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary<NSString *, DKAttributePicker> *dictionary = (NSDictionary *)obj;
            [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull selector, DKAttributePicker  _Nonnull picker, BOOL * _Nonnull stop) {
                UIControlState state = [key integerValue];
                if ([selector isEqualToString:NSStringFromSelector(@selector(setTitleTextAttributes:forState:))]) {
                    NSDictionary *attribute = picker(self.dk_manager.themeVersion);
                    [self setTitleTextAttributes:attribute forState:state];
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
