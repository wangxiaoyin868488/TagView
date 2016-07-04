//
//  ViewController.m
//  TagView
//
//  Created by apple on 16/6/29.
//  Copyright © 2016年 白玉京. All rights reserved.
//


#define kheight ([UIScreen mainScreen].bounds.size.height)
#define kwidth ([UIScreen mainScreen].bounds.size.width)

#import "ViewController.h"
#import "EqualSpaceFlowLayout.h"

#import "BtnCollectionViewCell.h"

#import "UIView+DDAddition.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,EqualSpaceFlowLayoutDelegate>




@end

@implementation ViewController{


    NSMutableArray *_btnArray;
    UICollectionView *_collectionView;
    UIScrollView *_myScrollView;
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _btnArray = [NSMutableArray arrayWithObjects:@"天使",@"魔鬼",@"沧海一粟",@"上善若水",@"AK47",@"雷明顿",@"那就这样吧",@"都戏",@"驴火",@"烤串",@"胡辣汤",@"羊肉泡馍",@"靠，说的饿了",@"去吃饭",@"下午再写",@"就这么定了",@"走起",nil];

    
    //第一种
    [self setFlowLayout];
    
    //第二种
//    [self addTags];
    

}

- (void)setFlowLayout{

    EqualSpaceFlowLayout *flowLayout=[[EqualSpaceFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical]; //设置横向还是竖向
    flowLayout.delegate = self;

    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, kwidth ,kheight-100) collectionViewLayout:flowLayout];

    
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"BtnCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"BtnCollectionViewCell"];
    
    [self.view addSubview:_collectionView];

}



#pragma mark -- UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _btnArray.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BtnCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BtnCollectionViewCell" forIndexPath:indexPath];
    
//    [cell setBtnCollectionViewCellWithDict:_btnArray[indexPath.row]];
    
        [cell setBtnCollectionViewCellWithStr:_btnArray[indexPath.row]];
    
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat height=30;
    
    NSString *str = _btnArray[indexPath.row] ;
    
    UIFont * font = [UIFont systemFontOfSize:15];
    NSDictionary *att = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGRect sizeStr = [str boundingRectWithSize:CGSizeMake(kwidth -2*10, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:att context:nil];
    
    return  CGSizeMake( sizeStr.size.width <= 30 ? 70:sizeStr.size.width + 40, height);  //设置cell宽高
    
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%@",_btnArray[indexPath.row]);
    
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


#pragma mark --------------------------------------------------------------------这是一条华丽的分割线
#pragma mark --------------------------------------------相比较来说，下面这种可能更简单点

//另一种

- (void)addTags{


    _myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 100, kwidth ,kheight-100)];
    
    _myScrollView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_myScrollView];

    [_myScrollView removeAllSubviews];
    _myScrollView.userInteractionEnabled = YES;
    
    __block int _tagLeft = 20;
    __block int _tagTop = 0;
    
    [_btnArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIView *tagView = [self setTagViewsStr:obj];
        tagView.tag = idx;
        if (_tagLeft + tagView.width + 20 > kwidth) {
            _tagLeft = 20;
            _tagTop += 47;
        }
        tagView.top = _tagTop;
        tagView.left = _tagLeft;
        
        _tagLeft += tagView.width + 15;
        [_myScrollView addSubview:tagView];
        
    }];

}

- (UIView *)setTagViewsStr:(NSString *)str{
    
    UIView *tagView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 27)];
    tagView.backgroundColor = [UIColor blackColor];
    tagView.layer.borderColor = [UIColor whiteColor].CGColor;
    tagView.layer.borderWidth = .5;
    tagView.layer.cornerRadius = 13.5;
    tagView.clipsToBounds = YES;
    tagView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewClick:)];
    [tagView addGestureRecognizer:tap];
    
    //    UIButton *tagBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,tagView.width, tagView.height)];
    //    [tagBtn setBackgroundImage:[LYUtils colorToImageWhitColor:SetColorWith(226, 226, 226)] forState:UIControlStateHighlighted];
    //    [tagView addSubview:tagBtn];
    
    
    UILabel *textLab = [[UILabel alloc]initWithFrame:CGRectMake(0, (27-14)/2, kwidth - 40 -30, 14)];
    [textLab setFont:[UIFont systemFontOfSize:14]];
    textLab.text = str;
    textLab.textColor = [UIColor whiteColor];
    textLab.backgroundColor = [UIColor blackColor];
    [textLab setTextAlignment:NSTextAlignmentCenter];
    textLab.numberOfLines = 1;
    [textLab sizeToFit];
    
    [tagView addSubview:textLab];
    tagView.width = MAX(textLab.width + 30, 70);
    textLab.center = tagView.center;
    
    
    return tagView;
}

- (void)viewClick:(UITapGestureRecognizer *)tap{
    
    NSString *str = _btnArray[tap.view.tag];
    
    NSLog(@"%@",str);

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
