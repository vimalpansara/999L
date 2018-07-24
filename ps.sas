libname Clinical "D:\vimal\statistics\sas\clinical sas\practise sas";
libname Clinical "D:\vimal\statistics\sas\clinical sas\practise output";

/*import excel data*/
proc import datafile="" out=newdata;
dbms=excel;
run;

/*creating dataset*/
data Clinical.cl;
input id: name$:20. salary: dob: yymmdd10. gender$: doj: date9.;
format salary dollar8. dob yymmdd10. doj date9.;
datalines;
101 VimalkumarPansara 400000 1974-04-01 Male 12mar2018
102 Sudhakar 500000 1990-03-05 Male 01feb2015
103 Annapurna 600000 1990-03-03 Female 03jan2014
104 Shivani 200000 1990-01-01 Female 09aug2018
105 Mrudang 400000 2006-09-12 Male 06sep2017
106 Kashyap 500000 1994-01-01 Male 05dec2018
;
run;

/*numeric to character of date*/
data Clinical.cl1;
set Clinical.cl;
newdate=put(dob,yymmdd10.);
run;
/*charater to numeric of date*/
data Clinical.cl2;
set Clinical.cl1;
new=input(newdate,yymmdd10.);
run;
/*change format of  date and numeric to character*/
data Clinical.cl3;
set Clinical.cl2;
format new yymmdd10.;
newd=put(new,yymmdd10.);
run;
/*change character to numeric and date format*/
data Clinical.cl4;
set Clinical.cl3;
newdd=input(newd,yymmdd10.);
format newdd yymmdd10.;
run;
/*change lablel*/
data Clinical.label;
set Clinical.cl4;
label id="identification number"
      name="name of employee"
	  salary="annual salary"
	  dob="date of birth"
	  gender="gender of employee"
	  doj="date of joining"
	  ;
	  run;
/*keep*/
data Clinical.class;
set sashelp.Class;
run;
data Clinical.class1 (keep = Name Age Sex);
set Clinical.class;
/*keep Name Age Sex;*/
run;
data c
/*drop*/
data Clinical.classd;
set sashelp.Class;
run;
data Clinical.d(drop = Name Age Sex);
set Clinical.classd;
run;
/*Rename*/
data Clinical.classr;
set sashelp.Class;
run;

data Clinical.classre(rename (Name = employee));
set Clinical.classr;
run;

data Clinical.classre;
set Clinical.classr;
employee=Name;
run;


/*Where*/
data Clinical.wh;
set sashelp.Class;
run;
data Clinical.wh1;
set Clinical.wh;
where Sex="M";
where Age>=13;
run;
/*attrib*/
data Clinical.atrb;
input id: name$:20. salary: dob: yymmdd10. gender$: doj: date9.;
format dob yymmdd10. doj date9.;
attrib id label="Identification Number"
       name label = "Name of Employee"    
       salary label="Yearly salary"
       salary format = comma7.
       dob format=date9.
       doj format=is8601da.;
datalines;
101 VimalkumarPansara 400000 1974-04-01 Male 12mar2018
102 Sudhakar 500000 1990-03-05 Male 01feb2015
103 Annapurna 600000 1990-03-03 Female 03jan2014
104 Shivani 200000 1990-01-01 Female 09aug2018
105 Mrudang 400000 2006-09-12 Male 06sep2017
106 Kashyap 500000 1994-01-01 Male 05dec2018
;
run;


/*Retain Statement*/
data Clinical.Retain;
input CUSTID loan;
datalines;
101 1000
102 2000
103 3000
104 4000
;
run;
data Clinical.Retainl;
set Clinical.Retain;
retain total 0;
Total=total+loan;
run;

/*retain always work before set statements*/
Data Clinical.x;
retain a b x y;
set 
run;
data clinical.x;
a="DrugA";
b=1;
run;
data Clinical.y;
a=12;
b=13;
c=14;
run;

data Clinical.Z;
x="23Mar1999"d;
format x yymmdd10.;
run;
/*sum statement*/
data Clinical.sum;
a=10;
b=15;
c=18;
total=a+b+c;
run;
data Clinical.sum1;
a=10;
b=.;
c=45;
d=30;
total=a+b+c+d;
run;
data Clinical.sum2;
input id loan1 loan2 loan3;
datalines;
101 100 150 250 
102 300 100 100 
103 300 300 200 
;
run;
data Clinical.sum3;
set Clinical.sum2;
Total_loan=loan1+loan2+loan3;
run;

/*sum function*/
data Clinical.sumf;
input id mark1 mark2 mark3; 
datalines;
101 80 . 85
102 90 90 92
103 65 75 80
;
run;
data Clinical.sumf1;
set Clinical.sumf;
total=sum(mark1,mark2,mark3);
run;

/*proc transpose*/

