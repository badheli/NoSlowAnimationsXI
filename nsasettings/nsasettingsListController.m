#import <UIKit/UIKit.h>

#import <Preferences/PSViewController.h>
#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PreferencesAppController.h>
#import <Preferences/PSBundleController.h>
#import <Preferences/PSControlTableCell.h>
#import <Preferences/PSDiscreteSlider.h>
#import <Preferences/PSEditableTableCell.h>
#import <Preferences/PSHeaderFooterView.h>
#import <Preferences/PSListItemsController.h>
#import <Preferences/PSRootController.h>
#import <Preferences/PSSliderTableCell.h>
#import <Preferences/PSSwitchTableCell.h>
#import <Preferences/PSSystemPolicyForApp.h>
#import <Preferences/PSTableCell.h> 


#include "nsasettingsListController.h"

@implementation nsasettingsListController

-(NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistname:@"Root" target:self] retain];
	}
	
	return _specifiers;
}

  
-(void) respring:(id)arg1 {
           system ("killall -9 backboardd");
}

-(void) twitter:(id)arg1 {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://twitter.com/patrickk1734"]];
}

-(void) sendEmailTo:(id)arg1 {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:patrickknauf17@gmail.com"]];
}
  
  -(void) github:(id)arg1 {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/Patrickk17/NoSlowAnimationsXI"]];
  }
@end
