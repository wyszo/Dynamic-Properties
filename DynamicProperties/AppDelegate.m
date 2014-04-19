
#import "AppDelegate.h"
#import "SampleClass.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /** 
     * See DynamicPropertiesTestsSpec file for more usage examples!
     */
    SampleClass *sample = [SampleClass new];
    [sample printAllFooProperties];
    
    return YES;
}

@end
