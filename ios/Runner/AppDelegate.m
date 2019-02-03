#include "AppDelegate.h"
#ifdef DEBUG
#import "ZBFpsTool.h"
#endif

#include "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GeneratedPluginRegistrant registerWithRegistry:self];
    
#ifdef DEBUG
    __block UILabel *fpsLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, [UIApplication sharedApplication].statusBarFrame.size.height, 50, 15)];
    fpsLabel.font = [UIFont systemFontOfSize:12];
    fpsLabel.textColor = [UIColor redColor];
    fpsLabel.layer.masksToBounds = YES;
    fpsLabel.layer.borderColor = UIColor.redColor.CGColor;
    fpsLabel.layer.borderWidth = 0.5;
    fpsLabel.textAlignment = NSTextAlignmentCenter;
    fpsLabel.layer.cornerRadius = 4;
    [[ZBFpsTool instance] openWithHandler:^(NSInteger fpsValue) {
        fpsLabel.text = [NSString stringWithFormat:@"fps-%d",(int)round(fpsValue)];
        if (fpsLabel.superview) {
            [fpsLabel.superview bringSubviewToFront:fpsLabel];
        }
    }];
    [self.window addSubview:fpsLabel];
#endif
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
