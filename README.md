# Unsplash

![ Alt text](unsplash.gif) / ! [](unsplash.gif)

Unsplash is a image heavy project, where we have majorly 3 modules:- 
## 1. Home Screen
 It shows list of images for a particular collection using unsplash APIs with a search feature.
## 2. Search screen 
This screen has a search functionality where we are showing a list of images in 2x2 grid form according to the  search query entered by the user.
## 3. Advanced filter screen 
This screen has different search and sorting options to narrow down the search. We are storing applied filters in UserDefaults. 


## GridImagesViewController 
This is a base having 2x2 gird layout collection view. Both Home and Search screen are inherited from this base class.

## ImageDownloadManager 
This is image downloader class using URLSession, having methods to increase or decrease priority of the download task (image download task) in order to optimize the whole image download process. This manager class first checks the image in the cache and returns it from there if it is present otherwise it downloads the image and caches it. 

### func increasePriorityFor(urlString: String)  
To increase the priority of image download task

### func decreasePriorityFor(urlString: String)  
To decrease the priority of image download task


Architecture - VIPER
language - Swift
Networking - URLSession
Persistance - UserDefaults & Cache 
