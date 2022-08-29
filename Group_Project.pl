/* Group Members:
1)Seantae Laylor- 1808021
2)Ralph Taylor- 1803071
3)Aldane Montaque- 1701075
*/


tested(it_works,yes).


:- use_module(library(pce)).

:- dynamic mu/2.
:- dynamic mild/2.
:- dynamic delta/2.
:- dynamic severe/2.
:- dynamic count/1.
:- dynamic risk/2.

risk(0,0).
mu(0,0).
mild(0,0).
delta(0,0).
severe(0,0).
count(0).

/*This function is to call the home menu to be used.*/
% create a function called home
home:-
    % create the name of the window title.
    new(H,dialog('Expert System Menu')),
    % Display message in the window
    send(H,append,new(Label1,label)), send(Label1,append,'                                     Welcome to the COVID Expert System'),
     send(H,append,new(Label2,label)), send(Label2,append,'                                             Please select an option'),
    % Use to create a space
    send(H,append,new(label(' '))),
    % Create buttons with name and the functions they call
    send(H,append,button(patient_condition, message(@prolog, new_fact))),
    send(H,append,button(blood_pressure_check, message(@prolog, bp_check))),
    send(H,append,button(add_symptoms, message(@prolog, add_facts))),
    send(H,append,button(display_statistics, message(@prolog, display))),
    %Opens the window
    send(H,open).


% Create a function called add_facts
add_facts:-
    %Create the name of the window title
    new(Cat,dialog('COVID Diagnosis System')),send(Cat,append,new(label)),
    %Display the questions and marked them yes
    send(Cat,append,new(Fever,menu('Do you have fever',marked))),
    send(Cat,append,new(Dry_cough,menu('Do you have Dry cough',marked))),
    send(Cat,append,new(Tiredness,menu('Do you get tired easy',marked))),
    send(Cat,append,new(Shortness_of_breath,menu('Do you get shortness of breath',marked))),
    send(Cat,append,new(Taste,menu('Do you have loss of taste',marked))),
    send(Cat,append,new(Muscle_aches,menu('Do you have muscle aches',marked))),
    send(Cat,append,new(Smell,menu('Do you have loss of smell',marked))),
    send(Cat,append,new(Congestion,menu('Do you have congestion or runny nose',marked))),
    send(Cat,append,new(Headaches,menu('Do you have headaches',marked))),
    send(Cat,append,new(Sore_throat,menu('Do you have sore throat',marked))),
    send(Cat,append,new(Diarrhea,menu('Do you have diarrhea',marked))),
    send(Cat,append,new(Fatigue,menu('Are you fatigue?',marked))),
    send(Cat,append,new(Vomiting,menu('Are you vomiting?',marked))),

    % create yes and no radio buttons
    send(Fever, append, yes),                send(Fever, append, no),
    send(Dry_cough, append, yes),   send(Dry_cough, append, no),
    send(Tiredness, append, yes),   send(Tiredness, append, no),
    send(Shortness_of_breath, append, yes),       send(Shortness_of_breath, append, no),

    send(Taste,append, yes),            send(Taste, append, no),
    send(Muscle_aches,append, yes),            send(Muscle_aches, append, no),
    send(Smell,append, yes),            send(Smell, append, no),
    send(Congestion,append, yes),            send(Congestion, append, no),
    send(Headaches,append, yes),            send(Headaches, append, no),
    send(Sore_throat,append, yes),            send(Sore_throat, append, no),
    send(Diarrhea,append, yes),            send(Diarrhea, append, no),
    send(Fatigue,append, yes),            send(Fatigue, append, no),
    send(Vomiting,append, yes),            send(Vomiting, append, no),


% Create a button called accept that Sends the information to the
% decision function
 send(Cat,append,button(accept,message(@prolog, decision,Fever?selection, Dry_cough?selection, Tiredness?selection, Shortness_of_breath?selection,Taste?selection, Muscle_aches?selection, Smell?selection, Congestion?selection, Headaches?selection,Sore_throat?selection,Diarrhea?selection,Fatigue?selection,Vomiting?selection ))),


% open the window
 send(Cat,open).




