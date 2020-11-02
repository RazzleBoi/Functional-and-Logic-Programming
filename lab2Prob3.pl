%8.a) Model:
% count(a1..an, elem) = 0, if n=0,
%			1 + count(a2..an, elem), if a1 = elem
%			count(a2..an, elem), otherwise

%count(L:list, X:elem, Res:int)
%flow model (I,I,o), (I,I,I) 

count(L, _, R):-
		L =[], 
		R = 0.
		
count([H|T], X, R):- 
	H = X, 
	count(T, X, R1),  	
	R is R1 + 1.
	
count([H|T], X, R):- 
	H \= X,	
	count(T, X, R).  
	
%Model
%removDupli(a1..an,b1..bm) = 	[], if n=0
%				removDupli(a1..an,b2..bm), if count(a1..an, b1) !=1
%				a1 U removDupli(a1..an,b2..bm), if count(a1..an, b1) =1
%
%removeDupli(A:list, B:list, R:list)
%A =copy of list B
%flow model (I,I,o) (I,I,I)
removeDupli(_,[],R):-
	R = [].
	
removeDupli(A, [H|T], R):-
	not(count(A, H, 1)),
	removeDupli(A, T, R).
	
removeDupli(A, [H|T], R) :- 
	count(A, H, 1), 
	removeDupli(A, T, R1), 
	R = [H|R1]. 

%wrapper
removeMain(A,R) :-
	removeDupli(A, A, R).


%8.b)
%remove(a1..an, e) = 	[], if n=0
%			remove(a2..an, e), if e=a1
%			a1 U remove(a2..an, e), if e!=a1
%remove(A:list, E:elem, R:list)
%flow model (I,I,o)
remove([],_,R):-
	R = [].
	
remove([H|T], E, R):-
	H \= E,
	remove(T, E, R1),
	R = [H|R1].
	
remove([H|T], E, R) :- 
	H = E,
	remove(T, E, R).


%removeMax(a1..an,b1..bm, curr) = 	remove(b1..bm,curr), n=0
%					removeMax(a2..an, b1..bm, curr), if curr >= a1
%					removeMax(a2..an, b1..bm, a1), if curr< a1	

%removeMax(A:list, B:list,  M:list, curr:int,)
%B =copy of list A from which we will remove the maximum

%flow model (I,I,O,I)
%remove(B, curr, R1),
removeMax([], B, M, C):-
	remove(B, C, R1),	
	M = R1.
removeMax([H|T], B, M, C):-
	H > C,
	removeMax(T, B, M, H).

removeMax([H|T], B, M, C):-
	H =< C,
	removeMax(T, B, M, C).

func([]):-
	false.
	
func([_|T]):-
	not(func(T)).
	
	