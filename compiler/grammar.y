%code requires{
        #include <string>
}
%{
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <string>
//#include "SyntaxTree/Includes.hpp"
#include <memory>
//std::unique_ptr<compiler::SyntaxTree> root;
using namespace std;
std::string result;
int yylex(void);
void yyerror(char const *);
extern char *yytext;
%}


%define api.value.type { std::string }


%token  NAME COLON RIGHT_ARROW LEFT_CURLY_BRACE RIGHT_CURLY_BRACE SEMICOLON LEFT_PARENTHESIS RIGHT_PARENTHESIS SINGLECOMMENT
        MULTILINECOMMENT SHOW QUOTES CHARACTERS_BLOCK INT INTEGER_VALUE DECIMAL_VALUE LOAD STDIN DOLLAR_SIGN INC DEC DECI BLN SET TRU FLS ITOB QUESTION_MARK
        L_BRACKET R_BRACKET EQ LE LT GT GE NE ELSE COMA STR DOBLE_COLON WHILE ANSWER ADD DOBLE_SLASH LES SLASH SHOWL


%start input

%%

input:
        function function_list  { result = std::string("#include <cstdio>\n #include <iostream>\n using namespace std;\n") + $1 + $2;
        }
        ;


function_list:
        function function_list                  { $$ = $1 + $2; }
        |
        %empty                                  { $$ = ""; }
        ;


function:
        name DOBLE_COLON L_BRACKET R_BRACKET RIGHT_ARROW L_BRACKET INT R_BRACKET COLON LEFT_CURLY_BRACE statements ANSWER RIGHT_CURLY_BRACE
        {
                if($1 == "main"){
                        $$ = "int main(int argc, char *argv[]){\n" + $11 + "\n}\n";
                }else{
                        $$ = std::string("\n void ") + "_" + $1 + "()" + "{\n" + $11 + "\n}\n";
                }
        }
        |
        %empty                                  { $$ = ""; }
        ;


statements:
        statements statement {
                                $$ = $1 + $2;
                                }
        |
        %empty                                  { $$ = ""; }
         ;


statement:
        bifurcation { $$ = $1; }
        |
        loop { $$ = $1; }
        |
        assignment SEMICOLON { $$ = $1; }
        |
        unitaryOperations SEMICOLON { $$ = $1; }
        |
        std_input SEMICOLON { $$ = $1; }
        |
        definition SEMICOLON { $$ = $1; }
        |
        std_output SEMICOLON { $$ = $1; }
        |
        MULTILINECOMMENT        { $$ = ""; }
        |
        SINGLECOMMENT   { $$ = ""; }
         |
        expression SEMICOLON { $$ = $1; }
        ;


bifurcation:

        L_BRACKET logical_eval R_BRACKET QUESTION_MARK statement { $$ = "if(" + $2 + "){\n" + $5 + "}\n"; }
        |
        L_BRACKET logical_eval R_BRACKET QUESTION_MARK LEFT_CURLY_BRACE statements RIGHT_CURLY_BRACE { $$ = "if(" + $2 + "){\n" + $6 + "}\n"; }
        |
        ELSE LEFT_CURLY_BRACE statements RIGHT_CURLY_BRACE { $$ = "else{\n" + $3 + "\n}\n";}
        |
        L_BRACKET logical_eval R_BRACKET ELSE QUESTION_MARK LEFT_CURLY_BRACE statements RIGHT_CURLY_BRACE { $$ = "else if(" + $2 + "){\n" + $7 + "}\n"; }
        ;


