//
//  CardDescriptions.swift
//  ScrewApp
//
//  Created by Yvan on 11/12/2018.
//  Copyright © 2018 The Casatiellos. All rights reserved.
//

import Foundation
import UIKit

public var cardIconData : [UIImage] = [
    UIImage(named: "cardIcon1")!,
    UIImage(named: "cardIcon2")!,
    UIImage(named: "cardIcon3")!,
    UIImage(named: "cardIcon4")!,
    UIImage(named: "cardIcon5")!,
    UIImage(named: "cardIcon6")!,
    UIImage(named: "cardIcon7")!,
    UIImage(named: "cardIcon8")!,
    UIImage(named: "cardIcon9")!,
    UIImage(named: "cardIcon10")!,
    UIImage(named: "cardIcon11")!,
    UIImage(named: "cardIcon12")!,
    UIImage(named: "cardIcon13")!,
]

public var cardPointsOfPainData : [Int] = [80, 80, 93, 73, 86, 56, 66, 76, 43, 5, 66, 46, 76]

public var cardDescriptionData : [String] = [
    "You have an exam and study a lot and when the exam starts you notice you studied the wrong book pages",
    "Your parents trusted you but you feel like you have let them down ",
    "You graduated at the university just to realise you didn’t like what you were doing",
    "You and your friend have the same job meeting, you don’t get the job but he does",
    "You talk shit about someone with a friend but when you turn around you notice that person near to you",
    "You sent an important job email with your own name misspelled",
    "You’re on the toilet and you’re typing with your phone, it suddenly falls down into the toilet",
    "You have been working hard for years into taking a degree and get the job of your dreams and but you still cannot get it",
    "You are waiting for a friend to pick you up, a car stops close to you and you get in but it’s not your friend’s car",
    "You arrive in the airplane, and ask a whole row to stand up because someone is in your seat, just to realize afterwards that your seat was not there",
    "You yell “STOP THE TRAIN, I FORGOT MY BACKPACK INSIDE”, and then, after causing a commotion, you realize it was on your back the whole time",
    "You make a really big and juicy steak of meat to impress your date, but you don’t know he/she is vegan",
    "You have been working for years in the same company but you never got a promotion"
]

let card1 = CardModel (
    cardIcon: UIImage(named: "cardIcon1")!,
    pointsOfPain: 80,
    cardDescription: "You have an exam and study a lot and when the exam starts you notice you studied the wrong book pages"
)


let card2 = CardModel (
    cardIcon: UIImage(named: "cardIcon2")!,
    pointsOfPain: 80,
    cardDescription: "Your parents trusted you but you feel like you have let them down "
)


let card3 = CardModel (
    cardIcon: UIImage(named: "cardIcon3")!,
    pointsOfPain: 93,
    cardDescription: "You graduated at the university just to realise you didn’t like what you were doing"
)


 let card4 = CardModel (
    cardIcon: UIImage(named: "cardIcon4")!,
    pointsOfPain: 73,
    cardDescription: "You and your friend have the same job meeting, you don’t get the job but he does"
)


let card5 = CardModel (
    cardIcon: UIImage(named: "cardIcon5")!,
    pointsOfPain: 86,
    cardDescription: "You talk shit about someone with a friend but when you turn around you notice that person near to you"
)


let card6 = CardModel (
    cardIcon: UIImage(named: "cardIcon6")!,
    pointsOfPain: 56,
    cardDescription: "You sent an important job email with your own name misspelled"
)


let card7 = CardModel (
    cardIcon: UIImage(named: "cardIcon7")!,
    pointsOfPain: 66,
    cardDescription: "You’re on the toilet and you’re typing with your phone, it suddenly falls down into the toilet"
)


let card8 = CardModel (
    cardIcon: UIImage(named: "cardIcon8")!,
    pointsOfPain: 76,
    cardDescription: "You have been working hard for years into taking a degree and get the job of your dreams and but you still cannot get it"
)


let card9 = CardModel (
    cardIcon: UIImage(named: "cardIcon9")!,
    pointsOfPain: 43,
    cardDescription: "You are waiting for a friend to pick you up, a car stops close to you and you get in but it’s not your friend’s car"
)


let card10 = CardModel (
    cardIcon: UIImage(named: "cardIcon10")!,
    pointsOfPain: 5,
    cardDescription: "You arrive in the airplane, and ask a whole row to stand up because someone is in your seat, just to realize afterwards that your seat was not there"
)


let card11 = CardModel (
    cardIcon: UIImage(named: "cardIcon11")!,
    pointsOfPain: 66,
    cardDescription: "You yell “STOP THE TRAIN, I FORGOT MY BACKPACK INSIDE”, and then, after causing a commotion, you realize it was on your back the whole time"
)


let card12 = CardModel (
    cardIcon: UIImage(named: "cardIcon12")!,
    pointsOfPain: 46,
    cardDescription: "You make a really big and juicy steak of meat to impress your date, but you don’t know he/she is vegan"
)


let card13 = CardModel (
    cardIcon: UIImage(named: "cardIcon13")!,
    pointsOfPain: 76,
    cardDescription: "You have been working for years in the same company but you never got a promotion"
)


//let card14 = CardModel (
//    cardIcon: UIImage(named: "cardIcon14")!,
//    pointsOfPain: 4,
//    cardDescription: "You have been looking for your glasses for one hour. They were sitting on your head."
//)
//
//
//let card15 = CardModel (
//    cardIcon: UIImage(named: "cardIcon15")!,
//    pointsOfPain: 12,
//    cardDescription: "You get ready for your meeting on Wednesday and then you realize it’s just on Tuesday"
//)
//
//
//let card16 = CardModel (
//    cardIcon: UIImage(named: "cardIcon16")!,
//    pointsOfPain: 24,
//    cardDescription: "You go to the supermarket, put lot of things inside the cart but when you get to the cash you notice you have forgotten your wallet"
//)
//
//
//let card17 = CardModel (
//    cardIcon: UIImage(named: "cardIcon17")!,
//    pointsOfPain: 58,
//    cardDescription: "You study a lot in order to pass an exam but you fail, while your friend who cheated passes it"
//)
//
//
//let card18 = CardModel (
//    cardIcon: UIImage(named: "cardIcon18")!,
//    pointsOfPain: 36,
//    cardDescription: "In order to help your friend during the exam you tragically fail yours"
//)
//
//
//let card19 = CardModel (
//    cardIcon: UIImage(named: "cardIcon19")!,
//    pointsOfPain: 81,
//    cardDescription: "You write all your bad feelings about your boss on a piece of paper and forget it on your desk. Guess someone will be on forced vacations tomorrow"
//)
//
//
//let card20 = CardModel (
//    cardIcon: UIImage(named: "cardIcon20")!,
//    pointsOfPain: 7,
//    cardDescription: "You wake up early and go to school, just like everyday. And then realize it’s Saturday "
//)