data Clinical.trp;
set sashelp.Class;
label Name="Name of student"
      Age="Age of student"
	  Sex="Gender of student"
	  Height="Height of student"
	  Weight="Weight of Student";
run;
proc transpose data=Clinical.trp out=Clinical.trp1;
run;
proc transpose data=Clinical.trp1 out=Clinical.trp2;
run;
proc sort data=Clinical.trp out=Clinical.trp3;
by sex;
run;
proc transpose data=Clinical.trp3 out=Clinical.trp4;
by sex;
run;
proc transpose data=Clinical.trp out=Clinical.trpvar;
var Name Sex Age;
run;
proc transpose data=Clinical.trp out=Clinical.trpid;
var Name Sex Age;
id Name;
run;

/* reverse function*/

data Clinical.palindrome;
input name$;
datalines;
sara 
abc
xyx
abcbc
ff
uueer
krishna
;
run;
data Clinical.palindrome1;
set Clinical.palindrome;
x=reverse(name);
if strip(name)=strip(x) then palindrome="y";
else palindrome="n";
run;

/*maths function*/

data Clinical.maths;
input Number;
datalines;
1
2
3
4
5
6
7
8
9
10
;
run;

data Clinical.maths1;
set Clinical.maths;
x=12;
m=Number*x;
p=catx("*",Number,x);
z=catx("=",p,m);
run;

data Clinical.maths2;
set Clinical.maths;
x=10;
m=Number+x;
p=catx("+",Number,x);
z=catx("=",p,m);
run;

/*match merge*/
data Clinical.ds1;
input pt age$ sal comma5.;
format sal comma5.;
datalines;
101 24 2000
102 30 2000
103 40 3000
104 50 4000
;
run;
data Clinical.ds2;
input pt country$;
datalines;
101 uk
103 uk
104 uk
105 uk
;
run;

data Clinical.ds3;
merge Clinical.ds1 Clinical.ds2;
by pt;
run;

/*many to one merge*/
data Clinical.mtm1;
input pt ae$ stdt yymmdd10.;
format stdt yymmdd10.;
datalines;
101 vomiting 2015-02-10
101 fever 2015-09-09
101 headache 2016-09-09
102 vom 2017-08-01
102 fev 2016-09-01
102 fever 2014-01-01
102 nausea 2017-02-02
103 diabetes 2015-01-01
104 highsuger 2016-01-02
;
run;
data Clinical.mtm2;
input pt trt yymmdd10.;
format trt yymmdd10.;
datalines;
101 2015-02-10
102 2015-09-09
103 2015-02-02
103 2015-09-09
103 2015-01-01
104 2016-09-09
;
run;

data Clinical.mtm3;
merge Clinical.mtm1 Clinical.mtm2;
by pt;
run;
/*infile statement*/
data Clinical.infile;
infile"C:\Users\vimal\Desktop\dm.txt" dsd;
input id gender$ age country$;
run;
/*n function*/
data Clinical.n;
a=12;
b=112;
c=.;
d=11;
p=n(a,b,c,d,);
run;
/*nmiss function*/
data Clinical.n1;
a=23;
b=21;
c=13;
d=11;
e=.;
k=nmiss(a,b,c,d,e);
run;
/*mean*/
data Clinical.mean;
input id loan1 loan2 loan3 loan4;
datalines;
101 100 200 150 200
102 300 400 211 200
103 200 300 200 200
;
run;
data Clinical.mean1;
set Clinical.mean;
avg_loan= mean(loan1,loan2,loan3,loan4);
run;
/*length function length=leading&actual lengthc=both led &trail */
data Clinical.length;
x="  abc  ";
l=length(x);
/*n=lengthn(x);*/
/*c=lengthc(x);*/
/*m=lengthm(x);*/
run;
/*today*/
data Clinical.today;
t=today();
format t yymmdd10.;
run;
/*date*/
data Clinical.date;
d=date();
format d date9.;
run;

/*datetime*/
data Clinical.dt;
t=datetime();
format t is8601dt.;
run;
/*months*/
data Clinical.mon;
a="12sep2008"d;
format a yymmdd10.;
p=month(a);
run;
/*week*/
data Clinical.week;
a="12dec2015"d;
format a date9.;
w=week(a);
run;
/*weekday*/
data Clinical.w;
a="12mar2018"d;
format a date9.;
w1=weekday(a);
run;

data Clinical.t;
a="12:30:40"t;
format a time 8.;
t=time();
run;

/*INTCK*/
data Clinical.int;
input id dob date9.;
format dob yymmdd10.;
datalines;
101 12mar1998
102 10aug1986
103 13feb1990
;
run;

