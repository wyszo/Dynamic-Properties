
#import "NSObject+DynamicProperties.h"
#import <objc/message.h>


@implementation NSObject (DynamicProperties)

- (NSArray *)allPropertiesOfClass:(Class)aClass
{
	NSLog(@"inside method: %@", NSStringFromSelector(_cmd));
	NSMutableArray *smallObjects = [NSMutableArray new];
	
	// 1. copy property list
	unsigned int numberOfProperties;
	objc_property_t *properties = class_copyPropertyList([self class], &numberOfProperties);
	
	NSLog(@"class has %d properties", numberOfProperties);
	
	// 2. traverse the list and print property names and types
	for (int i=0; i<numberOfProperties; i++) {
		objc_property_t property = properties[i];
		NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
		NSLog(@"property name: %@", propertyName);
		
		id propertyInstance = [self valueForKey:propertyName];
		
		NSLog(@"instance: %@", propertyInstance);
		NSLog(@"property class: %@", NSStringFromClass([propertyInstance class]));
		
		// 3. if class == SmallObject, add to smallObjects array
		if ([propertyInstance isKindOfClass:aClass]) {
			NSLog(@"added %@ to allSmartObjects array", propertyInstance);
			[smallObjects addObject:propertyInstance];
		}
	}
	free(properties);
	
	return [smallObjects copy];
}

@end
