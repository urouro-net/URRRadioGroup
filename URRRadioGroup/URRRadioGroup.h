//
//  URRRadioGroup.h
//  URRRadioGroupExample
//
//  Created by Kenta Nakai on 2014/03/17.
//  Copyright (c) 2014年 Kenta Nakai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URRRadioGroup : NSObject

- (void)addButton:(UIButton *)button defaultText:(NSString *)defaultText selectedText:(NSString *)selectedText;
- (void)addButton:(UIButton *)button defaultImage:(UIImage *)defaultImage selectedImage:(UIImage *)selectedImage;
- (void)selectButton:(UIButton *)button;

@end
