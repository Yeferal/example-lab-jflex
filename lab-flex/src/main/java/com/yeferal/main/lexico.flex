package com.yeferal.main;

//Seccion de imports
import java.util.ArrayList;
import java.util.List;

%%
%{

// Codigo Java

    private List<String> lista = new ArrayList<>();
    private List<String> listaErrores = new ArrayList<>();

    public void addList(String token) {
        lista.add(token);
    }

    public void addListaErrores(String token) {
        lista.add(token);
    }

    public List<String> getLista(){
        return lista;
    }
    
    public List<String> getListaErrores(){
        return listaErrores;
    }

%}

// Configuracion
%public
%class AnalizadorLexico
%unicode
%line
%column
%standalone

// Expresiones Regulares
ENTERO = [0-9]+
LETRA = [a-zA-z]+
ESPACIOS = [" "\r\t\b\n]


%%
// Reglas de Escaneo de Expresiones
({ENTERO}{LETRA} | {LETRA}{ENTERO})         { addList(yytext()); }
(\"[^\"]*\")                                { System.out.println("CADENA: "+yytext()); addList(yytext()); }
"+"                                         { System.out.println("TOKEN: "+yytext()); addList(yytext()); }
"-"                                         { System.out.println("TOKEN: "+yytext()); addList(yytext()); }
"="                                         { System.out.println("TOKEN: "+yytext()); addList(yytext()); }
{ENTERO}                                    { System.out.println("ENTERO: " + yytext()); addList(yytext()); }
{ENTERO}"."{ENTERO}                         { System.out.println("DECIMAL: " + yytext()); addList(yytext()); }

{ESPACIOS}                                  { /*Ignore*/ }

.                                           { System.out.println("Error:"+yytext());
                                            addListaErrores("ERROR>> Linea: "+yyline + ", columna: "+ yycolumn+", Token -> "+yytext()); }