%Create a function called decision that uses values from add_facts
decision(Fever,Dry_cough,Tiredness,Shortness_of_breath,Taste,Muscle_aches,Smell,Congestion,Headaches,Sore_throat,Diarrhea,Fatigue,Vomiting):-
    %Create name of the window title
     new(App,dialog('Additional Information ')),send(App,append,new(label)),

        %Compare variable values against yes
        %Assign 1 if true or zero if false to a value holder variable
        (Fever == 'yes' -> Fev is 1;Fev is 0),
        (Dry_cough == 'yes' -> Dry is 1;Dry is 0),
        (Tiredness==  'yes' -> Tired is 1;Tired is 0),
        (Shortness_of_breath == 'yes' -> Short is 1; Short is 0),
        (Taste == 'yes' -> Tas is 1; Tas is 0),
        (Muscle_aches == 'yes' -> Mus is 1; Mus is 0),
        (Congestion == 'yes' -> Con is 1; Con is 0),
        (Headaches == 'yes' -> Head is 1; Head is 0),
        (Sore_throat == 'yes' -> Sore is 1; Sore is 0),
        (Diarrhea == 'yes' -> Dia is 1; Dia is 0),
        (Fatigue == 'yes' -> Fat is 1; Fat is 0),
        (Vomiting == 'yes' -> Vot is 1; Vot is 0),
        (Smell == 'yes' -> Nsmell is 1; Nsmell is 0),


    %Add the risk values
   Covid_19 is Fev+Dry+Tired+Short+Tas+Mus+Con+Head+Sore+Dia+Fat+Vot+Nsmell,

(
    % If risk value is greater than two and less than five patient is at risk
     %Check the risk value and display message
       %Assign value to risk to count number of persons
   ( ( send(App,append,new(Lab,label)),
     (Covid_19 > 2,Covid_19 < 5)-> send(Lab,append,'You are at risk for COVID_19')),Risk is 1);(Risk is 0) ,


 % If risk value is greater than 3 and less than 6 patient have mild symptoms
     %Check the risk value and display message
         %Assign value to mild to count number of persons
       (  ( send(App,append,new(Lab1,label)),
        (Covid_19 <6, Covid_19 > 3) -> send(Lab1,append,'You Have Mild Symptoms'),Mild is 1,send(Lab1,append, '\n Treatment is aimed at relieving symptoms and includes rest, fluid intake and pain relievers.Intake plenty fruits and vegetables. Contact your doctor if symptoms worsen.or persists.'));( Mild is 0)  ),


  % If risk value is greater than 5 and less than 14 patient have severe symptoms
     %Check the risk value and display message
       %Assign value to severe to count number of persons
(   ( send(App,append,new(Lab2,label)),
        (Covid_19   > 5, Covid_19 < 14 )-> send(Lab2,append,'You Have Severe Symptoms'),Severe is 1,send(Lab2,append,' \n Call 911 or go to the nearest emergency room. Don’t wait it out, because the complications could be deadly.'));(Severe is 0)  ) ),

 % If risk value is greater than 3 and less than 6 patient may have Mu variant
     %Check the risk value and display message
      %Assign value to Mu to count number of persons
  (  (  send(App,append,new(Lab3,label)),
        (( Covid_19 <6, Covid_19 > 3 ) -> send(Lab3,append,'You May Have Mu Variant'),Mu is 1));
      ( Mu is 0)      ),

   % If risk value is greater than 8 and less than 15 patient has Delta variant
     %Check the risk value and display message
        %Assign value to Delta to count number of persons
  (   ( send(App,append,new(Lab4,label)),
        ((Covid_19  > 8, Covid_19 <14 ) -> send(Lab4,append,'You Have Delta Variant'),Delta is 1));
         (Delta is 0)   ),

   % If risk value is less than 3 patient is not at risk
     %Check the risk value and display message

      (   ( send(App,append,new(Lab5,label)),
        (Covid_19 <3  -> send(Lab5,append,'You are not at risk for COVID 19')),M is 1);(M is 0)
         ),


Count is 1,

      riskstat(Risk,Count),
      mildstat(Mild, Count),
      severestat(Severe, Count),
      mustat(Mu, Count),
      deltastat(Delta, Count),


% Creates a button name continue that send you to the bp_check function
send(App,append,button(continue,message(@prolog, bp_check))),
% open window
send(App,open).


 /* Functions that calculate the different percentage values*/
 riskstat(Val,Count):-  risk(Cal,_),count(New1), News is Count + New1, New is Cal+Val, Per is ((New * 100)/News),retractall(risk(_,_)),assert(risk(New,Per)),retractall(count(_)),assert(count(News)) .

 mildstat(Val,Count):-  mild(Cal,_),count(New1), News is Count + New1, New is Cal+Val, Per is ((New * 100)/News),retractall(mild(_,_)),assert(mild(New,Per)),retractall(count(_)),assert(count(News)) .

 severestat(Val,Count):- severe(Cal,_),count(New1), News is Count + New1, New is Cal+Val, Per is ((New * 100)/News),retractall(severe(_,_)),assert(severe(New,Per)),retractall(count(_)),assert(count(News)).

