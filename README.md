## Dependencies

This project requires Xcode 12 or higher with a deployment target of iOS 14.

## Design Choices

### iOS 14 UICollectionView

I am acquainted with previous UICollectionView APIs however I decided to try the new `UICollectionViewDiffableDataSource` and `UICollectionView.CellRegistration` APIs for this project.

### Combine

I am comfortable using the Result<Value, Error> return type in completion blocks and try/catch blocks, however for this assignment I decided to try the Combine functional reactive framework.

### Dependency Injection

I used Dependency Injection to decouple the HTTP client and library classes from the viewcontrollers. I decided to use different classes for the RSS feed requests and the ImageLoader requests so that I could use a seperate NSURLSession for each if needed. I cached the image downloads in a NSCache object in case the cache policy from the server is not present.

### Single Responsibility

I separated the data fetching and the view presentation logic into an Interactor and Presenter class respectively.

### Tests

Unit and UI tests are run as seperate Test Plans under Product > Test Plan

### Unit Tests

I added unit tests to check that the values required for the assessment are present in the viewModel.

### UI Tests

I added a UI integration test to determine whether the AlbumDetailView is displayed when tapping a collection view cell.

### Error Handling

Network request and serialization errors are passed to the Combine subscriber. The Interactor class receives these events and passes them to the presenter to be formatted for the view.

### TLS Certificate Error iOS 13+

Due to the TLS server certificate change from Apple there is an `unable to determine interface type without an established connection` error when downloading images that cannot be fixed client side.

### Xcode 12 Simulator Bug

There is a bug in Xcode 12 simulator that consistently returns this error `nw_protocol_get_quic_image_block_invoke dlopen libquic failed` which is not present when run on the actual device.



