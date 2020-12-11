% SYMPATHETIC DOCTOR

main:-initialize(),
      readPain(),
      readMood(),
      readFever(),
      readBowel(),
      readMiscellaneous(),
      diagnose().



test(X):-
   X=='yes'.

 
initialize():- retractall(pain(_)),
               retractall(mood(_)),
               retractall(fever(_)),
               retractall(bowel(_)),
               retractall(miscellaneous(_)).


list_empty([]):-true().
list_empty([_|_]):-false().



pain_library([unbearable,strong,mild,manageable,no]).
mood_library([stressed,angry,weepy,depressed,calm]).
fever_library([very_high,high,mild,low,no]).
bowel_movements_library([hard,loose,tarry,bloody,normal]).
miscellaneous_library([itchy,giddy,hallucinating,twitches,palpitations,no_special_symptoms]).


pain().
mood().
fever().
bowel().
miscellaneous().



cancer():-pain(strong),mood(depressed),fever(mild),bowel(bloody),
          miscellaneous(giddy).
amoebiasis():-pain(unbearable),mood(weepy),fever(high),bowel(loose),
              miscellaneous(itchy).
rabies():-pain(strong),mood(angry),fever(high),bowel(normal),
          miscellaneous(hallucinating).
heart_trouble():-pain(unbearable),mood(stressed),fever(no),bowel(normal),
                 miscellaneous(palpitations).
dehydration():-pain(no),mood(calm),fever(no),bowel(hard),
               miscellaneous(giddy).



diagnose():-nl,
            cancer()->write("You may have cancer. I recommend undergoing medical tests"); % if have cancer then print
            amoebiasis()->write("You have amoebiasis. I will prescribe you the antibiotics");
            rabies()->write("You have rabies. We have to admit you to the hospital");
            heart_trouble()->write("You may have heart trouble. I recommend a stress test immediately");
            dehydration()->write("Nothing to worry. Drink a lot of water with electrolytes");
            write("We need further testing to ascertain the cause").



readPain():-pain_library(X),readPain(X). % pass all X that is in pain_library to readPain
readMood():-mood_library(X),readMood(X).
readFever():-fever_library(X),readFever(X).
readBowel():-bowel_movements_library(X),readBowel(X).
readMiscellaneous():-miscellaneous_library(X),readMiscellaneous(X).


readPain(List):-
                  [H|T]=List, % Split the list into head and tail
                  format("Do you experience ~w pain",[H]), % print the questions along with the head
                  read(X), % read user input
                  ((test(X);list_empty(T))->assert(pain(H)); % assert fact if last item in the list or answer is yes
                  readPain(T) % if answer is no and there are more items, then recursion
                  ).


readMood(List):-
                  [H|T]=List,
                  format("Do you feel ~w",[H]),
                  read(X),
                  ((test(X);list_empty(T))->assert(mood(H));
                  readMood(T)
                  ).


readFever(List):-
                  [H|T]=List,
                  format("Do you have ~w fever",[H]),
                  read(X),
                  ((test(X);list_empty(T))->assert(fever(H));
                  readFever(T)
                  ).


readBowel(List):-
                  [H|T]=List,
                  format("Do you experience ~w stools",[H]),
                  read(X),
                  ((test(X);list_empty(T))->assert(bowel(H));
                  readBowel(T)
                  ).

readMiscellaneous(List):-
                  [H|T]=List,
                  format("Do you experience ~w ",[H]),
                  read(X),
                  ((test(X);list_empty(T))->assert(miscellaneous(H));
                  readMiscellaneous(T)
                  ).