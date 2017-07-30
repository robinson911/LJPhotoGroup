//
//  LJPhotoView.m
//  CommonDemo
//
//  Created by 孙伟伟 on 2017/7/26.
//  Copyright © 2017年 孙伟伟. All rights reserved.
//

#import "LJPhotoView.h"

@implementation LJPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.ljImageview];
        
        [self setZoomScale:1.0 animated:NO];
        self.maximumZoomScale = 1;
    }
    return self;
}

- (UIImageView*)ljImageview
{
    if (!_ljImageview)
    {
        _ljImageview = UIImageView.new;
        _ljImageview.clipsToBounds = YES;
        _ljImageview.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _ljImageview;
}

//在LJPhotoGroupView中切换图片时，重新设置info信息
- (void)setCurrentImageview:(LJPhotoInfo*)info
{
    self.ljImageview.image = info.ljImageview.image;
    
    float  y = (kDEVICEHEIGHT - info.ljImageview.image.size.height * kDEVICEWIDTH / info.ljImageview.image.size.width) * 0.5;
    
    _ljImageview.frame = CGRectMake(0, y, kDEVICEWIDTH, kDEVICEWIDTH*info.ljImageview.image.size.height/info.ljImageview.image.size.width);
}
@end

