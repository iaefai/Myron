//
//  NSApp-Menus.mm
//  Myron
//
//  Created by Jeffrey Drake on 11-12-17.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#include <iostream>
#include <Cocoa/Cocoa.h>

#include "NSApp.h"
#include "NSApp-Menus.h"

@implementation AppDelegate (Menus)

-(void) populateApplicationMenu:(NSMenu *)aMenu
{
	NSString * applicationName = [self applicationName];
	NSMenuItem * menuItem;
	
	menuItem = [aMenu addItemWithTitle:[NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"About", nil), applicationName]
								action:@selector(orderFrontStandardAboutPanel:)
						 keyEquivalent:@""];
	[menuItem setTarget:NSApp];
	
	[aMenu addItem:[NSMenuItem separatorItem]];
	
    /*	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Preferences...", nil)
     action:NULL
     keyEquivalent:@","];
     */	
	[aMenu addItem:[NSMenuItem separatorItem]];
	
    /*	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Services", nil)
     action:NULL
     keyEquivalent:@""];
     NSMenu * servicesMenu = [[NSMenu alloc] initWithTitle:@"Services"];
     [aMenu setSubmenu:servicesMenu forItem:menuItem];
     [NSApp setServicesMenu:servicesMenu];
     
     [aMenu addItem:[NSMenuItem separatorItem]];
     */	
	menuItem = [aMenu addItemWithTitle:[NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"Hide", nil), applicationName]
								action:@selector(hide:)
						 keyEquivalent:@"h"];
	[menuItem setTarget:NSApp];
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Hide Others", nil)
								action:@selector(hideOtherApplications:)
						 keyEquivalent:@"h"];
	[menuItem setKeyEquivalentModifierMask:NSCommandKeyMask | NSAlternateKeyMask];
	[menuItem setTarget:NSApp];
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Show All", nil)
								action:@selector(unhideAllApplications:)
						 keyEquivalent:@""];
	[menuItem setTarget:NSApp];
	
	[aMenu addItem:[NSMenuItem separatorItem]];
	
	menuItem = [aMenu addItemWithTitle:[NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"Quit", nil), applicationName]
								action:@selector(terminate:)
						 keyEquivalent:@"q"];
	[menuItem setTarget:NSApp];
}

-(void) populateEditMenu:(NSMenu *)aMenu
{
	NSMenuItem * menuItem;
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Undo", nil)
								action:@selector(undo:)
						 keyEquivalent:@"z"];
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Redo", nil)
								action:@selector(redo:)
						 keyEquivalent:@"Z"];
	
	[aMenu addItem:[NSMenuItem separatorItem]];
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Cut", nil)
								action:@selector(cut:)
						 keyEquivalent:@"x"];
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Copy", nil)
								action:@selector(copy:)
						 keyEquivalent:@"c"];
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Paste", nil)
								action:@selector(paste:)
						 keyEquivalent:@"v"];
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Paste and Match Style", nil)
								action:@selector(pasteAsPlainText:)
						 keyEquivalent:@"V"];
	[menuItem setKeyEquivalentModifierMask:NSCommandKeyMask | NSAlternateKeyMask];
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Delete", nil)
								action:@selector(delete:)
						 keyEquivalent:@""];
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Select All", nil)
								action:@selector(selectAll:)
						 keyEquivalent:@"a"];
	
	[aMenu addItem:[NSMenuItem separatorItem]];
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Find", nil)
								action:NULL
						 keyEquivalent:@""];
	NSMenu * findMenu = [[NSMenu alloc] initWithTitle:@"Find"];
	[self populateFindMenu:findMenu];
	[aMenu setSubmenu:findMenu forItem:menuItem];
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Spelling", nil)
								action:NULL
						 keyEquivalent:@""];
	NSMenu * spellingMenu = [[NSMenu alloc] initWithTitle:@"Spelling"];
	[self populateSpellingMenu:spellingMenu];
	[aMenu setSubmenu:spellingMenu forItem:menuItem];
}

