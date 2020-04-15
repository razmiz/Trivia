//
//  Question.swift
//  Trivia
//
//  Created by Raz on 11/04/2020.
//  Copyright © 2020 Raz. All rights reserved.
//

import Foundation

struct Question {
    let question: String
    let answers: [String]
    let correctAnswer: String
}

func buildQuestionArray() -> [Question]{
    let questionsArray: [Question] = [
        Question(question: "Which continent is the largest?", answers: ["Europe", "Asia", "Africa", "America"], correctAnswer: "Asia"),
        Question(question: "Who is the king of all animals?", answers: ["Cat 🐱", "Tiger 🐅", "Lion 🦁","Whale 🐋"], correctAnswer: "Lion 🦁"),
        Question(question: "What is the capital of France?", answers: ["Nice", "Lyon", "Strasbourg","Paris"], correctAnswer: "Paris"),
        Question(question: "How many legs does a chicken have? 🐓", answers: ["2", "3", "4","8"], correctAnswer: "2"),
        Question(question: "How many stars appear on the American Flag? 🇺🇸", answers: ["10", "50", "25","100"], correctAnswer: "50"),
        Question(question: "How many legs does a spider have? 🕷", answers: ["10", "2", "8","4"], correctAnswer: "8"),
        Question(question: "What color do you get when you combine yellow and blue? ", answers: ["Green", "Purple", "Pink","Black"], correctAnswer: "Green"),
        Question(question: "Which Disney movie is Elsa in?", answers: ["Frozen", "The Little Mermaid", "Aladdin","Beauty and the Beast"], correctAnswer: "Frozen"),
        Question(question: "What do bees make? 🐝", answers: ["Honey","Milk","Water","Eggs"], correctAnswer: "Honey"),
        Question(question: "How many days are in a year?", answers: ["365","7","30","180"], correctAnswer: "365"),
        Question(question: "What kind of animal was Abu in Aladdin? ", answers: ["Monkey","Lion","Elephant","Fox"], correctAnswer: "Monkey"),
        Question(question: "How many colors are in a rainbow? 🌈", answers: ["Five","Eight","Seven","Ten"], correctAnswer: "Seven"),
        Question(question: "Who painted the Mona Lisa? 👨🏻‍🎨", answers: ["Leonardo DaVinci","Vincent van Gogh","Michelangelo","Salvador Dalí"], correctAnswer: "Leonardo DaVinci"),
        Question(question: "What is the seventh month of the year?", answers: ["July","January","March","August"], correctAnswer: "July"),
        Question(question: "Which British band recorded \"Another Brick In the Wall\"?", answers: ["Pink Floyd", "The Beatles", "The Rolling Stones", "Led Zepplin"], correctAnswer: "Pink Floyd"),
        Question(question: "In which English city is Buckingham palace located? 🏰", answers: ["London","Manchester","Birmingham","Liverpool"], correctAnswer: "London"),
        Question(question: "In what year the industrial revolution started? 🏗", answers: ["1760","1960","1996","1320"], correctAnswer: "1760"),
        Question(question: "What is the first letter in the Greek alphabet? 📝", answers: ["alpha", "beta", "pi","omega"], correctAnswer: "alpha"),
        Question(question: "What is the capital city of Spain?", answers: ["Madrid", "Barcelona", "Valencia", "Seville"], correctAnswer: "Madrid"),
        Question(question: "What are the three primary colours?", answers: ["Red, Yellow, Blue", "White, Black, Grey", "Red, Pink, Orange", "Green, Purple, Blue"], correctAnswer: "Red, Yellow, Blue"),
        Question(question: "In which movie would you hear the song 'Hakuna Matata'?", answers: ["Lion King", "Cinderella", " Beauty and the Beast", "Hercules"], correctAnswer: "Lion King"),
        Question(question: "What country is Rome located in? 🇮🇹", answers: ["France","Italy","Jamaica","Spain"], correctAnswer: "Italy"),
        Question(question: "George Harrison was a member of which famous band? 🎤", answers: ["Pink Floyd", "The Beatles", "The Rolling Stones", "Led Zepplin"], correctAnswer: "The Beatles"),
        Question(question: "Which country is Liberty Statue located in? 🗽", answers: ["United States", "France","Germany","England"], correctAnswer: "United States"),
        Question(question: "What is the chemical composition for water?💧", answers: ["CO2","HO2","H2O","HN2"], correctAnswer: "H2O"),
        Question(question: "What's our galaxy called? 🪐", answers: ["The Star Belt","The Milky Way","The Golden Wing","The Crimson String"], correctAnswer: "The Milky Way"),
        Question(question: "What's the largest ocean in the world?", answers: ["Indian","Pacific","Atlantic","Arctic"], correctAnswer: "Pacific"),
        Question(question: "How many players each team has at the start of soccer game? ⚽️", answers: ["11","10","9","5"], correctAnswer: "11"),
        Question(question: "Which desert is the largest in the world?", answers: ["Sahara Desert","Arabian Desert","Syrian Desert","Great Victoria Desert"], correctAnswer: "Sahara Desert"),
        Question(question: "Which country invented pizza? 🍕", answers: ["France","Italy","Belgium","Spain"], correctAnswer: "Italy"),
        Question(question: "How many squared are in the chessboard? ♟️", answers: ["64","12","24","100"], correctAnswer: "64"),
        Question(question: "Who is the author of Harry Potter series?", answers: ["J.K. Rolling","Mark Twain","J. R. R. Tolkien","William Shakespeare"], correctAnswer: "J.K. Rolling"),
        Question(question: "Where was Jesus born?", answers: ["Bethlehem", "Jerusalem","Nazareth","Tel Aviv"], correctAnswer: "Bethlehem")
    ]
    
    return questionsArray
}


