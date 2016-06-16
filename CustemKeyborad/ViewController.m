//
//  ViewController.m
//  CustemKeyborad
//
//  Created by Mac on 16/6/9.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "XLToolView.h"
#import "XLFunctionView.h"
#import "ImageModelClass.h"
#import "HistoryImage+CoreDataProperties.h"

@interface ViewController ()
//自定义组件
@property (nonatomic, strong) XLToolView *toolView;

@property (nonatomic, strong) XLFunctionView *functionView;

//@property (nonatomic, strong) MoreView *moreView;

//系统组件
@property (strong, nonatomic) IBOutlet UITextView *myTextView;

@property (strong, nonatomic) NSDictionary *keyBoardDic;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) NSString *sendString;

//数据model
@property (strong, nonatomic) ImageModelClass  *imageMode;

@property (strong, nonatomic)HistoryImage *tempImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //从sqlite中读取数据
    self.imageMode = [[ImageModelClass alloc] init];
    
    
    //实例化FunctionView
    self.functionView = [[XLFunctionView alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
    self.functionView.backgroundColor = [UIColor blackColor];
    
    //设置资源加载的文件名
    self.functionView.plistFileName = @"emoticons";
    
    __weak __block ViewController *copy_self = self;
    //获取图片并显示
    [self.functionView setFunctionBlock:^(UIImage *image, NSString *imageText)
     {
         NSString *str = [NSString stringWithFormat:@"%@%@",copy_self.myTextView.text, imageText];
         
         copy_self.myTextView.text = str;
         copy_self.imageView.image = image;
         
         //把使用过的图片存入sqlite
         NSData *imageData = UIImagePNGRepresentation(image);
         [copy_self.imageMode save:imageData ImageText:imageText];
     }];
    
    
    //实例化MoreView
//    self.moreView = [[MoreView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//    self.moreView.backgroundColor = [UIColor blackColor];
//    [self.moreView setMoreBlock:^(NSInteger index) {
//        NSLog(@"MoreIndex = %d",index);
//    }];
    
    
    
    //进行ToolView的实例化
    self.toolView = [[XLToolView alloc] initWithFrame:CGRectZero];
    self.toolView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.toolView];
    
    //给ToolView添加约束
    //开启自动布局
    self.toolView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //水平约束
    NSArray *toolHConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_toolView]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_toolView)];
    [self.view addConstraints:toolHConstraint];
    
    //垂直约束
    NSArray *toolVConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_toolView(44)]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_toolView)];
    [self.view addConstraints:toolVConstraint];
    
    
    
    
    //回调toolView中的方法
    [self.toolView setToolIndex:^(NSInteger index)
     {
         NSLog(@"%ld", (long)index);
         
         switch (index) {
             case 1:
                 [copy_self changeKeyboardToFunction];
                 break;
                 
             case 2:
//                 [copy_self changeKeyboardToMore];
                 break;
                 
             default:
                 break;
         }
         
     }];
    
    
    
    //当键盘出来的时候通过通知来获取键盘的信息
    //注册为键盘的监听着
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
    //给键盘添加dan
    //TextView的键盘定制回收按钮
    UIToolbar * toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    
    UIBarButtonItem * item1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(tapDone:)];
    UIBarButtonItem * item2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem * item3 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolBar.items = @[item2,item1,item3];
    
    self.myTextView.inputAccessoryView =toolBar;
}
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    //纵屏
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        CGRect frame = self.functionView.frame;
        frame.size.height = 216;
        self.functionView.frame = frame;
//        self.moreView.frame = frame;
        
    }
    //横屏
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        CGRect frame = self.functionView.frame;
        frame.size.height = 150;
        self.functionView.frame = frame;
//        self.moreView.frame = frame;
    }
}
//当键盘出来的时候改变toolView的位置（接到键盘出来的通知要做的方法）
-(void) keyNotification : (NSNotification *) notification
{
    NSLog(@"%@", notification.userInfo);
    
    self.keyBoardDic = notification.userInfo;
    //获取键盘移动后的坐标点的坐标点
    CGRect rect = [self.keyBoardDic[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    //把键盘的坐标系改成当前我们window的坐标系
    CGRect r1 = [self.view convertRect:rect fromView:self.view.window];
    
    [UIView animateWithDuration:[self.keyBoardDic[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
        //动画曲线
        [UIView setAnimationCurve:[self.keyBoardDic[UIKeyboardAnimationCurveUserInfoKey] doubleValue]];
        
        CGRect frame = self.toolView.frame;
        
        frame.origin.y = r1.origin.y - frame.size.height;
        
        //根据键盘的高度来改变toolView的高度
        self.toolView.frame = frame;
    }];
}
//切换键盘的方法
-(void) changeKeyboardToFunction
{
    if ([self.myTextView.inputView isEqual:self.functionView])
    {
        self.myTextView.inputView = nil;
        [self.myTextView reloadInputViews];
    }
    else
    {
        self.myTextView.inputView = self.functionView;
        [self.myTextView reloadInputViews];
    }
    
    if (![self.myTextView isFirstResponder])
    {
        [self.myTextView becomeFirstResponder];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
