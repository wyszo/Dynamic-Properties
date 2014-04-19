
#import "SampleClass.h"
#import "NSObject+DynamicProperties.h"

@implementation Foo
@end


@interface SampleClass ()

@property (nonatomic, strong) Foo *foo1;
@property (nonatomic, strong) Foo *foo2;

@end


@implementation SampleClass

- (id)init
{
	self = [super init];
	if (self) {
		_foo1 = [Foo new];
		_foo2 = [Foo new];
	}
	return self;
}

- (NSArray *)allFooProperties
{
	return [self allNonemptyPropertiesOfClass:[Foo class]];
}

- (void)printAllFooProperties
{
	NSArray *fooProperties = [self allFooProperties];
	NSLog(@"foo properties of class %@ instance: %@: %@", NSStringFromClass(self.class), self, fooProperties);
}

@end