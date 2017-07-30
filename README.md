1. 一个简单的图片浏览放大缩小管理器
2.支持图片放大和缩小效果，同时图片是原去原回的放大缩小效果
3. 简单易用
简单使用如下：
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
