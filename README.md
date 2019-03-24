# ChuckNorrisTalk

## What is it?

This project is a client for [Chuck Norris Api](https://api.chucknorris.io/) written in [Smalltalk (Cuis)](https://github.com/Cuis-Smalltalk/Cuis-Smalltalk-Dev).

## Running
After cloning this repo, open a workspace in Cuis and type:

Feature require: #'ChuckNorrisTalk'.

And then:

|client|
client := ChuckNorrisIoClient  new.
client random. "inspect it for a random fact"
client categories. "inspect it for a list of categories"
client randomByCategory: #dev. "inspect it for a random fact by category"
c search: 'brazil'. (or c search: 'argentina') "inspect it for a list of facts"

## Morph for random facts.
There is a morph to show random facts. Execute:

ChuckNorrisMorph  open
