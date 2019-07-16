//
//  ViewController.m
//  GCD
//
//  Created by 大碗豆 on 17/5/12.
//  Copyright © 2017年 大碗豆. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong)UIImageView *imagView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(100, 20, 100, 30);
    [btn setTitle:@"点我" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    
    UIImageView *imagView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    self.imagView = imagView;
    [self.view addSubview:imagView];
    
    
    
}

- (void)btnAction:(id)btn{
    NSLog(@"~~~~~~按钮被点了");
    [self serialAsync];
}




//主队列 + 异步任务（任务按顺序执行，不开启新线程）
- (void)mainAsync{
    
    NSLog(@"主队列 + 异步任务");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    //在队列里添加任务(异步任务)
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~1~~~~%@",[NSThread currentThread]);
        }
        
    });
    
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~2~~~~%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~3~~~~%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~4~~~~%@",[NSThread currentThread]);
        }
    });
    
}



//主队列 + 同步任务 （会造成卡死（死循环，不可用））
- (void)mainSync{
    
    NSLog(@"主队列 + 同步任务");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    //在队列里添加任务(同步任务)
    dispatch_sync(queue, ^{
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~1~~~~%@",[NSThread currentThread]);
        }
        
    });
    
    dispatch_sync(queue, ^{
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~2~~~~%@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~3~~~~%@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~4~~~~%@",[NSThread currentThread]);
        }
    });
    
    
}




//全局队列 + 异步任务（开启新线程，任务随意执行）
- (void)globalAsync{
    
    NSLog(@"全局队列 + 异步任务");
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //在队列里添加任务(异步任务)
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~1~~~~%@",[NSThread currentThread]);
        }
        
    });
    
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~2~~~~%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~3~~~~%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~4~~~~%@",[NSThread currentThread]);
        }
    });

}



//全局队列 + 同步任务（不开启新线程，任务按顺序执行）
- (void)globalSync{
    
    NSLog(@"全局队列 + 同步任务");
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //在队列里添加任务(同步任务)
    dispatch_sync(queue, ^{
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~1~~~~%@",[NSThread currentThread]);
        }
        
    });
    
    dispatch_sync(queue, ^{
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~2~~~~%@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~3~~~~%@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~4~~~~%@",[NSThread currentThread]);
        }
    });

    
}



//并发队列 + 异步任务（开启薪线程，任务随意执行）
- (void)concurrentAsync{
    
    NSLog(@"并发队列 + 异步任务");
    //创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_CONCURRENT);
    
    //在队列里添加任务(异步任务)
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~1~~~~%@",[NSThread currentThread]);
        }
        
    });
    
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~2~~~~%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~3~~~~%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~4~~~~%@",[NSThread currentThread]);
        }
    });
}



//并发队列 + 同步任务（没有开启新的线程，任务按顺序执行）
- (void)concurrentSync{
    
    NSLog(@"并发队列 + 同步任务");
    
    //创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_CONCURRENT);
    
    //在队列里添加任务(同步任务)
    dispatch_sync(queue, ^{
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~1~~~~%@",[NSThread currentThread]);
        }
        
    });
    
    dispatch_sync(queue, ^{
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~2~~~~%@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~3~~~~%@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~4~~~~%@",[NSThread currentThread]);
        }
    });

    
}


//串行队列 + 同步任务（没有开启新的线程，逐个执行任务）
- (void)serialSync{
    
    NSLog(@"串行队列 + 同步任务");
    
    //创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL);
    
    //在队列里添加任务(同步任务)
    dispatch_sync(queue, ^{
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~1~~~~%@",[NSThread currentThread]);
        }
        
    });
    
    dispatch_sync(queue, ^{
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~2~~~~%@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~3~~~~%@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~4~~~~%@",[NSThread currentThread]);
        }
    });
    
    
}


//串行队列 + 异步任务（开启新的线程,任务逐个执行）
- (void)serialAsync{
    
    NSLog(@"串行队列 + 异步任务");
    //创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL);
    
    //在队列里添加任务(同步任务)
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~1~~~~%@",[NSThread currentThread]);
        }
        
    });
    
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~2~~~~%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~3~~~~%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"~~~~4~~~~%@",[NSThread currentThread]);
        }
    });
}


- (void)threadConmmuniacation{
    //全局异步任务（开启新线程）
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *imag = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://pic.qiantucdn.com/58pic/13/71/52/07j58PICZUe_1024.jpg!/watermark/url/L3dhdGVybWFyay12MS4zLnBuZw==/align/center"]]];
        
        //回归到主线程(异步任务)（先符号）
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"123456789");
            self.imagView.image = imag;
        });
        
        NSLog(@"~~~~~~~~~~");
        
        //同步任务（先数字）
        //        dispatch_sync(dispatch_get_main_queue(), ^{
        //
        //            NSLog(@"123456789");
        //            self.imagView.image = imag;
        //        });
        //
        //        NSLog(@"~~~~~~~~~~");
        //    });
        
        //区别在于先执行（打印数字）还是先执行（打印符号）
        
        
        
        //参数：waitUntilDone  和上边的意思相同
        //    [self performSelectorOnMainThread:<#(nonnull SEL)#> withObject:<#(nullable id)#> waitUntilDone:<#(BOOL)#>];
        
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
