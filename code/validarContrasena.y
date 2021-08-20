%{
    #include <stdio.h>
    #include <stdlib.h>
    extern int yylex(void);
    extern FILE *yyin;
    void yyerror(char *s);
    void result(void);
    void resetValues(void);
    void endTask(void);

    int error = 0;
    int len = 0;
    int consecutive = 0;
    int invalidchart = 0;
    int lowercase = 0;
    int uppercase = 0;
    int specialChart = 0;
    int number = 0;
%}

%token INVALIDCHART INVALID2BYTESCHART CONSECUTIVEUPPER CONSECUTIVELOWER CONSECUTIVENUMBER CONSECUTIVESPECIAL SPECIALCHART UPPERCASE LOWERCASE NUMBER END

%start contrasenas

%%

contrasenas: contrasenas contrasena
           | contrasena
;
                             
contrasena: END {endTask();}
          | error END {yyerrok;}
          | cadena END
;
cadena: consecutivos { error++; len+=4; consecutive++;} cadena
        | caracter cadena
        | epsilon {result(); resetValues();}
;

consecutivos: CONSECUTIVEUPPER {uppercase+=4;}
            | CONSECUTIVELOWER {lowercase+=4;}
            | CONSECUTIVENUMBER {number+=4;}
            | CONSECUTIVESPECIAL {specialChart+=4;}
;


caracter: INVALID2BYTESCHART {error++; len++; invalidchart++;} // Está para contar como un solo caracter a aquellos que son compuestos
        | INVALIDCHART {error++; len++; invalidchart++;}
        | UPPERCASE {len++; uppercase++;}
        | LOWERCASE {len++; lowercase++;}
        | NUMBER {len++; number++;}
        | SPECIALCHART {len++; specialChart++;}

epsilon: /*Tú imaginate que aquí hay un epsilon xd*/;
;
%%


int main(int argc, char **argv){
    printf("INGRESE UNA CONTRASENA: ");
    if (argc>1)
        yyin = fopen(argv[1],"r");
    else
        yyin = stdin;

    yyparse();
}


void resetValues (){
    error = 0;
    len = 0;
    consecutive = 0;
    invalidchart = 0;
    lowercase = 0;
    uppercase = 0;
    specialChart = 0;
    number = 0;
}
void result(){

    if(len < 8 || len > 16 || !lowercase || !uppercase || !specialChart || !number)
        error++;
    
    if (error){
        printf("\n Contraseña Inválida, con los siguentes errores:\n");
    

        if(len < 8)
            printf("    Caracteres Insuficientes. Usted posee %d y el minimo son 8\n", len);error++;
        
        if(len > 16)
            printf("    Se supero el limite de caracteres. Usted posee %d y el maximo son 16\n", len);

        if (!lowercase)
            printf("    Debe existir al menos una minuscula.\n");
        
        if (!uppercase)
            printf("    Debe existir al menos una mayuscula.\n");

        if (!number)
            printf("    Debe existir al menos un numero.\n");
        
        if (!specialChart)
            printf("    Debe existir al menos un caracter especial.\n");
            
        if(consecutive)
            printf("    Hay al menos un caracter que se repite mas de tres veces consecutivas.\n");

        if(invalidchart)
            printf("    Hay %d Caracteres invalidos.\n", invalidchart);
        
        printf("\n");
    
    }else
        printf("\nContrasena valida.\n\n");
    
    printf("INGRESE UNA CONTRASENA: ");
}

void yyerror(char *s) {
    printf("\n\n\nFIN\n\n");
}

void endTask(){
    printf("\n\n");
    printf("******************\n");
    printf("*FIN DEL PROGRAMA*");
    printf("\n******************"); 
    printf("\n\n");
    exit(1);
}