loop:
        L_BRACKET name COLON DOLLAR_SIGN name DOBLE_SLASH DOLLAR_SIGN name comp_operator integer_value DOBLE_SLASH name COLON DOLLAR_SIGN name LES integer_value R_BRACKET WHILE LEFT_CURLY_BRACE
        statements RIGHT_CURLY_BRACE
        { $$ = "for(int " + $2 + "=" + $5 +  ";" + $8 + $9 + $10 + ";" + $12 + "=" + $15 + "-" + $17 + "){\n" + $21 + "}\n"; }
        |
        L_BRACKET logical_eval R_BRACKET WHILE LEFT_CURLY_BRACE statements RIGHT_CURLY_BRACE
        { $$ = "while(" + $2 + "){\n" + $6 +"}\n"; }
        |
        L_BRACKET name COLON integer_value DOBLE_SLASH DOLLAR_SIGN name comp_operator integer_value DOBLE_SLASH name COLON DOLLAR_SIGN name ADD integer_value R_BRACKET WHILE LEFT_CURLY_BRACE
        statements RIGHT_CURLY_BRACE
        {$$ = "for(int " + $2 + "=" + $4 +  ";" + $7 + $8 + $9 +";" + $11 + "=" + $14 + "+" + $16 + "){\n" + $20 + "}\n"; }
        |
        L_BRACKET name COLON integer_value DOBLE_SLASH DOLLAR_SIGN name comp_operator integer_value DOBLE_SLASH name COLON DOLLAR_SIGN name LES integer_value R_BRACKET WHILE LEFT_CURLY_BRACE
        statements RIGHT_CURLY_BRACE
        {$$ = "for(int " + $2 + "=" + $4 +  ";" + $7 + $8 + $9 +";" + $11 + "=" + $14 + "-" + $16 + "){\n" + $20 + "}\n"; }
        |
        L_BRACKET name COLON integer_value DOBLE_SLASH DOLLAR_SIGN name comp_operator DOLLAR_SIGN name DOBLE_SLASH name COLON DOLLAR_SIGN name ADD integer_value R_BRACKET WHILE LEFT_CURLY_BRACE
        statements RIGHT_CURLY_BRACE
        {$$ = "for(int " + $2 + "=" + $4 +  ";" + $7 + $8 + $10 +";" + $12 + "=" + $15 + "+" + $17 + "){\n" + $21 + "}\n"; }
        |
        L_BRACKET name COLON integer_value DOBLE_SLASH DOLLAR_SIGN name comp_operator DOLLAR_SIGN name DOBLE_SLASH name COLON DOLLAR_SIGN name LES integer_value R_BRACKET WHILE LEFT_CURLY_BRACE
        statements RIGHT_CURLY_BRACE
        {$$ = "for(int " + $2 + "=" + $4 +  ";" + $7 + $8 + $10 +";" + $12 + "=" + $15 + "-" + $17 + "){\n" + $21 + "}\n"; }
        |
        L_BRACKET name COLON DOLLAR_SIGN name DOBLE_SLASH DOLLAR_SIGN name comp_operator integer_value DOBLE_SLASH name COLON DOLLAR_SIGN name ADD integer_value R_BRACKET WHILE LEFT_CURLY_BRACE
        statements RIGHT_CURLY_BRACE
        { $$ = "for(int " + $2 + "=" + $5 +  ";" + $8 + $9 + $10 + ";" + $12 + "=" + $15 + "+" + $17 + "){\n" + $21 + "}\n"; }
        ;


logical_eval:

        DOLLAR_SIGN name L_BRACKET DOLLAR_SIGN name R_BRACKET comp_operator DOLLAR_SIGN name
        { $$ = $2 + "[" + $5 + "]" + $7 + $9; }
        |
        DOLLAR_SIGN name L_BRACKET DOLLAR_SIGN name R_BRACKET comp_operator DOLLAR_SIGN name L_BRACKET DOLLAR_SIGN name R_BRACKET
        { $$ = $2 + "[" + $5 + "]" + $7 + $9 + "[" + $12 + "]"; }
        |
        DOLLAR_SIGN name comp_operator integer_value { $$ = $2 + $3 + $4; }
        |
        integer_value comp_operator integer_value { $$ = $1 + $2 + $3; }
        |
        DOLLAR_SIGN name comp_operator DOLLAR_SIGN name { $$ = $2 + $3 + $5; }
        ;


std_input:
        LOAD COLON name { $$ = "\t std::cin >> " + $3 + ";\n"; }
        ;


unitaryOperations:
        INC identifiers { $$ = $2 + "++;\n";}
        |
        DEC identifiers { $$ = $2 + "--;\n";}
        ;


comp_operator:
        EQ      { $$ = "=="; }
        |
        LE      { $$ = "<="; }
        |
        LT      { $$ = "<"; }
        |
        GT      { $$ = ">"; }
        |
        GE      { $$ = ">="; }
        |
        NE      { $$ = "!="; }
        ;


