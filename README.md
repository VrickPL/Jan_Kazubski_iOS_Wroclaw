<h1 align="center">ShoppingApp</h1>
<h3 align="center">Shopping iOS app to enhance my unit test skills</h3>
Shopping App is an iOS application that not only offers an engaging user experience through its use of SwiftUI and local data management with SwiftData, but also prides itself on having unit tests as the cornerstone of its development process. From the moment the app launches, product data is efficiently loaded from a JSON file on a background thread and image assets are stored locally for quick access. Featuring an intuitive interface that ensures seamless product browsing and effortless cart additions, the application upholds exceptional quality through comprehensive unit testing. Leveraging XCTest and ViewInspector, the unit tests ensure every feature functions reliably and helps maintain a high standard throughout the project. The application is designed with accessibility in mind. System colors are used to assist those with color blindness, and system fonts allow for user adjustments. Navigation via VoiceOver works smoothly.





## Table of Contents
- [Technologies and Libraries](#technologies-and-libraries)
- [General info](#general-info)
- [Browse](#browse)
- [Checkout](#checkout)
- [Bonus tasks](#bonus-tasks)
- [Test coverage](#test-coverage)





## Technologies and Libraries
- **[Swift](https://swift.org)**
- **[SwiftUI](https://developer.apple.com/xcode/swiftui/)**
- **[SwiftData](https://developer.apple.com/documentation/swiftdata)**
- **[XCTest](https://developer.apple.com/documentation/xctest)**
- **[ViewInspector](https://github.com/nalexn/ViewInspector)**







## General info
Upon first launch, the application imports data from `items.json` into **SwiftData**—which manages all of the app's logic—while images are stored in the app's assets for efficient resource management. The data is loaded on a background thread to ensure smooth performance and responsiveness from the beginning. The interface is designed to look great on both large and small screens with seamless support for device rotation, both light and dark modes are carefully optimized. The app supports the two latest versions of iOS — 17 and 18 — and is built using the **MVVM** architecture. Additionally, the app is crafted with **accessibility** in mind, featuring support for **VoiceOver**, *dynamic type*, and *system colors* to enhance usability for all users.




## Browse
The Browse view allows users to browse through all available products. For items with promotions, the most advantageous promotion is automatically selected and displayed accordingly. Products can be added to favorites by tapping the heart icon in the upper left corner.




<p align="center"> 
  <img src="https://github.com/user-attachments/assets/a7f8f8bc-c504-406c-8b08-5718d27b35a4">
  <img src="https://github.com/user-attachments/assets/b594b131-f824-42a1-b0ab-922a6d7161e6">
</p>



## Checkout
The Checkout view allows users to review products added to their basket. Each product offers the same features as in the Browse view. Additionally, if the basket is not empty, a checkout button appears at the bottom, and tapping it triggers an alert displaying the product IDs.



<p align="center"> 
  <img src="https://github.com/user-attachments/assets/61d0018e-0d05-4ad3-9281-5136d0b0f5dd">
  <img src="https://github.com/user-attachments/assets/dc8ab111-ea68-4da5-a503-dc51f22b2eb5">
</p>





## Test coverage
The tests cover 91.9% of the application. A total of 74 tests were written to ensure that the app runs smoothly without unintended issues and functions correctly. XCTest and ViewInspector were used for testing.


<p align="center"> 
  <img src="https://github.com/user-attachments/assets/7a027183-6755-41d8-bb19-8c75bcc0c365">
  <img src="https://github.com/user-attachments/assets/bd436d81-ddd3-4e09-a68a-7c22f5ced6ed">
</p>





