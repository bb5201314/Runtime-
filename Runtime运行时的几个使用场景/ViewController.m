//
//  ViewController.m
//  Runtime运行时的几个使用场景
//
//  Created by 赵小波 on 2017/11/13.
//  Copyright © 2017年 赵小波. All rights reserved.
//

#import "ViewController.h"

#import <objc/runtime.h>
#import <objc/message.h>

#import "Person.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    [self  getPropertyOrMembervariables];
    
//    [self getFunction];
}
//runtime获取对象的属性  成员变量 以及对应的类型
-(void)getPropertyOrMembervariables{
    
    
    /*
     一、获取对象的成员变量列表，通过KVC设置数据/字典转模型框架
     例如JSONModel、YYModel等热门框架都使用运行时获取成员变量列表，然后通过KVC设置字典转模型。
     获取代码如下
     */
    unsigned int numIvars; //成员变量个数
    Ivar *vars = class_copyIvarList(NSClassFromString(@"Person"), &numIvars);
    NSString *key=nil;
    
    for(int i = 0; i < numIvars; i++) {
        
        Ivar thisIvar = vars[i];
        key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];  //获取成员变量的名字
        NSLog(@"variable name :%@", key);
        key = [NSString stringWithUTF8String:ivar_getTypeEncoding(thisIvar)]; //获取成员变量的数据类型
        NSLog(@"variable type :%@", key);
    }
    free(vars);
    
}
//获取成员函数
-(void)getFunction{
    
    unsigned int numIvars; //成员函数个数

    Method *meth = class_copyMethodList(NSClassFromString(@"Person"), &numIvars);
    //Method *meth = class_copyMethodList([UIView class], &numIvars);
    
    for(int i = 0; i < numIvars; i++) {
        Method thisIvar = meth[i];
        
        SEL sel = method_getName(thisIvar);
        const char *name = sel_getName(sel);
        
        NSLog(@"zp method :%s", name);
        
        
        
    }
    free(meth);

}
//发送消息
-(void)addPropertyActivity{
    
    Person *person1=[[Person  alloc]init];
    
//    [Person  logNsstring];
    
    //调用对象本质 让对象发送消息
//    objc_msgSend(self,@selector(testRuntime));

    void (*action)(id, SEL, NSString*) = (void (*)(id, SEL, NSString*))objc_msgSend;
    action(person1, @selector(logNsstring),nil);
}
- (void)testRuntime
{
    NSLog(@"-----timeruntiem---");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
