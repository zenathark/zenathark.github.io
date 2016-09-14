---
layout: page
title: Starting Up
permalink: lectures/LIS2051/prolog/starting-up
---

The beginning
=============

Prolog is kind of a niche language. However good, it remains as an
obscure academic language often used on automatic theorem proving or
as database query language.

In contrast, this small tutorial is
aimed to solve classic programming
problems using prolog in order to be
more friendly to new users.  So,
while not heavy on the theorem
proving or database quering part,
some exercises show the strength of
prolog on those areas.

Firsts thing first, lets start our prolog interpreter. This tutorial is based on the GNU Prolog interpreter.

	GNU Prolog 1.4.4 (64 bits)
	Compiled Apr  9 2016, 13:47:50 with clang
	By Daniel Diaz
	Copyright (C) 1999-2013 Daniel Diaz
	| ?-

Here, you can see the prompt `| ?-`. This means the interpreter expects a query. This query will run
agains our loaded program which, so far, is empty.

First, lets try some arithmetic.

	| ?- ANS is 4 + 2.

	ANS = 6

	yes
	| ?- ANS is 5 * 7.

	ANS = 35

	yes
	| ?- ANS is 53115 - 31990
	.

	ANS = 21125

	yes
	| ?- ANS is 5 / 2.

	ANS = 2.5

	yes

This operations must be quite familiar for those that already knows an interpreted imperative
programming language such as Python or Ruby. However, notice that instead of typing the operation
directly, it was assigned to the variable `ANS`. This is because all operations must be bounded
to a variable. You can try typing the operation alone an see for yourself.

	| ?- 4 + 2.
	uncaught exception: error(existence_error(procedure,(+)/2),top_level/0)

This is because on this paradigm, the operation alone is not enough for it to "exists".

Notice that the aritmethic operators can also be written as follows:

	| ?- ANS is /(5, 2).

	ANS = 2.5

	yes

In Prolog, this notation denotes a **rule**. A rule can be seen like a function of an imperative language.

Beside the aritmethic operations, there are two concepts introduced: Variables and the operator
`is`. Variables are strings that starts with an Uppercase character followed by downcase and uppercase
characters, and numbers. The operator `is` bounds the result of the evaluation to the variable on the
left of it.

Booleans
--------

Prolog is able to test for order and equality.

	| ?- 5 == 5.

	yes
	| ?- 3 < 5.

	yes
	| ?- 3 =< 5.

	yes
	| ?- 3 > 5.

	no
	| ?- 3 >= 5.

	no
	| ?- 4 \= 2.

	yes

There are a few things happening here. First, notice how this results need not to be bounded to a
variable in order to be calculated. This is because a truth value is expected, hence the query is
valid. Also, there are nome operators here that differ from more common languages, the greater or
equal operator `>=` and the different operator `\=`.

Truth values are represented with the terms true and false.

	| ?- true.

	yes
	| ?- false.

	no

Relational operators are comma for conjunction, semicolon for disjunction and

	| ?- (true; true), !.

	yes
	| ?- (false; true), !.

	yes
	| ?- false, true.

	no
	| ?- true, true.

	yes

Notice that the semicolon queries had to end with `!`. This is because Prolog evaluates the terms
one by one when a semicolon is found. So, in order to finish the execution we had to `cut` the
execution. More on that later.

In GNU Prolog, some operations can automatically infer the types of the result. When one of the
arguments is float, the result is float. Also, when a string is of length one it is considered
as its ASCII value.

	| ?- X is 1 + 5.3
	.

	X = 6.2999999999999998

	yes
	| ?- X is 1 + 5.3.

	X = 6.2999999999999998

	(1 ms) yes
	| ?- X is 2 / 5.

	X = 0.40000000000000002

	yes
	| ?- X is 2 + "A".

	X = 67

	yes
	| ?- X is "A" + 2.

	X = 67

	yes

Atomic numbers.
---------------

A fundamental block of Prolog syntax is the atom. An atom can be one
of the following:

+ A string that starts with a lower-case letter, followed by upper-case letters,
lower-case letters, digits, and underscore.
+ A string of arbitrary characters enclosed in quotes.

Prolog provides the rule **atom** for evaluating if a term is an atom.

Here are some examples

	| ?- atom('OAEU AOEU OEU').

	yes
	| ?- atom(x).

	yes
	| ?- atom(test).

	yes
	| ?- atom(pi2o_A).

	yes
	| ?- atom('This is an atom').

	yes

If a term begins with a number, its evaluation causes an exception

	| ?- atom(5eu).
	uncaught exception: error(syntax_error('user_input:99 (char:7) , or ) expected'),read_term/3)

A number can be either an integer or a decimal. Prolog also has the rule **number** for
evaluating if a term is a number.

Some tests

	| ?- number(26).

	yes
	| ?- number(0.533).

	yes
	| ?- number(-2.3).

	yes

Ruling the Kingdom.

In Prolog, programs are composed of clauses. A clause is a goal with a full stop. There are
two types of clauses: rules and facts.

A rule seems like a function of an imperative language. It has a head, a **neck**, and a body.

  head(Argument) :- body.

The head can be seen as the signature of the function that specifies how many arguments are
needed, the neck is the `:-` atom and the body is the body of the function. But, unlike
functions in imperative programming, rules always evaluate to true or false.

Lets write our first function. Open a text editor and write the following code

	 doubleMe(X) :- Y is X + X.

Here, we defined the rule that given a value `X`, the variable `Y` is bounded to the
arithmetic sum of `X + X`. Save this source code as `ruling.pl`. Now, in the prolog
environment, type in `consult('ruling.pl')`. This will load our program into the session.
Now, we can call the rule.

	| ?- consult('ruling.pl').
	compiling /Users/juancgalan/github/LIS2051/src/prolog/ruling.pl for byte code...
	../ruling.pl:1: warning: singleton variables [Y] for doubleMe/1
	../ruling.pl compiled, 1 lines read - 391 bytes written, 8 ms

	yes
	| ?- doubleMe(3).

	yes
	| ?-

Woah, what happened here?. The rule was invoked but it only returned a truth value.
Lets remember that we said that Prolog rules can only returt truth values. When we
loaded the file, we got a message warning saying that the variable that has our
result is a 'singleton variable'. This means that our variable is doing nothing
after the evaluation. Lets fix it by editing our file


	 doubleMe(X, Y) :- Y is X + X.

Now, Y is bounded to our rule. Lets try again

	| ?- consult('ruling.pl').
	compiling /Users/juancgalan/github/LIS2051/src/prolog/ruling.pl for byte code...
	/Users/juancgalan/github/LIS2051/src/prolog/ruling.pl compiled, 1 lines read - 425 bytes written, 11 ms

	yes
	| ?- doubleMe(3,Y).

	Y = 6

	yes

We got rid of the warning and now we can invoke our rule. Notice that we need to pass two
parameters now so we can get our result back. If we want to save the result of a rule, we
need to pass a variable as a parameter.
