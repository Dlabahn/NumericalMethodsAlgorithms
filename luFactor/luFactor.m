function [L,U,P] = luFactor(A)
%Created by: Derek LaBahn
%Created on: 28 Mar 2019
%Purpose: Output lower triangular, upper triangular and pivot matrix for a
%square matrix of coefficients
%
%Inputs:
%A = square matrix of coefficients
%
%Outputs:
%L = lower triangular matrix
%U = upper triangular matrix
%P = pivot matrix

%% Preliminary work

%check for input
if nargin < 1
    error('One matrix of variable coeffiecients must be input.')
end

%get size of input matrix
[m,n] = size(A);

%check that input matrix is square, if not error
if m ~= n
    error('The input matrix must have an equal number of rows and colums.')
end

%duplicate input matrix so original is preserved
Atemp = A;

%create preliminary outputs(same size as input matrix)
P = eye(n);%identity matrix 
L = zeros(n);%lower matrix
U = zeros(n);%upper matrix

%row counter for loop(doubles as column counter since square matrix)
rowctr=1;

%% main loop

%loop for every row
while rowctr <= n
%Pivoting
%find max value of current column and which row this absolute value max occurs in
[maxval,maxvalrow] = max(abs(A(rowctr:n,rowctr)));%A(rowctr:n,rowctr) to calculate max on remaining rows only 

%pivoting
%correct max value row
maxvalrow = maxvalrow + rowctr - 1;%from A(rowctr:n,rowctr), maxvalrow will be below actual value by rowctr - 1
%EXAMPLE: if A =[10 15 4    rowctr = 2
%               0  8  3    max(abs(A(rowctr:n,rowctr))) = [8    this will output maxval = 10 maxvalrow = 2   
%               0  10 9]                                   10]
%                          maxvalrow = maxvalrow + rowctr - 1  =  2+2-1 = 3
                        
%switch rows in A,P,L rows
%for A
Atemprow = A(maxvalrow,:);%recreate temporary max value row
A(maxvalrow,:) = A(rowctr,:);%copy current row to max value row
A(rowctr,:) = Atemprow;%copy temp max value row to current row
%for P
Ptemprow = P(maxvalrow,:);%recreate temporary max value row
P(maxvalrow,:) = P(rowctr,:);%copy current row to max value row
P(rowctr,:) = Ptemprow;%copy temp max value row to current row

if rowctr>1%no L values for first loop
Ltemprow = L(maxvalrow,:);%recreate temporary max value row
L(maxvalrow,:) = L(rowctr,:);%copy current row to max value row
L(rowctr,:) = Ltemprow;%copy temp max value row to current row
end

%substitute pivoted row into U
U(rowctr,:)=A(rowctr,:);
%new variable for factors to be inserted into L 
factorrow = rowctr;

%loop for creating L values for current column and performing forward
%elimination for current row
while factorrow < n %complete for each row
    factor = A(factorrow+1,rowctr)/A(rowctr,rowctr); %factor = current factor row / current main row
    L(factorrow+1,rowctr) = factor; %write factor value to L
    Afactorrow = factor * A(rowctr,:); %multiply current main row by factor
    A(factorrow+1,:) = A(factorrow+1,:)- Afactorrow; %forward elimination for current factor row
    factorrow = factorrow +1; %next factor row
end

%next main row and coloumn
rowctr = rowctr + 1;
end
    
%% write diagonal L values
%variable for L row counter
lctr = 1;
%loop to write values from L(1,1) to L(n,n)
while lctr <= n
    L(lctr,lctr) = 1;%write value
    lctr = lctr +1;%increase row counter
end

%store original matrix (possibly needed for further algorithm expansion)
A = Atemp;

end