mustat(Val,Count):- mu(Cal,_),count(New1), News is Count + New1, New is Cal+Val, Per is ((New * 100)/News),retractall(mu(_,_)),assert(mu(New,Per)),retractall(count(_)),assert(count(News)) .



deltastat(Val,Count):- delta(Cal,_),count(New1), News is Count + New1, New is Cal+Val, Per is ((New * 100)/News),retractall(delta(_,_)),assert(delta(New,Per)),retractall(count(_)),assert(count(News)) .



% Create a function name display
display:-

         %Create window name or title
        new(App,dialog('Display Statistics!')),send(App,append,new(label)),
/* Display the percentage of persons that are at risk, have mild or severe symptoms and Mu or Delta
Variant */
        risk(_,Pe),mild(_,Per),severe(_,Pery),mu(_,Pert),delta(_,Perts),

        send(App,append,new(Lab9,label)), send(Lab9,append,' Percentage of persons at risk is: '),
        send(App,append,new(Lab0,label)), send(Lab0,append,Pe),

        send(App,append,new(Lab1,label)), send(Lab1,append,'Percentage of persons with mild sysmptoms is: '),
        send(App,append,new(Lab2,label)), send(Lab2,append,Per),


        send(App,append,new(Lab3,label)), send(Lab3,append,'Percentage of persons with severe symptoms is: '),
        send(App,append,new(Lab4,label)), send(Lab4,append,Pery),


        send(App,append,new(Lab5,label)), send(Lab5,append,'Percentage of persons with Mu variant  is: '),
        send(App,append,new(Lab6,label)), send(Lab6,append,Pert),


        send(App,append,new(Lab7,label)), send(Lab7,append,'Percentage of persons with Delta variant is: '),
        send(App,append,new(Lab8,label)), send(Lab8,append,Perts),

         %Create a button name home that call the home function
        send(App,append,button(home,message(@prolog, home))),
         %open the window
        send(App,open).




/*This is to add the data on the patient's contributary factors.*/
 new_fact:-
    %Create the window name
    new(D,dialog('Information Addition ')),send(D,append,new(label)),
    %Display the message
    send(D,append,new(Name, text_item('Enter your name '))),
    send(D,append,new(Age, text_item('Enter your age'))),
    send(D,append,new(Temperature_dc, text_item('Enter your temperature in *C'))),
    %display radio button opttions
    send(D,append,new(Sex, menu(sex,marked))),
     %Display male or female radio button
    send(Sex, append, male),       send(Sex, append, female),
     %Display text box to allow user input
    send(Age, type, int),
    send(Temperature_dc, type, real),
    %Create a button name accept that sends the data to data_usage and call the function
    send(D,append,button(accept,message(@prolog, data_usage, Name?selection ,Sex?selection ,Temperature_dc?selection))),
    %open the window
    send(D,open).



%Create a function called_get_values
get_values:-
     %create window name
     new(App, dialog('Systolic and Diastolic Reading Menu')),
     %Display the questions
     send(App,append,new(Dizzy, menu('Have you experienced dizziness recently?',marked))),
     send(App,append,new(Faint, menu('Have you experienced any fainting recently?',marked))),
     send(App,append,new(Blurred, menu('Have you experienced any blurryness recently?',marked))),
     %Display the yes or no radio buttons
     send(Dizzy, append, yes),
     send(Dizzy, append, no),

     send(Faint, append, yes),
     send(Faint, append, no),

     send(Blurred, append, yes),
     send(Blurred, append, no),
      % Create a button called continue that call value_output and send the values to it
     send(App,append,button(continue ,message(@prolog, value_output, Dizzy?selection,  Faint?selection, Blurred?selection))),
     % open the window
     send(App,open).

