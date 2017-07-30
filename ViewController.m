//
//  ViewController.m
//  LJPhotoGroup
//
//  Created by 孙伟伟 on 2017/7/30.
//  Copyright © 2017年 孙伟伟. All rights reserved.
//

#import "ViewController.h"
#import "LJPhotoGroupView.h"
#import "LJPhotoInfo.h"

@interface ViewController ()
{
    NSMutableArray *_ljImageArray;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _ljImageArray = [[NSMutableArray alloc]init];
    
    [self testImageViewAnimal];
}

- (void)testImageViewAnimal
{
    for (NSInteger i = 0; i < 5; i++) {
        UIImage *_ljImage = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",i+1]];
        UIImageView *_ljImageView = [[UIImageView alloc]init];
        _ljImageView.image = _ljImage;
        _ljImageView.tag = i;
        _ljImageView.frame = CGRectMake((kDEVICEWIDTH - 200)/2.0, 40 + i * 90, 200, 80);
        _ljImageView.contentMode = UIViewContentModeScaleAspectFit;
        _ljImageView.userInteractionEnabled = YES;
        [self.view addSubview:_ljImageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPhoto:)];
        [_ljImageView addGestureRecognizer:tap];
        
        [_ljImageArray addObject:_ljImageView];
    }
}

- (void)showPhoto:(UITapGestureRecognizer*)sender
{
    NSInteger selectIndex = [[(UIGestureRecognizer *)sender view] tag];
    
    LJPhotoInfo *_info = [[LJPhotoInfo alloc]init];
    //_info.ljUrlArray = self.ljUrlArray;
    _info.ljImageviewArray = _ljImageArray;
    _info.currentSelectIndex = selectIndex;
    _info.totalCount = _ljImageArray.count;
    
    LJPhotoGroupView *_ljPhotoGroupView = [[LJPhotoGroupView alloc]initByArray:_info frame:CGRectMake(0, 0, kDEVICEWIDTH, kDEVICEHEIGHT)];
    [_ljPhotoGroupView showView];
}

@end
