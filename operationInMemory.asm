link l1:ct
link l2:rdm
 
equ cs:r8
equ ip:r9
 
equ pom1: r2
equ pom2: r3
equ pom3: r4
equ pom4: r5
equ pom5: r6
equ pom6: r7
 
accept cs:ABCDh
accept ip:1234h

dw ACF04h:5678h	\\	ACF04 ABCD
dw BF125h:9ABCh	\\	BF125 BCDE
dw D1346h:789Ah 	\\	D1346 CDEF
macro mov reg1, reg2:{or reg1, reg2, z;}
 
{LOAD rm, z;}
  
{mov cs, ABCDh;}
{mov ip, 1234h;}
{mov pom1, cs;}
{cjs nz, obliczadr;}
{mov nil, pom1; oey; ewl;}
{mov nil, pom2; oey;ewh;}
{R; mov pom4, bus_d; cjp rdm, cp;}
 
{mov cs, BCDEh;}
{mov ip, 2345h;}
{mov pom1, cs;}
{cjs nz, obliczadr;}
{mov nil, pom1; oey; ewl;}
{mov nil, pom2; oey;ewh;}
{R; mov pom5, bus_d; cjp rdm, cp;}
 
{mov cs, CDEFh;}
{mov ip, 3456h;}
{mov pom1, cs;}
{cjs nz, obliczadr;}
{mov nil, pom1; oey; ewl;}
{mov nil, pom2; oey;ewh;}
{R; mov pom6, bus_d; cjp rdm, cp;} 
 

{mov cs, ABCDh;}
{mov ip, 1234h;}
{mov pom1, cs;}
{cjs nz, obliczadr;}
{mov nil, pom1; oey; ewl;}
{mov nil, pom2; oey;ewh;}
{W; mov nil, pom6; oey; cjp rdm, cp;}
 
{mov cs, BCDEh;}
{mov ip, 2345h;}
{mov pom1, cs;}
{cjs nz, obliczadr;}
{mov nil, pom1; oey; ewl;}
{mov nil, pom2; oey;ewh;}
{W; mov nil, pom4; oey; cjp rdm, cp;}

{mov cs, CDEFh;}
{mov ip, 3456h;}
{mov pom1, cs;}
{cjs nz, obliczadr;}
{mov nil, pom1; oey; ewl;}
{mov nil, pom2; oey;ewh;}
{W; mov nil, pom5; oey; cjp rdm, cp;}


{end;}
 
obliczadr{load rm,z;}

{load rm, z;}				\\ zerowanie rejestru znacznikow
{xor pom2, pom2, pom2;}		\\ zerowanie pom2
{mov pom1, cs;}				\\ z cs kopiuj do pom1
{mov rq, ip;}
{push nz,3;}				\\ petla 4 razy
{sll pom1;}					\\ przesuniecie w lewo o 1 bit
{sl.25 pom2;}				\\ zgranie z rm do pom2 i przesuniecie 0 1 bit w lewo pom2, wykonaj 4 razy, aby przesun
{rfct;}						\\ koniec petli
{add pom1, pom1, rq,z;load rm,flags;}	\\ dodanie do pom1 pom1 + rq i zapoamietaj q pom1
{add pom2,pom2,z,rm_c;}					\\ 
{crtn nz;}	
\\{mov pom1, cs;}				\\ z cs kopiuj do pom1
\\{mov rq, ip;}
 
 