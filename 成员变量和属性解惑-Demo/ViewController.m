//
//  ViewController.m
//  成员变量和属性解惑-Demo
//
//  Created by 郭彬 on 16/6/27.
//  Copyright © 2016年 walker. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSString *_myString1;
    NSString *myString2;  //仅仅在大括号方式声明成员变量
    NSString *myString3;  //在大括号方式声明成员变量的同时，用@preperty和@synthesize声明
}

@property(nonatomic,copy) NSString *myString1;   //直接只用@property方式的属性声明

@property(nonatomic, copy) NSString *myString3;


@end


@implementation ViewController

@synthesize myString3;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //区别成员变量和属性
    [self myString1Method];
    
    [self myString2Method];
    
    [self myString3Method];
}

#pragma mark -custom method
- (void) myString1Method {
    /**
     * myString1: 直接用@property声明属性
     */
    _myString1 = @"myString1";
    self.myString1 = @"setter方法的myString1";
    NSLog(@"\n_myString1的地址是 %p，\nself.myString1的地址是 %p",_myString1,self.myString1);
    NSLog(@"\n_myString1的值为: %@\n_myString1的值为: %@",_myString1,self.myString1);
    // 结论：
    // _myString 和self.myString的地址是相同的。所以无论对谁修改，self.myString和_myString的值都是一样的。
    // 因此可以说@property下，self.XXX 和 _XXX是完全相同的。
}

- (void) myString2Method {
    /**
     *  myString2: 仅仅在大括号方式声明成员变量
     */
    myString2 = @"myString2";
    self->myString2 = @"用指针self->方式的myString2";
    NSLog(@"\nmyString2的值为%@,\nself->myString2的值为%@",myString2,self->myString2);
    NSLog(@"\nmyString2的地址是 %p，\nself->myString2的地址是 %p",myString2,self->myString2);
    // 结论：
    //仅仅在大括号里面声明，不谢@synthesized是不会生成_XXX 和 self.XXX的
}

- (void) myString3Method {
    /**
     * 在大括号方式声明成员变量的同时，用@preperty和@synthesize声明
     */
    self->myString3 = @"用指针self->方式的myString2";
    self.myString3 = @"self.myString3";
    myString3 = @"myString3";
    NSLog(@"\nself.myString3的值为%@ ,\nself->myString3的值为%@,\nself.myString3的值为%@",self.myString3,self->myString3,myString3);
    
    NSLog(@"\nself.myString3的地址为%p,\nself->myString3的地址为%p,\nself.myString3的地址为%p",self.myString3,self->myString3,myString3);
    // 结论：
    //在大括号方式声明成员变量的同时，用@preperty和@synthesize声明时，
    //有self.myString3,
    //  self->myString3,
    //  myString3
    //  三个,但是没有_myString3，其原因是
    // `成员变量+ @property + @synthesize 成员变量`的形式，编译器就不会帮我们生成`_成员变量`了，因此不会操作`_成员变量`；
}

@end