%create function called value_output
value_output(Dizzy, Faint, Blurred):-
     %Create window name
     new(App, dialog('Systolic and Diastolic Reading Menu')),


     /*To check for dizziness, faiting or blurryness  if yes then call the pressure function*/
    (
    (   Dizzy == 'yes' -> send(App,append,new(SVal, text_item('Please enter your Systolic value  '))),
     send(App,append,new(DVal, text_item('Please enter your Diastolic value  ')))
     );

    (    Faint == 'yes' -> send(App,append,new(SVal, text_item('Please enter your Systolic value  '))),
     send(App,append,new(DVal, text_item('Please enter your Diastolic value  ')))
    );

      (    Blurred == 'yes' -> send(App,append,new(SVal, text_item('Please enter your Systolic value  '))),
     send(App,append,new(DVal, text_item('Please enter your Diastolic value  ')))
    )),

     send(SVal, type, int),
     send(DVal, type, int),
      %Create a button called continue that call the pressure function and sen the values to it
     send(App,append,button(continue ,message(@prolog, pressure, SVal?selection,  DVal?selection))),
      %open the window
     send(App,open).



%Create function name pressure that accepts 2 arguments
pressure(SVal, DVal):-
      %Create window name
     new(App, dialog('Blood Pressure Testing Menu')),

           % if SVal less than 90 patient has low bolld pressure
    (     (SVal < 90 -> Bpressure = 'Patient has Low Blood Pressure',
      %Display the message to the window
      send(App,append,new(Label1,label)), send(Label1,append,'Reading indicates: '),
      %Display the Bpressure value
      send(App,append,new(Label2,label)), send(Label2,append, Bpressure)

    );
     %If DVal less than 60 patient has low blood pressure
    (DVal < 60 -> Bpressure = 'Patient has Low Blood Pressure',
      %Display the message to the window
      send(App,append,new(Label1,label)), send(Label1,append,'Reading indicates: '),
     %Display Bpressure value
      send(App,append,new(Label2,label)), send(Label2,append, Bpressure)

    );
     %If DVal is greater than 60 pressure is ok
    (DVal > 60 -> Bpressure = 'Patients Blood Pressure is ok',
      %Display the message to the window
      send(App,append,new(Label1,label)), send(Label1,append,'Reading indicates: '),
      %Display Bpressure value
      send(App,append,new(Label2,label)), send(Label2,append, Bpressure)

    );
     %If SVal is greater than 90 pressure is ok
    (SVal > 90 -> Bpressure = 'Patients Blood Pressure is ok',
       %Display the message to the window
      send(App,append,new(Label1,label)), send(Label1,append,'Reading indicates: '),
      %Display Bpressure value
      send(App,append,new(Label2,label)), send(Label2,append, Bpressure)

    )     ),
      %Create button name continue that call the home function
     send(App,append,button(continue ,message(@prolog, home))),
     % Open the window
    send(App, open).


%Create a function called data_usage with 3 arguments
data_usage(Name,Sex,Temperature_dc):-
        %Create name of the window
        new(App,dialog('Data Being Added!')),
        %Display the message
        send(App,append,new(Lab1,label)), send(Lab1,append,'Patients Name is: '),
        %Display value entered
        send(App,append,new(Lab2,label)), send(Lab2,append,Name),
        % Convert tmeperature to farenheit
        Temperature_df is (Temperature_dc * 1.8)+(32),
        %Display the message
        send(App,append,new(Lab3,label)), send(Lab3,append,'Patients temperature in degrees fahrenheit is : '),
        % Display the converted temperature
        send(App,append,new(Lab4,label)), send(Lab4,append,Temperature_df),
        %Display the message
        send(App,append,new(Lab5,label)), send(Lab5,append,'Patients Gender is : '),
        %Display values selected
        send(App,append,new(Lab6,label)), send(Lab6,append,Sex),
        %Create a button called continue that call the get_values function
       send(App,append,button(continue ,message(@prolog, get_values))),
         %open the window
        send(App,open).



%Create a function call bp_check
bp_check:-
    %Create name of the window
    new(App, dialog('Blood Pressure Testing Menu')), send(App,append,new(label)),
    %Allow you to enter the values needed
    send(App,append,new(DVal, text_item('Enter your Diastolic Value '))),
    send(App,append,new(SVal, text_item('Enter your Systolic value'))),
    % Declare the variable type as integer
    send(SVal, type, int),
    send(DVal, type, int),
    %Create a button called accept values that sends the values to the pressure function
    send(App,append,button(accept_values ,message(@prolog, pressure, SVal?selection, DVal?selection))),
    %open the window
    send(App,open).