data Clinical.int1;
set Clinical.int;
x=today();
format x yymmdd10.;
AGE=intck("years",dob,x);
run;
data Clinical.int2;
set Clinical.int;
x=today();
format x yymmdd10.;
month1=intck("months",dob,x);
run;
/*Character functions*/
/*upcase*/
data Clinical.up;
a="nilay";
b=upcase(a);
run;
data Clinical.Class1;
set sashelp.class;
name=upcase(name);
run;
/*lowcase*/
data Clinical.low;
b="VIMAL";
l=lowcase(b);
run;
data Clinical.Class;
set sashelp.class;
name=lowcase(name);
run;
/*propcase*/
data Clinical.prop;
t="my name is vimal";
p=propcase(t);
run;
data Clinical.Class2;
set sashelp.class;
name=propcase(name);
run;
/*concatinating/combinig variable*/
/*cat without removig leading and trail*/
data Clinical.cat;
a="my name is    ";
b="     Vimal";
c=cat(a,b);
put c;
run;
/*concatenate variable*/
data Clinical.cat1;
a="my name is    ";
b="     Vimal";
c=a||b;
run;
/*catt remove trailing spaces*/
data Clinical.cat2;
a="my name is    ";
b="Vimal";
c=catt(a,b);
run;

/*cats remove both leading and trailing*/
data Clinical.cat3;
a="my name is    ";
b="     Vimal";
c=cats(a,b);
run;
/*catx remove leading trailing insert special character*/
data Clinical.catx1;
a="my name is    ";
b="     Vimal";
c=catx("$",a,b);
run;
data Clinical.catx2;
a="vimal";
b="sejal";
c="mrudang";
d=catx("-",a,b,c);
run;


/*strip function*/
data Clinical.strp;
a="          rama  ";
x=strip(a);
run;
data Clinical.strp1;
set sashelp.Class;
d= strip(Age)||strip(Height)||strip(weight);
run;
/*trim to creat the space bet obs, trailing space*/
data Clinical.trim;
x=" ";
y="sa"||trim(x)||"ra";
z="vimal"||trim(x)||"pansara";
run;
/*trimn to remove the space bet obs*/
data Clinical.trim1;
set Clinical.trim;
y="sa"||trimn(x)||"ra";
z="vimal"||trimn(x)||"pansara";
run;
/*compress= it compress bet the stream and variable*/
data Clinical.com;
e="12 we    rt    yyy    uh eee";
d=compress(e);
run;
data Clinical.compr;
set sashelp.Class;
/*final1=Sex||Age||Height;*/
final=compress(Sex||"-"||Age||"-"||Height);
run;
/*compbl  to compressing multiple blank*/
data Clinical.compbl;
s="dd  ggg     jj    h   qq    www";
d=compbl(s);
run;
/*Reverse*/
data Clinical.rev;
set sashelp.Class;
s=reverse(Name);
run;

/*proc contents data=sashelp.Class short;*/
/*run;*/

/*Scan select perticular word*/
data Clinical.scan;
A="My name is Vimal";
b=scan(A,4);
run;

/*proc means data=sashelp.Class;*/
/*var age;*/
/*run;*/

/*substr*/
/*syntax substr(var,startposition,lenghth)*/
data Clinical.sub;
D="I am Vimalkumar pansara";
p=substr(D,6,5);
/*substr(D,6,5)="gffgh";*/
run;

data Clinical.subr;
D="IamVimalku";
p=substr(D,7);
run;
/*find search position of substring*/
data Clinical.russ;
country="Italy,Russia,ireland";
found=find(country,"R");
run;
data Clinical.flights;
length city$ 10.;
destination="CPH";
select(destination);
when('LHR')city='LONDON';
when('CPH')city='Copenhagen';
otherwise city='Other';
end;
run;


/*translate(var,"replacement","target")*/
data Clinical.Tlate;
t="vimal";
p=translate(t,"V","m");
r="Ahmedabad";
e=translate(r,"hd","Ah");
run;

/*tranwrd(var,"target", "replacement")*/
data Clinical.tran;
d="Pansara";
f=tranwrd(d,"Pansara","Vimal");
r=tranwrd(d,"Pansara","pan");
run;

/*index number(position of specific letter of word*/
data Clinical.ind;
i="ff gg hh ww rt yu io";
f=index(i,"t");
g=index(i,"rt");
run;

/*left*/
data Clinical.lft;
x="       abc";
y=left(x);
run;

data Clinical.lft1;
a="     Srinivasararao";
x=length(a);
y=strip(a);
run;


/*_n_ to select perticular no of obs*/
data Clinical._n_;
set sashelp.Class;
if _n_ in(3,6,7);
run;









/*proc mean*/
proc means data=sashelp.Class; 
output out=Clinical.cm;
run;


/*proc freq*/
data Clinical.freq;
input id Gender$ trt$;
datalines;
101 Male druga 
102 Male druga
103 Female drugb
104 Male druga
105 Female drugb
106 Male druga
107 Male drugb
108 Female druga
109 Male druga
110 Male drugb
;
run;

