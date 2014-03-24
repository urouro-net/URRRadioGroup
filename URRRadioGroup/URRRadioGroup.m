//
//  URRRadioGroup.m
//  URRRadioGroupExample
//
//  Created by Kenta Nakai on 2014/03/17.
//  Copyright (c) 2014年 Kenta Nakai. All rights reserved.
//

#import "URRRadioGroup.h"

@interface URRRadio : NSObject
@property(nonatomic,strong) UIButton *control;
@property(nonatomic,strong) NSString *defaultText;
@property(nonatomic,strong) NSString *selectedText;
@property(nonatomic,strong) UIImage *defaultImage;
@property(nonatomic,strong) UIImage *selectedImage;
@end

@implementation URRRadio
@end


@interface URRRadioGroup()
{
    NSMutableArray *_buttons;
}

@end

@implementation URRRadioGroup

- (id)init
{
    self = [super init];
    if(!self){
        return nil;
    }
    
    _buttons = [[NSMutableArray alloc] initWithCapacity:0];
    
    return self;
}

- (void)dealloc
{
    [_buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if([obj isKindOfClass:[URRRadio class]]){
            UIButton *button = [(URRRadio *)obj control];
            for(UIGestureRecognizer *recognizer in [button gestureRecognizers]){
                [button removeGestureRecognizer:recognizer];
            }
        }
    }];
    
    [_buttons removeAllObjects];
}

- (void)addButton:(UIButton *)button defaultText:(NSString *)defaultText selectedText:(NSString *)selectedText
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [button addGestureRecognizer:tap];
    
    URRRadio *radio = [URRRadio new];
    radio.control = button;
    radio.defaultText = defaultText;
    radio.selectedText = selectedText;
    
    [_buttons addObject:radio];
    
    [self tap:tap];
}

- (void)addButton:(UIButton *)button defaultImage:(UIImage *)defaultImage selectedImage:(UIImage *)selectedImage
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [button addGestureRecognizer:tap];
    
    URRRadio *radio = [URRRadio new];
    radio.control = button;
    radio.defaultImage = defaultImage;
    radio.selectedImage = selectedImage;
    
    [_buttons addObject:radio];
    
    [self tap:tap];
}

- (void)tap:(UITapGestureRecognizer *)recognizer
{
    __weak UIButton *button = (UIButton *)recognizer.view;
    
    [self selectButton:button];
}

- (void)selectButton:(UIButton *)button
{
    [_buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        URRRadio *radio = (URRRadio *)obj;
        if(button == radio.control){
            if(radio.selectedImage){
                [radio.control setImage:radio.selectedImage forState:UIControlStateNormal];
                [radio.control setImage:radio.selectedImage forState:UIControlStateHighlighted];
                [radio.control setImage:radio.selectedImage forState:UIControlStateSelected];
            }else{
                [radio.control setTitle:radio.selectedText forState:UIControlStateNormal];
            }
        }else{
            if(radio.defaultImage){
                [radio.control setImage:radio.defaultImage forState:UIControlStateNormal];
                [radio.control setImage:radio.defaultImage forState:UIControlStateHighlighted];
                [radio.control setImage:radio.defaultImage forState:UIControlStateSelected];
            }else{
                [radio.control setTitle:radio.defaultText forState:UIControlStateNormal];
            }
        }
    }];
}


@end