-(void) populateFileMenu:(NSMenu *)aMenu
{
	NSMenuItem * menuItem;
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"New", nil)
								action:NULL
						 keyEquivalent:@"n"];
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Open...", nil)
								action:NULL
						 keyEquivalent:@"o"];
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Open Recent", nil)
								action:NULL
						 keyEquivalent:@""];
	NSMenu * openRecentMenu = [[NSMenu alloc] initWithTitle:@"Open Recent"];
	[openRecentMenu performSelector:@selector(_setMenuName:) withObject:@"NSRecentDocumentsMenu"];
	[aMenu setSubmenu:openRecentMenu forItem:menuItem];
	
	menuItem = [openRecentMenu addItemWithTitle:NSLocalizedString(@"Clear Menu", nil)
										 action:@selector(clearRecentDocuments:)
								  keyEquivalent:@""];
	
	[aMenu addItem:[NSMenuItem separatorItem]];
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Close", nil)
								action:@selector(performClose:)
						 keyEquivalent:@"w"];
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Save", nil)
								action:NULL
						 keyEquivalent:@"s"];
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Save As...", nil)
								action:NULL
						 keyEquivalent:@"S"];
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Revert", nil)
								action:NULL
						 keyEquivalent:@""];
	
	[aMenu addItem:[NSMenuItem separatorItem]];
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Page Setup...", nil)
								action:@selector(runPageLayout:)
						 keyEquivalent:@"P"];
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Print...", nil)
								action:@selector(print:)
						 keyEquivalent:@"p"];
}

-(void) populateFindMenu:(NSMenu *)aMenu
{
	NSMenuItem * menuItem;
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Find...", nil)
								action:@selector(performFindPanelAction:)
						 keyEquivalent:@"f"];
	[menuItem setTag:NSFindPanelActionShowFindPanel];
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Find Next", nil)
								action:@selector(performFindPanelAction:)
						 keyEquivalent:@"g"];
	[menuItem setTag:NSFindPanelActionNext];
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Find Previous", nil)
								action:@selector(performFindPanelAction:)
						 keyEquivalent:@"G"];
	[menuItem setTag:NSFindPanelActionPrevious];
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Use Selection for Find", nil)
								action:@selector(performFindPanelAction:)
						 keyEquivalent:@"e"];
	[menuItem setTag:NSFindPanelActionSetFindString];
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Jump to Selection", nil)
								action:@selector(centerSelectionInVisibleArea:)
						 keyEquivalent:@"j"];
}

-(void) populateHelpMenu:(NSMenu *)aMenu
{
	NSMenuItem * menuItem;
	
	menuItem = [aMenu addItemWithTitle:[NSString stringWithFormat:@"%@ %@", [self applicationName], NSLocalizedString(@"Help", nil)]
								action:@selector(showHelp:)
						 keyEquivalent:@"?"];
	[menuItem setTarget:NSApp];
}

-(void) populateSpellingMenu:(NSMenu *)aMenu
{
	NSMenuItem * menuItem;
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Spelling...", nil)
								action:@selector(showGuessPanel:)
						 keyEquivalent:@":"];
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Check Spelling", nil)
								action:@selector(checkSpelling:)
						 keyEquivalent:@";"];
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Check Spelling as You Type", nil)
								action:@selector(toggleContinuousSpellChecking:)
						 keyEquivalent:@""];
}

-(void) populateViewMenu:(NSMenu *)aMenu
{
	// TODO
}

-(void) populateWindowMenu:(NSMenu *)aMenu
{
	NSMenuItem * menuItem;
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Minimize", nil)
								action:@selector(performMinimize:)
						 keyEquivalent:@"m"];
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Zoom", nil)
								action:@selector(performZoom:)
						 keyEquivalent:@""];
	
	[aMenu addItem:[NSMenuItem separatorItem]];
	
	menuItem = [aMenu addItemWithTitle:NSLocalizedString(@"Bring All to Front", nil)
								action:@selector(arrangeInFront:)
						 keyEquivalent:@""];
}


@end