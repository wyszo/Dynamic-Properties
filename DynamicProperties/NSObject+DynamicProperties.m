
#import "NSObject+DynamicProperties.h"
#import <objc/message.h>


@implementation NSObject (DynamicProperties)

- (NSArray *)allNonemptyPropertiesOfClass:(Class)aClass
{
	NSMutableArray *matchingProperties = [NSMutableArray new];
	
	// copy property list
	unsigned int numberOfProperties;
	objc_property_t *properties = class_copyPropertyList([self class], &numberOfProperties);
	
	// traverse the list and print property names and types
	for (int i=0; i<numberOfProperties; i++) {
		objc_property_t property = properties[i];
        
		NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
		id propertyInstance = [self valueForKey:propertyName];
		
        // if class matches, add to results array
		if ([propertyInstance isKindOfClass:aClass]) {
			[matchingProperties addObject:propertyInstance];
		}
	}
	free(properties);
	
    if (matchingProperties.count == 0) {
        matchingProperties = nil;
    }
    return [matchingProperties copy];
}

@end
