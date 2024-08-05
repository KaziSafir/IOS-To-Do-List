# Introduction
iOS To-Do List App an app that allows users to add, remove, and modify items on a list. The app consists of two main pages: the first page displays the list of items, where users can add and remove items, and the second page allows users to modify and create items with a name, due date, and notes.

# Design
The app features a simple design with two main pages:

My To-Dos Page: Includes an edit button on the top left, an add button on the top right, a title ("My To-Dos"), and a list of to-do items below the title.

New To-Dos Page: Appears as a pop-up screen when the add button is tapped. This page includes a cancel button on the top left, a title ("New To-Dos") in the middle, a save button on the top right, and a table for entering the name, due date, and notes for a new to-do item.

# Issues
One challenge was getting the save button on the "New To-Dos" page to become clickable only when a title for the new item is entered. The button remained grayed out until I identified a missing line in the updateSaveButtonState function by retracing my steps through the book.

# Discussions
This project was straightforward and enjoyable. The provided code worked with the current version of Xcode (version 15), despite the book being based on Xcode version 13. However, in another project, the Restaurant App, some code was outdated and did not work.

# Tools
I used the book "Develop in Swift Data Collections" by Apple Education, my MacBook, and Xcode to recreate the To-Do List app.

# Technical Specifications
The app was developed using Xcode version 15.3 on a MacBook Air with the M1 chip, running macOS Sonoma 14.4.1.

# Conclusion
The iOS To-Do List app was a quick project that helped me better understand how UIViewController works, demonstrating how it can manage lists by adding or removing items in a table or collecting information from users.
