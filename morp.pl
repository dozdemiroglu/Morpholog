%Finite-state automaton.
initial(q1).
final(q1).
final(q2).
final(q3a).
final(q3b).
final(q3c).
final(q4a).
final(q4b).
final(q5).

t(q0,true,q1).
t(q1,verb,q2).
t(q2,neg,q3a).
t(q2,tense,q3b).
t(q2,defpast,q3c).
t(q3a,tense,q3b).
t(q3a,defpast,q3c).
t(q3a,person,q5).
t(q3b,indpast,q4a).
t(q3b,defpast,q4b).
t(q3b,person,q5).
t(q3c,defpast,q4b).
t(q3c,person,q5).
t(q4a,person,q5).
t(q4b,person,q5).
t(q5,defpast,q4b).
%Metinde seçtiðim fiiller
morpheme(verb,bakmayacaktım).
morpheme(verb,geçiyoruz).
morpheme(verb,konuyor).
morpheme(verb,olmuyor).
morpheme(verb,açıyordu).
%duyulan geçmiþ zaman
morpheme(tense,mış).
morpheme(tense,miş).
morpheme(tense,muş).
morpheme(tense,müş).
% þimdi ki zaman
morpheme(tense,iyor).
morpheme(tense,ıyor).
morpheme(tense,uyor).
morpheme(tense,üyor).
morpheme(tense,yor).
% gelecek zaman
morpheme(tense,ecek).
morpheme(tense,acak).
morpheme(tense,yecek).
morpheme(tense,yacak).
% geniþ zaman
morpheme(tense,ır).
morpheme(tense,ir).
morpheme(tense,ur).
morpheme(tense,ür).
morpheme(tense,ar).
morpheme(tense,er).
% istek kipi
morpheme(tense,e).
morpheme(tense,a).
morpheme(tense,ye).
morpheme(tense,ya).
% gereklilik kipi
morpheme(tense,meli).
morpheme(tense,malı).
% þart kipi
morpheme(tense,se).
morpheme(tense,sa).
morpheme(tense,sey).
morpheme(tense,say).
% görülen geçmiþ zaman
morpheme(defpast,di).
morpheme(defpast,dı).
morpheme(defpast,du).
morpheme(defpast,dü).
morpheme(defpast,ydi).
morpheme(defpast,ydı).
morpheme(defpast,ydu).
morpheme(defpast,ydü).
morpheme(defpast,ti).
morpheme(defpast,tı).
morpheme(defpast,tu).
morpheme(defpast,tü).
% olumsuzluk ekleri
morpheme(neg,me).
morpheme(neg,ma).
morpheme(neg,mu).
morpheme(neg,mü).
morpheme(neg,mi).
morpheme(neg,mı).
% duyulan geçmiþ zaman(rivayet birleþik fiilleri için)
morpheme(indpast,mış).
morpheme(indpast,miş).
morpheme(indpast,muş).
morpheme(indpast,müş).
% þahýs ekleri
%birinci tekil
morpheme(person,m).
morpheme(person,ım).
morpheme(person,im).
morpheme(person,um).
morpheme(person,üm).
morpheme(person,yım).
morpheme(person,yim).
morpheme(person,yum).
morpheme(person,yüm).
%ikinci tekil
morpheme(person,n).
morpheme(person,ın).
morpheme(person,in).
morpheme(person,un).
morpheme(person,ün).
morpheme(person,sın).
morpheme(person,sin).
morpheme(person,sün).
morpheme(person,sun).
%birinci çoðul
morpheme(person,ız).
morpheme(person,iz).
morpheme(person,uz).
morpheme(person,üz).
morpheme(person,ık).
morpheme(person,ik).
morpheme(person,yız).
morpheme(person,yiz).
morpheme(person,yuz).
morpheme(person,yüz).
%ikinci çoðul
morpheme(person,ınız).
morpheme(person,iniz).
morpheme(person,unuz).
morpheme(person,ünüz).
morpheme(person,sınız).
morpheme(person,siniz).
morpheme(person,sunuz).
morpheme(person,sünüz).
%üçüncü çoðul
morpheme(person,lar).
morpheme(person,ler).
turkishverb(String,Morphemes) :-
                            initial(State),
                            turkishverb(String,State,Morphemes).
turkishverb('',State,[]) :-
                            final(State).

turkishverb(String,State,[Morpheme|Rest_Of_Morphemes]) :-
       concat(Allomorph,Rest,String),
       morpheme(Morpheme,Allomorph),
       t(State,Morpheme,NextState),
       (not(Rest = '') ->
       (harmony_suffixal_prefix(Rest,Segment),
        concat(Allomorph,Segment,Substring),
        weakly_harmonize(Substring)); true),
      turkishverb(Rest,NextState,Rest_Of_Morphemes).

harmony_suffixal_prefix(Rest,Char):-
   string_to_list(Rest,[Code|_]),
   char_code(Char,Code),
   vowel(Char).

harmony_suffixal_prefix(Rest,Segment):-
   string_to_list(Rest,[Code1,Code2|_]),
   char_code(Char1,Code1),
   char_code(Char2,Code2),
   consonant(Char1),
   vowel(Char2),
   concat(Char1,Char2,Segment).






