assignment:
        name COLON DOLLAR_SIGN name SLASH decimal_value { $$ = $1 + "=" + "(float)" + $4 + "/" + $6 + ";\n"; }
        |
        name COLON L_BRACKET integer_value COMA integer_value R_BRACKET { $$ = $1 + "[" + $4 + "]" + "=" + $6 + ";\n"; }
        |
        name COLON L_BRACKET DOLLAR_SIGN name COMA DOLLAR_SIGN name R_BRACKET { $$ = $1 + "[" + $5 + "]" + "=" + $8 + ";\n"; }
        |
        name COLON L_BRACKET integer_value COMA DOLLAR_SIGN name R_BRACKET { $$ = $1 + "[" + $4 + "]" + "=" + $7 + ";\n"; }
        |
        name COLON L_BRACKET DOLLAR_SIGN name COMA integer_value R_BRACKET { $$ = $1 + "[" + $5 + "]" + "=" + $7 + ";\n"; }
        |
        name COLON DOLLAR_SIGN name L_BRACKET integer_value R_BRACKET { $$ = $1 + "=" + $4 + "[" + $6 + "]" + ";\n"; }
        |
        name COLON DOLLAR_SIGN name L_BRACKET DOLLAR_SIGN ids R_BRACKET { $$ = $1 + "=" + $4 + "[" + $7 + "]" + ";\n"; }
        |
        name L_BRACKET DOLLAR_SIGN name R_BRACKET COLON DOLLAR_SIGN name L_BRACKET DOLLAR_SIGN name R_BRACKET
        { $$ = $1 + "[" + $4 + "]" + "=" + $8 + "[" + $11 + "]" + ";\n"; }
        |
        name L_BRACKET DOLLAR_SIGN name R_BRACKET COLON DOLLAR_SIGN name
        { $$ = $1 + "[" + $4 + "]" + "=" + $8 + ";\n"; }
        |
        name L_BRACKET DOLLAR_SIGN name R_BRACKET COLON integer_value
        { $$ = $1 + "[" + $4 + "]" + "=" + $7 + ";\n"; }
        |
        name L_BRACKET DOLLAR_SIGN name R_BRACKET INC integer_value
        { $$ = $1 + "[" + $4 + "]" + "+=" + $7 + ";\n"; }
        |
        name INC DOLLAR_SIGN name L_BRACKET DOLLAR_SIGN name R_BRACKET
        { $$ = $1 + "+=" + $4 + "[" + $7 + "]" + ";\n"; }
        |
        name COLON FLS  { $$ = $1 + "=false; \n"; }
        |
        name COLON TRU  { $$ = $1 + "=true; \n"; }
        |
        name COLON integer_value { $$ = $1 + "=" + $3 + ";\n";}
        |
        name COLON decimal_value { $$ = $1 + "=" + $3 + ";\n";}
        |
        name COLON characters_block {$$ = $1 + "=" + $3 + ";\n";}
        |
        name INC integer_value { $$ = $1 + "+=" + $3 + ";\n";}
        |
        name DEC integer_value { $$ = $1 + "-=" + $3 + ";\n";}
        |
        name COLON DOLLAR_SIGN name { $$ = $1 + "=" + $4 + ";\n";}
        |
        name COLON DOLLAR_SIGN name ADD integer_value { $$ = $1 + "=" + $4 + "+" + $6 + ";\n";}
        |
        name COLON DOLLAR_SIGN name LES integer_value { $$ = $1 + "=" + $4 + "-" + $6 + ";\n";}
        ;


integer_value:
        INTEGER_VALUE { $$ = std::string(yytext); }
        ;


decimal_value:
        DECIMAL_VALUE { $$ = std::string(yytext); }
        ;


definition:
        name COLON INT L_BRACKET integer_value R_BRACKET {

                $$ = "int " + $1 + "[" + $5 + "];\n";

        }
        |
        name COLON INT L_BRACKET DOLLAR_SIGN ids R_BRACKET {

                $$ = "int " + $1 + "[" + $6 + "];\n";}
        |
        name DOBLE_COLON BLN { $$ = "\t bool " + $1 + ";\n"; }
        |
        name DOBLE_COLON INT { $$ = "\t int " + $1 + ";\n"; }
        |
        ids COMA ids COMA ids COLON INT { $$ = "\t int " + $1 + "," + $3 + "," + $5 + ";\n"; }
        |
        name DOBLE_COLON STR { $$ = "\t string " + $1 + ";\n";}
        |
        name DOBLE_COLON DECI { $$ = "\t float " + $1 + ";\n";}
        ;


identifiers:
        identifiers ids { $$ = $1 + $2; }
        |
        %empty  { $$ = ""; }
        ;


ids:
        name    { $$ = $1; }
        ;


std_output:
	SHOWL COLON characters_block	{ $$ = "std::cout << " + $3 + ";"; }
	|
        SHOW COLON ITOB DOLLAR_SIGN name { $$ = "std::cout << ((" + $5 + "==1) ? \"true\" : \"false\") << std::endl;";}
        |
        SHOW COLON characters_block     { $$ = "std::cout << " + $3 + " << std::endl;\n"; }
        |
        SHOW COLON DOLLAR_SIGN name     { $$ = "std::cout << " + $4 + " << std::endl;"; }
        |
        SHOW COLON characters_block COMA DOLLAR_SIGN name { $$ = "std::cout << " + $3 + " << " + $6 + " << std::endl;"; }
        |
        SHOW COLON characters_block COMA DOLLAR_SIGN name COMA characters_block{ $$ = "std::cout << " + $3 + " << " + $6 + " << " + $8 + " << std::endl;"; }
        |
        SHOW COLON DOLLAR_SIGN ids COMA integer_value { $$ = "std::cout << " + $4 + "[" + $6 + "]  << std::endl;\n"; }
        |
        SHOW COLON DOLLAR_SIGN ids COMA DOLLAR_SIGN ids { $$ = "std::cout << " + $4 + "[" + $7 + "]  << std::endl;\n"; }
        ;


expression:
        name LEFT_PARENTHESIS RIGHT_PARENTHESIS { $$ = std::string("\t _") + $1 + "();\n"; }
        ;


characters_block:
        CHARACTERS_BLOCK { $$ = std::string(yytext); }
        ;


name:
        NAME    {
                        $$ = std::string(yytext);
                }
        ;


%%


void yyerror (char const *x){
        printf ("Error %s \n", x);
        exit(1);
}
