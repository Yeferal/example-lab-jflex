
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
%class AnalizadorLexico2
%unicode
%line
%column
%standalone

// Expresiones Regulares
ENTERO = [0-9]+
DECIMAL= {ENTERO}"."{ENTERO}
LETRA = [a-zA-z]+
ESPACIOS = [" "\r\t\b\n]

// YYINITIAL -> estado por defecto
%state HTML
%state CSS
%state JS
%state PROPIEDADES
%state COMENTARIO

%%
// Reglas de Escaneo de Expresiones

<YYINITIAL> {
    "[js]"          { yybegin(JS); System.out.println("CAMBIO A: jS" + yytext());}
    "[html]"        { yybegin(HTML); System.out.println("CAMBIO A: html" + yytext());}
    "[css]"         { yybegin(CSS); System.out.println("CAMBIO A: CSS" + yytext());}
}

<HTML> {
    "<header"             {yybegin(PROPIEDADES); System.out.println(yytext());}
    "<div"             {yybegin(PROPIEDADES); System.out.println(yytext());}
    "<a"             {yybegin(PROPIEDADES); System.out.println(yytext());}
    "[js]"          { yybegin(JS); System.out.println("CAMBIO A: JS" + yytext());}
    "[html]"        { yybegin(HTML); System.out.println("CAMBIO A: HTML" + yytext());}
    "[css]"         { yybegin(CSS); System.out.println("CAMBIO A: CSS" + yytext());}
}

<PROPIEDADES> {
    "class"         {System.out.println(yytext());}
    "id"         {System.out.println(yytext());}
    "name"         {System.out.println(yytext());}
    ">"             {yybegin(HTML); System.out.println(yytext());}
}

<CSS> {
    "#"[a-zA-Z]*          {System.out.println("CSS" + yytext());}
    "."[a-zA-Z]*          {System.out.println("CSS" + yytext());}
    "/*"                  { yybegin(COMENTARIO); System.out.println("CAMBIO A COMENTARIO" + yytext());}
    "[js]"          { yybegin(JS); System.out.println("CAMBIO A: JS" + yytext());}
    "[html]"        { yybegin(HTML); System.out.println("CAMBIO A: HTML" + yytext());}
    "[css]"         { yybegin(CSS); System.out.println("CAMBIO A: CSS" + yytext());}
}

<JS> {
    "for"
    {ENTERO}
    {DECIMAL}
    "[js]"          { yybegin(JS); System.out.println("CAMBIO A: JS" + yytext());}
    "[html]"        { yybegin(HTML); System.out.println("CAMBIO A: HTML" + yytext());}
    "[css]"         { yybegin(CSS); System.out.println("CAMBIO A: CSS" + yytext());}
}

<COMENTARIO> {
    "*/"                { yybegin(CSS); System.out.println("CAMBIO A CSS" + yytext());}
    "\n"                { yybegin(CSS); System.out.println("CAMBIO A CSS" + yytext());}
    .                   {System.out.println("parte comentario:" + yytext());}
}

