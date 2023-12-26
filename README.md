<p align="center">
    <img src="Media/launch.png" alt="drawing" width="400"/>
</p>

# DotaTactix - AI-powered build & strategy generator

<p align="center">
    <img src="Media/Screenshots.png" alt="drawing" width="700"/>
</p>

DotaTactix is your ultimate companion app crafted for Dota 2 enthusiasts, offering a wealth of features to elevate your gameplay to new heights.
Leverage the power of OpenAI to generate personalized item builds and strategic approaches tailored to your playstyle. Craft winning strategies that suit your preferences and stay steps ahead of your opponents.
Stay up-to-date with the dynamic world of Dota 2. Dotatactix delivers real-time news straight from the Dota universe, including the freshest patch updates. Never miss a beat, and adapt your tactics swiftly with the latest changes.
Dive deep into the Dota 2 realm with an extensive glossary featuring detailed information about heroes and items.

## Video Demo

<p align="center">
    <a href="https://youtu.be/11N7anM4KtQ">
      <img src="https://img.youtube.com/vi/11N7anM4KtQ/maxresdefault.jpg" alt="Watch the video" style="width: 400px;">
    </a>
</p>

## Environment Variables

To run this project, you will need to create `OpenAI-Info.plist` wtih the variable below and add it to `DotaTactix` folder

| Key             | Value                                                      | 
| --------------- | -----------------------------------------------------------------| 
| `API_KEY`       | API Key generated from OpenAI | 

## Color Reference

| Color             | Light Mode                                                       |
| ----------------- | -----------------------------------------------------------------|
| Accent Color     | ![#9E1500](https://via.placeholder.com/10/9E1500?text=+) #9E1500 |
| Dark Gray     | ![#181C23](https://via.placeholder.com/10/181C23?text=+) #181C23 |
| Light Gray    | ![#757D89](https://via.placeholder.com/10/757D89?text=+) #757D89 |


## Features

- **XCode 15 & iOS17**
- **MVVM**
    - Implemented MVVM architecture with API work done in a Service
- **Dark/Light Mode**
    - Saved to UserDefaults
- **Portrait/Landscape Modes**
    - Modified views based on SizeClass to make app look good in both orientations
- **Custom App Icon**
- **Custom Display Name**
- **Swift Modern Concurrency** - async/await, URLSession
- **Error Handling**
    - Throwing custom errors during API call and displaying them in UI
- **Animations**
    - Done with `withAnimation`
- **Animated Splash Screen**
- **Onboarding Screen**
    - Consists of 3 screens created with TabView
    - Only appears when app is launched for the first time
- **TabView** - Home, Search, Cart, Profile
    - Custom animated TabView with 4 tabs
- **List of Products** - ScrollView, Grids, For loops
    - Used V/HGrids, V/HLists and Foreach loops to display data
- **Sort List by Brands**
    - Brands displayed on Home Screen are hard coded due to the API that does not offer brand icons
    - Clicking on a brand makes an API call to display brand products
    - Clicking one more time deselects the brand and fetches random brands products
- **Product Details** - Images, Price, Sizes, Description
    - User can select quantity and size of the product
    - Minimum quantity is 1 and Max is 99
    - Product can only be added to the cart when size is selected
    - After adding a product user can navigate to cart or continue shopping
    - Note: Product description has HTML tags as it is returned from the API as a String
- **Search Brands**
    - User can search by brand name and tapping on a brand name will show products from that brand
- **Adding Products to Cart**
    - Cart items are saved between app sessions
    - If user adds the same product but with different size, cart will display both products
- **Cart Total Amount** - Subtotal, Tax, Shipping, Promo Code
    - Promo Code is hard coded - `TRENDIFY10`, applies 10% off of Subtotal
- **Favorite Products**
    - User can mark products as Favorites and they will be saved between app sessions
- **Profile Picutre**
    - User can set Profile Picture from gallery and it will be save between app sessions
- **Saving to UserDefaults** - Favorites, Cart Items, Dark/Light Mode, Profile Picture

## API Reference

- https://stratz.com/
- https://www.opendota.com/
- https://steamcommunity.com/dev
- https://platform.openai.com/
