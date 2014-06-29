//
//  PicturesViewController.m
//  SecurityInfo
//
//  Created by Minami Sophia Aramaki on 2013/10/15.
//  Copyright (c) 2013年 Minami Sophia Aramaki. All rights reserved.
//

#import "PicturesViewController.h"

@interface PicturesViewController ()

@end

@implementation PicturesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    tv.delegate=self;
    tv.dataSource=self;
    
    [tv registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    store = [NSUserDefaults standardUserDefaults];
    rows = (int)[store integerForKey:@"row"];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem setHidesBackButton:NO animated:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (IBAction)pressedCameraButton{
    
    UIActionSheet *sheet = [[UIActionSheet alloc]
                            initWithTitle:@"追加する写真を選択"
                            delegate:self
                            cancelButtonTitle:@"キャンセル"
                            destructiveButtonTitle:nil
                            otherButtonTitles:@"フォトライブラリー", @"カメラ", @"カメラロール", nil];
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    UIImagePickerControllerSourceType sourceType;
    UIImagePickerController *ipc;
    
    switch (buttonIndex) {
        case 0:
            // フォトライブラリーを表示
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エラー" message:@"フォトライブラリーを表示できません" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return;
            }
            
            ipc = [[UIImagePickerController alloc] init];
            [ipc setSourceType:sourceType];
            [ipc setDelegate:self];
            [self presentViewController:ipc animated:YES completion:nil];
            break;
            
        case 1:
            // カメラを起動
            sourceType = UIImagePickerControllerSourceTypeCamera;
            if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エラー" message:@"カメラを起動できません" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return;
            }
            
            ipc = [[UIImagePickerController alloc] init];
            [ipc setSourceType:sourceType];
            [ipc setDelegate:self];
            [self presentViewController:ipc animated:YES completion:nil];
            break;
            
        case 2:
            // カメラロールを表示
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エラー" message:@"カメラロールを表示できません" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return;
            }
            
            ipc = [[UIImagePickerController alloc] init];
            [ipc setSourceType:sourceType];
            [ipc setDelegate:self];
            [self presentViewController:ipc animated:YES completion:nil];
            break;
            
        default:
            break;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    _image = image;
    
    if ([picker respondsToSelector:@selector(presentingViewController)]) {
        [[picker presentingViewController] dismissViewControllerAnimated:YES completion:nil];
        
        /*NSUserDefaults *store = [NSUserDefaults standardUserDefaults];
        NSData* imageData = UIImagePNGRepresentation(_image);
        NSData* myEncodedImageData = [NSKeyedArchiver archivedDataWithRootObject:imageData];
        [store setObject:myEncodedImageData forKey:@"image"];*/
        
        NSData* imageData = UIImageJPEGRepresentation(image, 1.0);
        NSString* imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"/saved_example_image.png"];
        [imageData writeToFile:imagePath atomically:YES];
        
        rows++;
        [store setInteger:rows forKey:@"row"];
    } else {
        [[picker parentViewController] dismissViewControllerAnimated:YES completion:nil];
    }

}

@end
