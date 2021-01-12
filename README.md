# Nike Technical Assessment

This is an iOS Technical Assessment for a Senior iOS Developer position at Nike.

## Author

Nate Potter
503-449-5009
nathanielpotter@gmail.com

## Dependencies

This project requires Xcode 12 or higher with a deployment target of iOS 14.

## Design Choices

### iOS 14 UICollectionView

I am acquainted with previous UICollectionView APIs however I decided to try the new `UICollectionViewDiffableDataSource` and `UICollectionView.CellRegistration` APIs for this project.

### Combine

I am comfortable using the Result<Value, Error> return type in completion blocks and try/catch blocks, however for this assignment I decided to try the Combine functional reactive framework.

### Dependency Injection

I used Dependency Injection to decouple the http client from the viewcontrollers. I decided to use different classes for the RSS feed client and the IMageLoader client so that I could use a seperate NSURLSession for each. I cached the image downloads in a NSCache object in case the cache policy from the server for the images isn't correct.

### Single Responsibility

I seperated the data retreival and the view presenation logic into an Interactor and Presenter class respectivly.

### Tests

Unit and UI tests are run as seperate Test Plans under Product > Test Plan

### Unit Tests

I added unit tests to check that the values required for the assessent are present in the viewModel.

### UI Tests

I added a UI integration test to determine whether the AlbumDetailView is presented when tapping a collection view cell.

### Error Handling

Network request and serialization errors are passed to the Combine subscriber in the Interactor where an error is then passed to the presenter to be formatted for the view.

