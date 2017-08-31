%% What goes around
%% 1. Accuracy settings
%*** Set opt variable as directed.

%% 2. Write the function r3body (separate file)
%*** Write function r3body.m. Do nothing here.
type r3body

%% 3. A 2-loop solution

%*** Use given values to compute an orbit with two large loops.

clf
%*** Plot the orbit in the x-y plane. 

% Add earth and moon:
hold on, plot(0,0,'b.','markersize',30)
plot(1,0,'.','markersize',15,'color',[.7 .6 .4])

%% 4. A 3-loop solution

%*** Compute a 3-loop solution.

clf
%*** Plot the orbit in the x-y plane. 

% Add earth and moon:
hold on, plot(0,0,'b.','markersize',40)
plot(1,0,'.','markersize',15,'color',[.7 .6 .4])

%% 5. A 4-loop solution
%*** Compute a 4-loop solution.
clf

%*** Plot the orbit in the x-y plane. 

% Add earth and moon:
hold on, plot(0,0,'b.','markersize',40)
plot(1,0,'.','markersize',15,'color',[.7 .6 .4])

%% 6. Show long-term drift
%*** Repeat step 5 over t in [0,100].