proc freq data=Clinical.freq;
run;
proc freq data=Clinical.freq;
tables trt*gender;
run;
proc freq data=Clinical.freq;
tables gender*trt/out=Clinical.freq1;
run;

proc sort data=Clinical.freq1 out=Clinical.freq2;
by gender;
run;
proc transpose data=Clinical.freq2 out=Clinical.freq3;
by gender;
id trt;
run;


/*to find p value we use proc freq fisher formula*/
/*proc freq data=cd;*/
/*by catc;*/
/*tables var1*var2/fisher expected outpct out=newdataset;*/
/*output out= pvalue_chi chisq fisher;*/
/*run;*/
       

/*left join*/
data Clinical.j1;
input pt age;
datalines;
101 23
102 45
103 28
104 56
105 32
;
run;
data Clinical.j2;
input pt: country$:;
datalines;
101 uk
102 uk
103 uk
105 uk
106 uk
;
run;
/*left join*/
data Clinical.lm;
merge Clinical.j1(in=a) Clinical.j2(in=b);
by pt;
if a;
run;

/*right join*/
data Clinical.rj;
merge Clinical.j1(in=a) Clinical.j2(in=b);
by pt;
if b;
run;

/*inner join*/
data Clinical.ij;
merge Clinical.j1(in=a) Clinical.j2(in=b);
by pt;
if a and b;
run;

data Clinical.oj;
merge Clinical.j1(in=a) Clinical.j2(in=b);
by pt;
if a or b;
run;

/*colun*/
data Clinical.co;
input id: Name$:18. age:;
datalines;
101 srinivasararao 23
102 sara 30
103 padma 40
104 ramakrishna 50
;
run;

data Clinical.co;
input id: Name$:18. age:;
datalines;
101 srinivasararao 23
102 sara 30
103 padma 40
104 ramakrishna 50
;
run;

data Clinical.co;
input id: Name$:18. age:;
datalines;
101 srinivasararao 23
102 sara 30
103 padma 40
104 ramakrishna 50
;
run;

data Clinical.co1(label col1="Columnname");
input id  Name$ age @@;
datalines;
101 srini 23 102 sara 45 103 kalpana 67
;
run;


data Clinical.puz;
input x$ y$ z$ r$ g$;
datalines;
a b c d e
dd ff rr tt gg 
a b c e f
;
run;
data Clinical.pu1;
set Clinical.puz;
if x="a" and y="b" and z="c";
/*where x="a" and y="b";*/
/*where same and z="c";*/
run;
data Clinical.pu2;
set Clinical.puz;
where x="a" and y="b";
where same and z="c";
run;
data Clinical.ram;
x="ram ram tre ram";
run;
data Clinical.ram1(replace=no);
set Clinical.ram;
y=substr(x,1,12);
s="sss";
z=catx(" ",y,s);
run;
/*quote  to insert quotation of obs*/

data Clinical.quote;
set sashelp.Class;
x=quote(Name);
y=dequote(Name);
run;
/*if*/
data Clinical.if1;
set sashelp.Class;
if Sex eq "F";
if Age>=12;
if Age<16;
run;

data Clinical.if2;
set sashelp.Class;
if Sex="M" then Gender="Male  ";
if Sex="F" then Gender="Female";
run;
data Clinical.if3;
set sashelp.Class;
if Sex="M" then Gender="Male  ";
else Gender="Female";
run;

data Clinical.team;
input id team$ country$ gender$ age;
datalines;
101 red uk M 12
102 blue uk F 23
103 red uk M 35
104 green uk M 32
105 red uk M 35
106 blue uk F 11
107 red uk M 11
108 green uk M 45
run;
data Clinical.team1;
set Clinical.team;
if team="red" then teamn=1;
else if team="blue" then teamn=2;
else teamn=3;
run;

/*And operator*/
data Clinical.team2;
set Clinical.team;
if gender="M" and team="green" and age>25;
run;
/*or operator*/
data Clinical.team3;
set Clinical.team;
if gender="M" or team="green" or age>25;
run;
data Clinical.sweet;
input sweet$ weekdays$ count;
datalines;
kaju monday 10
kaju tuesday 20
kaju wednesday 10
kaju thursday 10
kaju friday 30
kaju saturday 10
kaju sunday 10
laddu monday 10
laddu tuesday 20
laddu wednesday 10
laddu thursday 20
laddu friday 10
laddu saturday 20
laddu sunday 10
kova monday 10
kova tuesday 20
kova wednesday 10
kova thursday 20 
kova friday 20 
kova saturday 10
kova sunday 10
;
run;
proc sort data=Clinical.sweet out=Clinical.s;
by sweet;
run;
data Clinical.sweet1;
set Clinical.s;
by sweet;
retain total;
if first.sweet then total=0;
total+count;
if last.sweet then output;
run;


