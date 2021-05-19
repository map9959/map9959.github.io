---
layout: page
---

# Project 5: Multiple Processes

__Due date: Saturday, May 15, 2021 at 11:00 pm.__
**There will be no accepting of a submission beyond this time.** Grading needs to begin the next day.

---
**You may discuss any of the assignments with your classmates and instructors (or anyone else) but
all work for all assignments must be entirely your own.Any sharing or copying of assignments will be considered cheating (this includes posting of partial or complete solutions on
Piazza, GitHub public repositories or any other public forum). If you get significant help
from anyone, you should acknowledge it in your submission (and your grade will be proportional to the part that you completed on your own).
You are responsible for every line in your program: you need to know what it does and why.**

## Problem 1

Write a C Program that writes all the  numbers from 1 to 100,000 that are both prime and the digits add up to 11. For example 47,911 are 2 such numbers. After finding a number, you must immediately write it to the output file. Open the file, write the next value, and close the file.  Measure how much elapsed time it takes to do this processing. Yes, it is inefficient, but we are trying to force some I/O usage.
Next have the program fork and create 10 separate processes. Each process would find search a range of 1 to 100,000 for these prime and sum 11 numbers. One process searches 1 to 10000, another 10001 to 20000 etc. . Each process performs the exact same tasks , in the same way, as the first part of the problem, but write the output to 10 separate files, one for each process. Next read the ten files to make one file with all the number.. Measure the elapsed time it takes for all 10 processes to complete, and to create the output file. Be careful using C timer functions – do not count CPU cycles but instead elapsed time.

The goal is to show that by breaking up the task across processes (that do I/O), the total elapsed needed will be shorter.


## Problem 2

Enhance the program shown in class to be a quiz program. Have the parent program pick numbers between in some range, and possibly an operator (+,-,*) and see if the person can answer correctly within 5 seconds If a correct answer is provided within 5 seconds, show the next question and set the timer back to 0. If not, the Timer process should send a signal to the parent class, indicating that time is up. When time is up, add 1 to the count the number of missed questions and go to the next question. 
You are allowed to create a Timer process for each question if necessary.
The parent program should prompt the user at the beginning of the program for the number of questions in the quiz. At the end of the questions, the program should print correct answers, incorrect answer (wrong answers within time frame), and missed questions (no correct answer within timeframe).
