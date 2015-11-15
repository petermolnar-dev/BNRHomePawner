//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by Peter Molnar on 08/04/2015.
//  Copyright (c) 2015 Peter Molnar. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"
#import "BNRDatePikerViewController.h"
#import "BNRIMageStore.h"
#import "CrossHairView.h"

@interface BNRDetailViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
- (IBAction)backGroundTapped:(id)sender;

@end

@implementation BNRDetailViewController
- (IBAction)takePicture:(id)sender {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    
  
    
    // If the device has a camera, take a picture,
    // otherwise pick from photos
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.allowsEditing = YES;
        CrossHairView *crossHair = [[CrossHairView alloc] init];
        [crossHair setFrame:CGRectMake(0, 0, [imagePicker view].bounds.size.width, [imagePicker view].bounds.size.height- 52)];
        [imagePicker setCameraOverlayView:crossHair];

    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate = self;
    
    // Place the image picker view on the screen (modally)
    [self presentViewController:imagePicker animated:YES completion:nil];
}


- (IBAction)deletePicture:(id)sender {
    NSString *imageKey = self.item.itemKey;
    
    [[BNRIMageStore sharedStore] deleteImageForKey:imageKey];
    
    self.imageView.image = nil;
    
}


//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo {
    // GEt picked image from onfp dictionary
//    UIImage *image = info[UIImagePickerControllerOriginalImage];

    //Store the image in BNRIImageStore for this key
    [[BNRIMageStore sharedStore] setImage:image forKey:self.item.itemKey];
    
    // Put it onto th screen
    self.imageView.image = image;
    
    // Take the picture off the screen
    // you must call this to dismiss the method
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    NSString *imageKey = self.item.itemKey;
    
    // Het the image or that key
    UIImage *imageToDisplay = [[BNRIMageStore sharedStore] imageForKey:imageKey];
    
    // set the view's image
    self.imageView.image = imageToDisplay;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    BNRItem *item = self.item;
    
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    
    //You need NSDateFormatter the will turn date into a simple string
    static NSDateFormatter *dateFormatter= nil;
    
    if (!dateFormatter ){
        dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    //Use filtered NSDat object ti set datelabel content
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
    
//    UITapGestureRecognizer *tapBackground = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backGroundTap:)];
//    [self.view addGestureRecognizer:tapBackground];
   
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    //Clear First responder
    [self.view endEditing:YES];
    
    //"Save" changes to the item
    BNRItem *item = self.item;
    
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text intValue];
}

-(void)setItem:(BNRItem *)item {
    _item = item;
    self.navigationItem.title = _item.itemName;
     self.navigationItem.leftBarButtonItem.title = @"Back";
}

//-(IBAction)backGroundTap:(id)sender {
//    [self.valueField resignFirstResponder];
//}

-(IBAction)toggleCreationDateView:(id)sender {
    
    BNRDatePikerViewController *pickerViewController = [[BNRDatePikerViewController alloc] init];
    pickerViewController.item  = self.item;
     [self.navigationController pushViewController:pickerViewController animated:YES];
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
// Dimissing the keyboard
- (IBAction)backGroundTapped:(id)sender {
    [self.view endEditing:YES];
    
}
@end
