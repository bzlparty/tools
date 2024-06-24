/* removes comments from INPUT files to be used for LAHET Code Series */
/* Jeffrey V. Siebers (JVS)
   !! Use at Your Own Risk !!
   !! The author is NOT responsible for any damage done by this software !!

   Modification History:
   22-September-1992: file created
   05-Nov-1993: change all upper case letters to lower case
        Comments are deliniated by a c in the first column or any information
        following a $ sign.  If you desire to have a $ sign in a line, then you
        must place two $ in a row ($$)
   14-July-1994: Allow Command line arguments
        Ability to INCLUDE other files is introduced
        this allows breaking up of input file into parts
        then putting parts together
   15-July-1994: JVS: fixing bug when type in input filename
   22-Sept-1994: JVS: Remove Tabs from File As Well (actually remove all control chars)
   26-Dec-1995: JVS: Version for SPARC
          -NO io.h
          - Main must return a type
          - function access not exist
          - change strnicmp to strncmp
   16-May-1996: JVS: 1.01: Making #include directive allow a path search for the files
   21-May-1996: JVS: 1.02: Adding the #define directive and allowing
                           Math operators (+-* and /) on input lines
   22-May-1996: JVS: 1.03: Tokens sorted from longest to shortest so not
            replace sub-tokens
   09-Sept-1996: JVS: 1.04: Add #ifdef, #else, #elseif, and #endif directives
                            added.
   10-Sept-1996: JVS: 1.05: Add #echo directive added, fix getenv on unix side.
                            reducing printf's to a small number
   07-Oct-1996: JVS: 1.06: patch #echo so not echo when looking for #endif
   26-October-1996: JVS: 1.07: allow empty string after define value
                               allow command line to define a value with -d flag
                               To have "sub-string" replacement for first token
                               of #define, a minor change needs to be made in
                               process_define (see that routine)
   15-April-1997: JVS: 1.10 Random numbers that start with "C" cause problems.
                            this is due to the fact that they are treated as "comment"
                            fields.  I've been meaning to get around to this.
                           *Change comment fields to obey c++ construct rules
                            (#define OLD_COMMENTS will use the old comment format)
                           *Change LCS_PATH to DC_PATH
                           *Allow nested ifdef's in a file
                           *MSDOS or BORLANDC must be defined for DOS based file
                            systems
                           *Add -l flag to change everything to lower case
                           *Add -u flag to change everything to upper case
                           *Add -v flag to allow to define with a value
                           *Add #error directive (identical to #echo)
                           *Add #elif directive (identical to #elseif)
                           *Add #ifndef directive (similar to #ifdef)
                           *Add #undef directive 
   13-August-1997: JVS: 1.11 bug from strcpy(argv[j],argv[j+i]) in get_option routines 
                            corrected by direct pointer assignment. get_option would not
                            work correctly if the lenght of the strings for the flags
                            increased.
   17-Nov-1997: JVS: 1.12: Allow lines starting that begin with # but are
                           not directives to be processed, producing a warning 
   18-Nov-1998: JVS: 1.12a: Allow division in evaluate_token
   06-Mar-1998: JVS: 1.13:*gcc -pedantic and -Wall errors eliminated
                          *Add STR_NULL for terminating strings.  On Linux,
                           gcc gives warnings about
                           warning: assignment to `char' from `void *' lacks a cast
           *eliminate fclose at end of process_file, on Linux, this
                           caused a bomb because the file is already closed in get_string 
   11-May-1998: JVS: 1.13a: *add warning when exceed MAX_STR_LEN for replace_defines
   15-May-1998: JVS: 1.14: Allow keeping of Tabs, add usage and -help (-?)
   19-May-1998: JVS: 1.15: add -z option, change math format to %g (so -z not needed)
   19-May-1998: JVS: 1.16: bug fix: processing #undef when value not previously defined
                           now properly returns error (need to check i before string)
   26-May-1998: JVS: 1.16a: %g (so -z not needed) obtained using gcvt (more precision than sprintf)
   04-June-1998: jvs: 1.16b: remove fgets
Things to be fixed:  I a line is ------------ , it get processed as -
   25-Sept-1998: JVS: 1.17: Bug fix for 11/ on a line not processed.  Last character of is_math 
                            must be a digit.
   12-Jan-2000: JVS/JOK: 1.18: Increase MAX_DEFINE to 256
   09-March-2000: JVS/JOK: 1.20: Add ^, exponentiation....simple to do!!!!!
   22-March-2000: JVS: Check with INSURE, put in fget_cstring
                       fix fget_c_string
                       add #exit directive
   09-Feb-2010: JVS: 1.21 : Change check_for_defined -- make sure strings are the same length
                            so match is not found for strings IAD_TEST and IAD
   18 June 2010: JVS: 1.22: Add #report directive, to report all defined values
                            Add recursiveReplacementSearch so can have multi-level replacements
   22 Feb 2011: JVS: 1.23: EXIT_FAIL if cannot open input file (was exit(0))

*/
// #define DEBUG
#define Revision 1.23
#define MAIN                           // define this as the module that has MAIN in it
const char *Prog_Name = "dcomment";   /* to convert data */
// #define DEBUG 
/* #define MSDOS */ /* use this define when compiling for MSDOS and
                       *want ; seperator between items on DC_PATH
                       *want <cr><lf> to remain on lines */
// #define OLD_COMMENTS /* if want old comment format (c at start of line, $ in middle) */
// #define MSDOS
#ifdef BORLANDC
#define MSDOS
#endif

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h> /* for tolower */
#include <time.h> /* for time_t */
#include <math.h> // for power
#define MAX_STR_LEN 512
#define LOCAL_GLOBAL 0
#define GLOBAL 1
#define OK 1
#define FAIL -1
#define ENDIF_RETURN  -10
#define ELSE_RETURN   -20 /* for else return */
#define ELSEIF_RETURN -30
#define STR_NULL   ((char) 0)
/* #define IFDEF_RETURN  -40*/

#define MAX_TOKENS  256
#define MAX_DEFINED 512             /* max number of #define directives */
#define MAX_TOKEN_LEN MAX_STR_LEN  /* ******************* type definitions    */
#define UPPER_CASE +1 /* for determining if should change case of input string */
#define LOWER_CASE -1
#define DEFINED_ALONE  0
#define DEFINED_VALUE +1
typedef struct{char input[MAX_STR_LEN];
               char output[MAX_TOKEN_LEN];}defined_type;
/* ******************* function prototypes */
int fget_c_string(char *string, int Max_Str_Len, FILE *fspec);
int get_string(FILE *fspec, char *string);
void print_runtime_info(int argc, char *argv[]);
int process_file(char *filename, int mode);
int process_include(char *string);
int process_file_lines(FILE *istr);
int process_line(FILE *ostr, char *string);
int process_define(char *string);
int process_undefine(char *string);
int check_for_defined(char *token);
int process_token_string(char *in_string, char *out_string);
int remove_comments(char *string);
int replace_defines(char *string);
int string_value(char *pstr, double *value);
int evaluate_token(char *pt, char *token_string);
int is_math(char *pstr);
int sort_defined(void);
int process_ifdef(FILE *istr, char *string);
int process_echo(char *string);
int skip_file_lines_till_endif(FILE *istr);
int remove_zeros(char *pstr);
int report_defined(void);
/****************** GLOBAL VARIABLES */
FILE *ostr;          /* Output Stream */
defined_type *defined[MAX_DEFINED];
int ndefined = 0;    /* counter for number of #defined directives */
int change_case = 0; /* for determining if should change the case of the string */
int discard_tabs = 0; /* for determining if should keep tab */
int remove_trailing_zeros = 0; /* for determining if should remove trailing zeros from computed math */
int Sig_Dig = 8; /* Number of (non-zero) significant digits to keep after decimal place in gcvt translation */
/* ****************************************************** */
void usage()
{
   printf("\n Usage: %s input_name output_name",Prog_Name);
   printf("\n\t -v NAME value (to define NAME = value)");
   printf("\n\t -d NAME (to define NAME )");
   printf("\n\t -u (change all to upper case)");
   printf("\n\t -l (change all to lower case)");
   printf("\n\t -ntabs (discard tabs, replace with space)");
   printf("\n\t -z (remove trailing zeros from computed math expressions)");
   printf("\n\t -help, -h (help)");
   printf("\n");
}
/* ********************************************************************** */
char *strnset(char *s, int ch, size_t n)
{  /* mimic strnset command in dos/ os2/ win / ... */
   for(int i=0; i< (int) n; i++)
   {
     if(s[i] == STR_NULL ) return(s); // return when find null
      s[i] = ch;
   }
   return(s);
}
/* ****************************************************** */
int get_defined_option(char *option, int *argc, char *argv[], int type)
{
   /* check for command line option */
   unsigned int olen = strlen(option);
   for(int i=1;i<*argc;i++)
   {
      if(strncmp(argv[i],option,olen) == 0)
      {  /* found option, next token data for the flag */
         /* allocate memory for the flag */
         int n_tokens = 1; /* number of tokens consumed by the flag */
         char tstring[MAX_STR_LEN];
         if(strlen(argv[i]) > olen ) /* no space between flag and name */
         {
            sscanf(argv[i]+olen,"%s",tstring);
            n_tokens = 1;
         }
         else if(i == *argc-1) /* no name for flag given */
         {
            printf("\n ERROR: %s option given without further information",option);
            exit(FAIL);
         }else  /* space between flag and name (flag next token) */
         {
            if(type == DEFINED_ALONE) /* defined without value (-d) */
            {
              /* sscanf(argv[i+1],"%s",tstring); */
              strcpy(tstring,argv[i+1]);
              n_tokens = 2;
            }else if(type == DEFINED_VALUE)/* defined with a value (-v option) */
            {
               if(*argc <= (i+2) )
               {
                  printf("\n ERROR: Defined value -v %s given without a value",argv[i+1]);
                  exit(FAIL);
               }
               strcpy(tstring,argv[i+1]); /* create a simple define line */
               strcat(tstring," ");       /* add a single space between the item and value */
               strcat(tstring,argv[i+2]); /* put the value on the line too */
               n_tokens = 3;
            }
            else
            {
              printf("\n ERROR: type %d is undefined",type);
              exit(-1);
            }


         }
         process_define(tstring);
#ifdef DEBUG
         printf("\n DEBUG: option %s, arguement %s, n_tokens %d\n",option,argv[i+1],n_tokens);
#endif
         /* remove the tokens from the list */
         for(int j=i; j<*argc-n_tokens; j++)
         {
/*            strcpy(argv[j],argv[j+n_tokens]);*/
              *(argv+j)=*(argv+(j+n_tokens));
         }
         *argc-=n_tokens; /* reduce the number of arguments by the ones removed */
         i--;     /* reset to run this i again */
         /* output the "new" command line */
#ifdef DEBUG
         print_runtime_info(*argc,argv);
#endif
      }
   }
   return(OK);
}
/* ************************************************************************** */
int get_option(char *option, int *argc, char *argv[], long *n_flag)
{
   /* check for command line option */
   unsigned int olen = strlen(option);
   for(int i=1;i<*argc;i++)
   {
      if(strncmp(argv[i],option,olen) == 0)
      {  /* found option, next token data for the flag */
         /* allocate memory for the flag */
         int n_tokens = 1; /* number of tokens consumed by the flag */
         if(strlen(argv[i]) > olen ) /* no space between flag and name */
         {
            sscanf(argv[i]+olen,"%ld",n_flag);
            n_tokens = 1;
         }
         else if(i == *argc-1) /* no name for flag given */
         {
            printf("\n ERROR: %s option given without filename",option);
            exit(FAIL);
         }else  /* space between flag and name (flag next token) */
         {
            sscanf(argv[i+1],"%ld",n_flag);
            n_tokens = 2;
         }
         for(int j=i; j<*argc-n_tokens; j++)
         {
/*            strcpy(argv[j],argv[j+n_tokens]); */
              *(argv+j)=*(argv+(j+n_tokens));
         }
         *argc-=n_tokens; /* reduce the number of arguements by the ones removed */
         i--;     /* reset to run this i again */
         /* output the "new" command line */
         // print_runtime_info(*argc,argv);
      }
   }
   return(OK);
}
/* ************************************************************************** */
int get_option(char *option, int *argc, char *argv[])
{
   /* check for command line option,
      returns OK if option found
      FAIL if option not found */
   int rvalue = FAIL;
   int olen = strlen(option);
   for(int i=1;i<*argc;i++)
   {
      if(strncmp(argv[i],option,olen) == 0)
      {  /* found option, next token data for the flag */
         /* allocate memory for the flag */
         rvalue = OK;
         int n_tokens = 1; /* number of tokens consumed by the flag */
         for(int j=i; j<*argc-n_tokens; j++)
         {
/*            strcpy(argv[j],argv[j+n_tokens]); */
              *(argv+j)=*(argv+(j+n_tokens));
         }
         *argc-=n_tokens; /* reduce the number of arguements by the ones removed */
         i--;     /* reset to run this i again */
         /* output the "new" command line */
         // print_runtime_info(*argc,argv);
      }
   }
   return(rvalue);
}
/* ************************************************************************** */
/* *********************************************************************** */
void print_runtime_info(int argc, char *argv[])
{  // print file header stuff
     printf("Command Line: ");
     for(int i=0; i<argc; i++) printf(" %s", argv[i]);
     printf("\n Program %s Revision %f",  Prog_Name,Revision);
     time_t t;
     t = time(NULL);
     printf("\n Run on %s",  ctime(&t) );
}
/* ****************************************************** */
int main(int argc, char *argv[])
{
   print_runtime_info(argc, argv);
   if( (get_option("-help", &argc, argv) == OK) || 
       (get_option("-h", &argc, argv)    == OK) )
   {
     usage();return(OK);
   }
   /* get pre-defined options set off with a -d flag*/
   get_defined_option("-d",&argc,argv,DEFINED_ALONE);
   /* get pre-defined options set with a -v flag */
   get_defined_option("-v",&argc,argv,DEFINED_VALUE);
   /* see if want to change case of the input as it goes to the output */
   if(get_option("-u",&argc,argv)==OK) change_case = UPPER_CASE;
   if(get_option("-l",&argc,argv)==OK) change_case = LOWER_CASE;
   if(get_option("-ntabs",&argc,argv)==OK) discard_tabs = 1;
   if(get_option("-z",&argc,argv)==OK) remove_trailing_zeros = 1;
#ifdef DEBUG
   printf("\n Processed Initial Options");
#endif

   char filename[MAX_STR_LEN];   /* File Names    */
   char ofilename[MAX_STR_LEN];   /* File Names    */
   char string[MAX_STR_LEN];    /* Buffer for holding input line */
   if(argc > 1)
   {
      strcpy(filename, argv[1]);
   }
   else
   {
      printf("\n INPUT NAME OF FILE TO READ >");
      fgets(string,MAX_STR_LEN,stdin);sscanf(string,"%s",filename);
   }
   if(argc > 2)
   {
      strcpy(ofilename, argv[2] );
   }
   else
   {
      printf("\n INPUT NAME OF FILE TO WRITE >");
      fgets(string,MAX_STR_LEN,stdin);sscanf(string, "%s",ofilename);
   }
   if( (ostr = fopen(ofilename, "w") ) == NULL )
   {
      printf("\n ERROR OPENING OUTPUT FILE: %s", ofilename);
      putchar(7);return(EXIT_FAILURE);
   }
  // Now, process the file
#ifdef DEBUG
  printf("\n Entering Process from MAIN with file %s", filename);  
#endif
  int n_lines;
  n_lines = process_file(filename, LOCAL_GLOBAL);
  if (n_lines == FAIL)
  {
    printf("\n ERROR: process_file"); return(EXIT_FAILURE);
  }
#ifdef DEBUG
  printf("\n process_file completed, now freeing memory for #defines");
#endif
  /* free the memory for the #defined */
  for(int i=0;i<ndefined;i++)free(defined[i]);
#ifdef DEBUG
   printf("\n Closing Output Stream");
#endif
  fclose(ostr);
#ifdef DEBUG
  printf("\n %d lines written",n_lines);
#endif
  printf("\n Normal Termination for %s\n",Prog_Name);
  return(EXIT_SUCCESS);
}
/* *********************************************************************** */
int process_file(char *filename, int mode)
{
   /* filename is the name of the filename to search for
      mode is the mode to search for the file.
      mode = LOCAL_GLOBAL : search local directory, then path (#include " ")
      mode = GLOBAL       : search path (#include <>)
   */
/* on DOS systems, the path-elements are seperated by semi-colons,
   on UNIX, a colon is used */
#ifdef MSDOS
   char seperator[3] = ";";
#else
   char seperator[3] = ":";
#endif
   FILE *istr;          /* Input Stream */

   /* find the file and open it */
   istr = NULL; /* initialize the file pointer to NULL */
   if(mode == LOCAL_GLOBAL) /* search local directory first */
   {
      istr = fopen(filename, "r");
      if(istr != NULL)
            printf("\n Processing File %s", filename);
   }
   if(istr == NULL) /* if file not opened, then search the path */
   {
      char *path = getenv("DC_PATH"); /* find out what the environment variable is */
      if(path == NULL)
      {
        printf("\n ERROR: Cannot Open file %s in current directory",filename);
        printf("\n \t Cannot search path since Environment Variable for DC_PATH is not set\n");
        exit(FAIL);
      }
/*      printf("Search Path is %s", path); */
      /* next, parse the environment for each part (seperated by colons/semi-colons)
         to search */
      char *pstr; /* for strtok, return of token location */
      /* copy of path needed to prevent strtok from destroying on the path */
      char *path_copy = (char *) malloc((strlen(path)+1)*sizeof(char));
      if(path_copy == NULL)
      {
        printf("\n ERROR: Cannot allocate memory for path_copy\n");
        exit(FAIL);
      }
      strcpy(path_copy,path); /* copy of the path for strtok */
      /* loop while file is not opened and their are still tokens to process */
      while(istr == NULL && (pstr = strtok(path_copy,seperator))!= NULL)
      {
         char full_fname[MAX_STR_LEN];
         sprintf(full_fname,"%s/%s",pstr, filename);
/*         printf("\n Searching for %s", full_fname);*/
         istr = fopen(full_fname, "r");
         path_copy = NULL; /* set first argument to null for subsequent calls */
         if(istr != NULL)
            printf("\n Processing File %s", full_fname);
      }
      free(path_copy); /* free previously allocated memory */
   }
   if(istr == NULL)
   {
      printf("\n ERROR OPENING INPUT FILE %s ", filename);
      printf("\n \t \t path=%s",getenv("DC_PATH"));
      printf("\n \t \t seperator=%s \n",seperator);
      exit(EXIT_FAILURE);
   }
   /* file is open, now process_lines in the file */
#ifdef DEBUG
   printf("\n Entering process_file_lines");
#endif
   int n_lines = process_file_lines(istr);
#ifdef DEBUG
   printf("\n Exiting process_file_lines (n_lines = %d)",n_lines);
#endif
   if(n_lines < 0)
   {
     printf("\n ERROR: file %s processed with error",filename);
     if(n_lines == ELSE_RETURN) printf("\n \t Extra #else in the file");
     else
     if(n_lines == ELSEIF_RETURN) printf("\n \t Extra #elsif in the file");
     else
     if(n_lines == ENDIF_RETURN) printf("\n \t Extra #endif in the file");
     else
/*     if(n_lines == NULL) printf("\n \t n_lines returned NULL");
       else*/
     printf("\n ERROR: process_file_lines returned %d in process_file",n_lines);
     return(FAIL);
   }
/* else
   {
     printf("\n %d lines from file %s processed OK",n_lines, filename);
   } */
#ifdef DEBUG
   printf("\n Checking input stream at end of process_file");
#endif
   /*   if(istr != NULL)
   {
      printf("\n WARNING: input file left open, closing in process_file");
      fclose(istr);              
   } */
   return(n_lines);
}
/* *********************************************************************** */
int process_file_lines(FILE *istr)
{
   char string[MAX_STR_LEN];
   int n_lines =0;
#ifdef DEBUG
   printf("\n*** process_file_lines ***");
#endif
#ifdef OLD_COMMENTS
   while( fgets(string, MAX_STR_LEN, istr) != NULL) /* read a line from a file */
#else
   while( get_string(istr,string) == OK) /* read a line from a file */
#endif
   {
/* #ifdef DEBUG
     printf("\n***%s",string);
#endif */
/*   remove the "newline" character from the input  the newline character confuses
     the unix based string functions */
     if(string[strlen(string)-1] == '\x0a') string[strlen(string)-1] = STR_NULL;
    /* printf("\n Input String %s", string);*/
     if(strlen(string) == 0)
     {
/*        printf("Empty String");*/
        fprintf(ostr,"\n");
     }
     else
     {
      switch( string[0] )
      {
/*   4/15/97: use c++ style comments */
#ifdef OLD_COMMENTS
         case 'c':   // Comment Fields
         case 'C':   // Comment Fields
            break;
#endif
         case '#':   // Possible # directive
            if(strncmp("#include",string,8) == 0) /* If Reading an Include */
            {
	      int n_include = process_include(string);
              if(n_include == FAIL) 
	      {
		printf("\n ERROR: process_file_lines: Processing Include"); return(FAIL);
              }
               n_lines+=n_include;
               break;
            }else if(strncmp("#define",string,7) == 0) /* define directive */
            {
               if(process_define(string)==OK){ n_lines++; break;}
               else
               {
                  printf("\n ERROR processing a #define directive");
               }
            }else if(strncmp("#undef",string,6) == 0) /* undef directive */
            {
               if(process_undefine(string)==OK){ n_lines++; break;}
               else
               {
                  printf("\n ERROR processing a #undef directive");
               }
            }else if( (strncmp("#ifdef",string,6) == 0) || /* ifdef directive */
                      (strncmp("#ifndef",string,7)== 0) )  /* ifndef directive */
            {
               if(process_ifdef(istr,string) == OK){ n_lines++; break;}
               else
               {
                  printf("\n ERROR: processing #ifdef / #ifndef directive %s",string);
               }
            }else if(strncmp("#endif",string,6) == 0) /* endif directive */
            {
               return(ENDIF_RETURN);
            }else if(strncmp("#elseif",string,7) == 0) /* else directive */
            {
               return(ELSEIF_RETURN);
            }else if(strncmp("#elif",string,5) == 0) /* else directive */
            {
               return(ELSEIF_RETURN);
            }else if(strncmp("#else",string,5) == 0) /* else directive */
            {
               return(ELSE_RETURN);
            }else if(strncmp("#report",string,7) == 0) /* report directive */
            {
              report_defined();break;

            }else if(strncmp("#echo",string,5) == 0) /* echo directive */
            {
              process_echo(string+5);break;
            }else if(strncmp("#error",string,6)== 0) /* error directive */
            {
              process_echo(string+6);break;
            }
            else if(strncmp("#exit",string,6)== 0) /* exit directive */
            {
              exit(OK);
	      //              process_echo(string+6);break;
            }
            else
            {
               printf("\n WARNING: %s is bring processed as a string",string);
            }
            /* break; */
         default:
            char ostring[MAX_STR_LEN];
#ifdef OLD_COMMENTS
            remove_comments(string); /* remove comments from the string */
#endif
            if(process_token_string(string, ostring)== FAIL)
            {
              printf("\n ERROR: process_token_string");return(FAIL);
                                }
            process_line(ostr,ostring);
            n_lines++;
         }  // End Switch
       } /* end if */
      }      // End While
      return(n_lines);
}
/* ************************************************************************** */
int skip_file_lines_till_else_or_endif(FILE *istr)
{   /* skip lines in the file till an #else or #endif directive */
   char string[MAX_STR_LEN];
#ifdef DEBUG
   printf("\n *** skip_till_else_or_endif ***");
#endif
#ifdef OLD_COMMENTS
   while( fgets(string, MAX_STR_LEN, istr) != NULL) /* read a line from a file */
#else
   while( get_string(istr,string) == OK) /* read a line from a file */
#endif
   {
#ifdef DEBUG
     printf("\nskip_file_lines_till_else_or_endif***%s",string);
#endif
/*   remove the "newline" character from the input  the newline character confuses
     the unix based string functions */
     if(string[strlen(string)-1] == '\x0a') string[strlen(string)-1] = STR_NULL;
     if(strlen(string) != 0)
     {
      switch( string[0] )
      {
#ifdef OLD_COMMENTS
         case 'c':   // Comment Fields
         case 'C':   // Comment Fields
            break;
#endif
         case '#':   // Possible # directive
            if( (strncmp("#ifdef",string,6) == 0) || /* ifdef directive  */
                (strncmp("#ifndef",string,7)== 0) )  /* ifndef directive */
            { /* skip all lines in this #ifdef / #ifndef */
              skip_file_lines_till_endif(istr);
            }
            else if(strncmp("#endif",string,6) == 0) /* endif directive */
            {
              return(ENDIF_RETURN);
            }else if(strncmp("#elseif",string,7) == 0 ||
                     strncmp("#elif",string,5) == 0 ) /* else directive */
            {
               if(process_ifdef(istr,string) != OK)
               {
                  printf("\n ERROR processing #elseif / #elif directive");
               }
               return(ELSEIF_RETURN);
            }else if(strncmp("#else",string,5) == 0) /* else directive */
            {
              return(ELSE_RETURN);
            }else if( (strncmp("#echo",string,5) == 0) || /* echo directive */
                      (strncmp("#error",string,6) == 0) || /* error directive */
                      (strncmp("#define",string,7) == 0) ||
                      (strncmp("#undef",string,6)  == 0) ||
                      (strncmp("#include",string,8) == 0) )
            {
             /* skip the line without processing it */
            }
            else{
               printf("\n WARNING: %s is being processed as a string",string);
            }
            break;
         default:
            /* skip the line */
            continue;
         }  // End Switch
       } /* end if */
      }      // End While
      printf("\n ERROR: File Ended while inside of a #ifdef / #ifndef directive ");
      return(FAIL);
}
/* ************************************************************************** */
int skip_file_lines_till_endif(FILE *istr)
{   /* skip lines in the file till an #else or #endif directive */
   char string[MAX_STR_LEN];
#ifdef DEBUG
   printf("\n *** skip_till_endif ***");
#endif
#ifdef OLD_COMMENTS
   while( fgets(string, MAX_STR_LEN, istr) != NULL) /* read a line from a file */
#else
   while( get_string(istr,string) == OK) /* read a line from a file */
#endif
   {
#ifdef DEBUG
     printf("\nskip_till_endif*** %s", string);
#endif
/*   remove the "newline" character from the input  the newline character confuses
     the unix based string functions */
     if(string[strlen(string)-1] == '\x0a') string[strlen(string)-1] = STR_NULL;
     if(strlen(string) != 0)
     {
      switch( string[0] )
      {
#ifdef OLD_COMMENTS
         case 'c':   // Comment Fields
         case 'C':   // Comment Fields
            break;
#endif
         case '#':   // Possible # directive
            if( (strncmp("#ifdef",string,6) == 0) || /* ifdef directive */
                (strncmp("#ifndef",string,7)== 0)  ) /* ifndef directive */
            { /* skip all lines in this #ifdef / #ifndef */
              skip_file_lines_till_endif(istr);
            }
            if(strncmp("#endif",string,6) == 0) /* endif directive */
            {
              return(ENDIF_RETURN);
            }
            break;
         default:
            /* skip the line */
            continue;
         }  // End Switch
       } /* end if */
      }      // End While
      printf("\n ERROR: File Ended while inside of a #ifdef / #ifndef directive ");
      printf("\n ERROR: Looking for #endif");
      return(FAIL);
}
/* ************************************************************************** */
int process_echo(char *string)
{
   printf("\n %s",string);
   return(OK);
}
/* ************************************************************************** */
int process_line(FILE *ostr, char *string)
{
   /* determine the length of the line */
   int length = strlen(string);

   /* change case if it is requrired */
   if(change_case == LOWER_CASE)      string[0] = tolower(string[0]);
   else if(change_case == UPPER_CASE) string[0] = toupper(string[0]);

   fputc(string[0], ostr);
   for(int i=1; i<length; i++)
   {
      if(string[i] == '\t' && discard_tabs ) string[i] = ' '; /* replace tabs with spaces */
#ifdef OLD_COMMENTS
      if(string[i] != '$') /* check for comments starting with $ */
      {
         /* change case if it is requrired */
         if(change_case == LOWER_CASE)      string[i] = tolower(string[i]);
         else if(change_case == UPPER_CASE) string[i] = toupper(string[i]);
    fputc(string[i], ostr);
      }
      else
      {
         i = length; /* end the loop and terminate the string */
      }
#else
     /* change case if it is requrired */
     if(change_case == LOWER_CASE)      string[i] = tolower(string[i]);
     else if(change_case == UPPER_CASE) string[i] = toupper(string[i]);

     fputc(string[i], ostr);
#endif
  }
  fputc('\n',ostr);
  return(OK);
}
/* ************************************************************************* */
int process_include(char *string)
{   // gets the include file and processes it
   // get the part in the quotes
   int len;
   int stp;
   int n_lines;
   int mode = LOCAL_GLOBAL;
   char filename[MAX_STR_LEN];
   char delimeter;

   len=strlen(string);
   stp=0;
   /* advance past first quote or < delimiter */
   while( string[stp]!='"' && string[stp]!='<' && stp < len)stp++;
   if(stp >= len) /* complain if no delimeter is found */
   {
      printf("\n ERROR: %s is not a valid include",string);
      return(FAIL);
   }
   /* find out what the delimeter was */
   if(string[stp] == '"') delimeter = '"';
   else if(string[stp] == '<')
      {
         delimeter = '>';
         mode = GLOBAL;
      }
   else{
       printf("\n ERROR: %c is an invalid delimeter",string[stp]);
   }
   stp++; /* advance past the delimeter */
   int i=0;
   while( string[stp]!=delimeter   && stp < len)
   {
      filename[i++] = string[stp++];
      filename[i]=STR_NULL;
   }
/*   printf("\n Including File %s",filename);*/
   n_lines = process_file(filename, mode);
        if(n_lines == FAIL)
   {
     printf("\n ERROR: process_include: process_file");
        }
   return(n_lines);
}
/* *********************************************************************** */
int my_xor(int a, int b) /* create my own exclusive OR */
{                     /* truth table for XOR is same as for OR */
  if( a&&b ) return(0); /* except for if a and b are true */
  return( ( a||b ) );
}
/* *********************************************************************** */
int process_ifdef(FILE *istr, char *string)
{   // processes ifdef lines
   int len;
   int stp;
   len=strlen(string);

   int ndef = 0; /* flag to used if looking for ndef */

   /* advance past the #ifdef / #ifndef / #elseif / #elif part of the string */
   if(strncmp("#ifdef",string,6) == 0) stp=6;
   else if(strncmp("#ifndef",string,7) == 0){ stp=7; ndef = 1;}
   else if(strncmp("#elseif",string,7) == 0) stp=7;
   else if(strncmp("#elif",string,5) == 0) stp=5;
   else{
      printf("\n ERROR: in process_ifdef without #ifdef, #elseif or #elif");
      printf("\n %s",string);
      return(FAIL);
   }
   /* advance out white space */
   while(isspace(string[stp]) && stp < len)stp++;
   if(stp >= len) /* complain if nothing found after the define */
   {
      printf("\n ERROR: %s is not a valid #ifdef / #ifndef / #elseif / #elif ",string);
      return(FAIL);
   }
   /* check to see if the value is defined (or not defined for ifndef) */
   if( my_xor( (check_for_defined(string+stp) == OK),ndef) ) /* use xor defined above */
   { /* if found the defined string */
     /* process the file contents till a #endif or #else appears */
     int rv =process_file_lines(istr);
     if(rv==ELSE_RETURN || rv == ELSEIF_RETURN)
     {
       int rval = skip_file_lines_till_endif(istr);
       switch(rval)
       {
          case ENDIF_RETURN:
             break;
          case ELSEIF_RETURN:
            printf("\n ERROR: Only #endif return is Valid");
            return(FAIL);
          case ELSE_RETURN:
             printf("\n ERROR: #else followed by #else");
          default:
             printf("\n ERROR: Invalid #ifdef format");
             return(FAIL);
       }
     }
   }
   else
   {
     /* skip file contents till a #endif or #else appears */
     int rval = skip_file_lines_till_else_or_endif(istr);
     switch(rval)
     {
        case ENDIF_RETURN:
            break;
        case ELSEIF_RETURN:
             break;
        case ELSE_RETURN: /* process till the #endif */
            if(process_file_lines(istr) == ELSE_RETURN)
            {
               printf("\n ERROR: #else followed by #else");
               return(FAIL);
            }
            break;
        case FAIL:
        default:
           printf("\n ERROR processing #ifdef / #ifndef directive");
           return(FAIL);
     }
   }
   return(OK);
}
/* *********************************************************************** */
int process_undefine(char *string)
{   /* remove a value from the list of defined values */
   int len;
   int stp=0;
#ifdef DEBUG
        printf("\n process_undefine input string: %s\n",string);
#endif
   len=strlen(string);
   /* advance past the #undef part of the string */
   if(strncmp(string,"#undef",6)==0) stp=6;/* #undef takes up the first 7 characters */
   /* advance out white space */
   while(isspace(string[stp]) && stp < len)stp++;
   if(stp >= len) /* complain if nothing found after the undef */
   {
      printf("\n ERROR: %s is not a valid #undef",string);
                printf("\n        stp: %d, len %d",stp,len);
      return(FAIL);
   }
   /* look for the value in the list of defined values */
   char token[MAX_STR_LEN];
   sscanf(string+stp,"%s",token);
#ifdef DEBUG
   printf("\n Token %s Being Undefined",token);
   printf("\n Looping through %d tokens",ndefined);
#endif
   len = strlen(token);
   int i=0;
   /* search for the token */
   while(  i < ndefined &&
          !(strncmp(defined[i]->input,token,len)==0) )
   {
#ifdef DEBUG 
      printf("\n %d %s",i,defined[i]->input); 
#endif
      i++;
   }
#ifdef DEBUG
   printf("\n Token %s found at value %d", defined[i]->input,i);
#endif
   if(i==ndefined) /* check for token not found */
   {
      printf("\n ERROR: Attempted to #undef %s when it was not defined",token);
      return(FAIL);
   }
   /* found the token */
   /* copy other tokens over this one */
   for(int k=i; k<ndefined-1;k++)
   {
      strcpy(defined[k]->input,defined[k+1]->input);
      strcpy(defined[k]->output,defined[k+1]->output);
   }
   /* free the memory for that token */
   free(defined[ndefined-1]);
   /* decrement the number of tokens defined */
   ndefined--;
   return(OK);
}
/* *********************************************************************** */
/* *********************************************************************** */
int process_define(char *string)
{   // defines strings to be equal to values
   int len;
   int stp=0;
#ifdef DEBUG
        printf("\n process_define input string: %s\n",string);
#endif
   len=strlen(string);
   /* advance past the #define part of the string */
   if(strncmp(string,"#define",7)==0) stp=7; /* #define takes up the first 7 characters */
   /* advance out white space */
   while(isspace(string[stp]) && stp < len)stp++;
   if(stp >= len) /* complain if nothing found after the define */
   {
      printf("\n ERROR: %s is not a valid #define",string);
                printf("\n        stp: %d, len %d",stp,len);
      return(FAIL);
   }
   /* allocate the memory for the #define */
   defined[ndefined] = (defined_type *)malloc(sizeof(defined_type)+1);
   if(defined[ndefined] == NULL)
   {
      printf("\n ERROR: Cannot Allocate Memory for defined[%d]\n",ndefined);
      exit(EXIT_FAILURE);
   }
   /* get the string for the define */
   char temp[MAX_STR_LEN];
   sscanf(string+stp,"%s",temp);
/*     use of process_token_string here will allow #define first part to consist of previously
       defined elements.  Use of strcpy will not allow it to consist of previously defined elements */
   //   process_token_string(temp,defined[ndefined]->input); // allow sub-string replacement 
   strcpy(defined[ndefined]->input,temp); /* copy it to defined */
   /* advance out this string */
   stp+=strlen(temp);
   /* advance out white space */
   while(isspace(string[stp]) && stp < len)stp++;
   if(stp >= len) /* complain if nothing found after the value to define */
   {
      strcpy(defined[ndefined]->output,defined[ndefined]->input);
      strcat(defined[ndefined]->output,"_DEFINED_WITHOUT_A_VALUE");
   }
   else
   {
      /* get the second string for the define */
      sscanf(string+stp,"%s",temp);
      strcpy(defined[ndefined]->output,temp);    /* copy it to defined */
      /* check if the #define part of the directive can be broken down */
      process_token_string(temp,defined[ndefined]->output);
   }
#ifdef DEBUG
   printf("\n process_define After Reduction:");
   printf(" #define:  %s = %s \n",
   defined[ndefined]->input,defined[ndefined]->output);
#endif
   /* check that not going out of bounds then return */
   if(++ndefined > MAX_DEFINED)
   {
      printf("\n ERROR: Maximum number of #define directives exceeded");
      return(FAIL);
   }
   sort_defined();
   return(OK);
}
/* *********************************************************************** */
int sort_defined()
{
   /* sort the defines from longest string to shortest so when do #define
      replacement, do not need to worry about sub-strings being replaced */
   int i=0;
   int max_check = ndefined-1; /* only check up to n-1 since looking to n+1 */
   do{
      if(ndefined && i<max_check && (strlen(defined[i]->input) < strlen(defined[i+1]->input)))
      { /* more than one defined and if string is shorter than next string, swap positions */
         /*printf("\n Swap Locations of %s and %s", defined[i]->input,defined[i+1]->input);*/
         defined_type dtemp;
         strcpy(dtemp.input,defined[i]->input);
         strcpy(dtemp.output,defined[i]->output);
         strcpy(defined[i]->input,defined[i+1]->input);
         strcpy(defined[i]->output,defined[i+1]->output);
         strcpy(defined[i+1]->input,dtemp.input);
         strcpy(defined[i+1]->output,dtemp.output);
         if(i) i--; /* reduce i if it is non-zero for next loop */
      }
      else
      {
         i++; /* increment i for next loop */
      }
   }while( i < max_check);
   return(OK);
}
/* ************************************************************************ */
int report_defined() {
   int i=0;
   for(i=0;i<ndefined;i++)
   {
      printf("\n %d %s %s",i,defined[i]->input,defined[i]->output);
   }
   return(OK);
}
/* *********************************************************************** */
int process_token_string(char *in_string, char *out_string)
/* take in_string, a string of tokens which can include #defined elements and
   math operators and reduces it to out_string, the result of replacing the
   #defines and performing the math operators.  This routine is
   recursive, so #defines can be in terms of other #defines and have
   math operators in it.  The recursion occurs in */
{
   char temp_string[MAX_STR_LEN]; /* temporary buffer for storing string */
   char token_string[MAX_STR_LEN];
   char *pt; /* pointer to a token */
   int icount = 0; /* position in input string */
   int ocount = 0; /* position in output string */
   /* ensure outstring is null terminated */
   for(int k=0;k<MAX_STR_LEN;k++)out_string[k]='\0';
   int ntoken = 0;
#ifdef DEBUG
   printf("\n process_token_string in_string: %s\n",in_string);
#endif
   if(replace_defines(in_string)!= OK) /* replace the #defines in the string */
   {
     printf("\n ERROR: Replacing Defines"); return(FAIL);
   }
   int ilen=strlen(in_string);
   do{
      /* preserve initial space and space between tokens */
      while(isspace(in_string[icount]) && icount < ilen)
      {
         out_string[ocount]=in_string[icount];  /* set space in outstring */
    icount++; /* advance instring counter  */
    ocount++; /* advance outstring counter */
      }
      /* put remainder of input string in a temporary buffer */
      strcpy(temp_string,in_string+icount);
      pt = strtok(temp_string," "); /* get the next space seperated token  */
      if(pt == NULL)
      {
         /* if only a single token on the line, return it */
   /*   if(ntoken == 0) strcat(out_string, in_string); /* ******STILL WORKING ON THIS ***** */
#ifdef DEBUG
         printf("\n END OF STRING FOUND: Total of %d tokens",ntoken);
         printf("\n process_token_string Output String: %s",out_string);
#endif
    return(OK);
      }
#ifdef DEBUG
      printf("\n Processing evaluate_token: %s",pt);
#endif
      evaluate_token(pt,token_string);

#ifdef DEBUG
      printf("\n Token_string = %s", token_string);
#endif
      strcat(out_string,token_string);
      /* printf("\n %s %s",out_string,token_string); */
      ocount+=strlen(token_string);
      icount+=strlen(pt); /* token_len  advance amount taken from input string */
      /* put the result on the output string*/
/*    ntoken+=nstoken;*/
   }while(icount < ilen);
#ifdef DEBUG
   printf("\n process_token_string Output String: %s",out_string);
#endif
   return(ntoken);
}
/* ************************************************************************* */
int evaluate_token(char *pt, char *token_string)
{
  /* evaluates a "major" token by breaking it up into "sub" tokens,
     computing any math from "sub" tokens, and then returning the
     result in out_string.  If the string to evaluate has anything but
     pure mathematical entities, the string is just returned */
   char token[MAX_TOKENS][MAX_TOKEN_LEN]; /* storage location for tokens */
   char operater[MAX_STR_LEN]; /* storage for operators beteen tokens */
   double value[MAX_TOKENS];   /* storage for values between tokens */
   char *pstr;                 /* pointer to string */
   char *cstring="+-*/^";       /* to allow division, need to put / here */
   double answer;              /* temp for holding processing value of token math */
   int token_len = strlen(pt); /* get the length of the token */
   int nstoken=0;              /* number of sub-tokens */
   int scount=0;               /* position in sub-token strings */
   /* check input line for non-math operators */
   if(is_math(pt)!=OK)
   {                           /* return in non-math operators on the input line */
      /* printf("\n Non math string: %s",pt); */
      strcpy(token_string,pt);
      return(OK);
   }
   /* create sub-tokens from the input line */
   do{
      token[nstoken][0]=STR_NULL; /* initialize the sub-token */
      do{
         int st_len = 1+strcspn(pt+scount+1,cstring); /* advance to any math operators */
         strncat(token[nstoken],pt+scount,st_len);    /* put it on the token stack */
         scount+=st_len;                              /* advance location in sub-string */
      }while( (pt[scount-1] == 'e'  || 
                    pt[scount-1] == 'E') ||       /* check for exponential format numbers */
         (nstoken                    && /* first sub-token can be any length */
          strlen(token[nstoken]) < 2 &&
          scount < token_len));
      /* first sub-token can have length of 1 or greater.
            All other sub-tokens must have a length of 2 or greater
            since they include an operation.  Thus, will loop until
            have the string long-enough
      */
      nstoken++;
   }while(scount < token_len && nstoken < MAX_TOKENS);
   /* processing is based on number of tokens processed */
   /* process the tokens */
   if(nstoken==1) /* if have only one token, then return its value */
   {
      pstr=token[0];
      strcpy(token_string,pstr);
      return(OK);
   }
   else  /* process multi-tokens */
   {
      /* get the tokens and the values */
           int i;
      for(i=0;i<nstoken;i++)
      {
         operater[i]='\0';
         if( i ) /* get operators */
         {
            operater[i]=token[i][0];
       pstr=token[i]+1;
         }
         else /* the first operator on a token string can only give sign */
         {
            pstr=token[i];
         }
         /* must add check to see that we are scanning a number ONLY */
         /* If not a number only, return a string */
         /* printf("\n Calling string_value with %s", pstr); */
         if(string_value(pstr,&value[i]) != OK)
         {
            strcpy(token_string,pstr);
       /* printf("\n String Value Returned %s %s", token_string,pt); */
       return(OK);
         }
     }
     /* process any operations on the tokens
        order of operations, from right to left,
         multiplies, then divides */
     /* multiplies and divides */
     for(i=nstoken-1;i>0;i--) /* go right to left */
     {
        switch(operater[i])
        {
           case '^' : /* Exponentiation */
                  answer = pow(value[i-1],value[i]);
               /* then must shrink tokens, can replace with a + and a 0
                     to get the correct effect */
               value[i-1]=answer;
               for(int j=i;j<nstoken-1;j++)
               {
                  value[j]=value[j+1];
                  operater[j]=operater[j+1];
               }
               nstoken=nstoken-1;
        break;

            case  '/' : /* treat division as inverse of multiplication */
               if(value[i]==0.0){
                  printf("\n ERROR: divide by 0.0 error will occur");
                  printf("\n %s\n",pt);
                  exit(EXIT_FAILURE);
               }
               value[i] = 1.0/value[i];
            case '*' :
               answer = value[i-1]*value[i];
               /* then must shrink tokens, can replace with a + and a 0
                     to get the correct effect */
               value[i-1]=answer;
               for(int j=i;j<nstoken-1;j++)
               {
                  value[j]=value[j+1];
                  operater[j]=operater[j+1];
               }
               nstoken=nstoken-1;
               break;
        } /* end switch */
     } /* end for */
     answer =value[0];
     for(i=1;i<nstoken;i++) /* addition and subtraction of tokens */
     {
         switch(operater[i])
         {
            case '-': value[i]=-1.0*value[i];
            case '+': answer+=value[i];
               break;
            default:
               printf("\n ERROR: Invalid Operator %c",operater[i]);
         } /* end switch */
     } /* end for */
     // sprintf(token_string,"%g",answer); /* was %f format, then needed to remove trailing zeros */
          gcvt(answer,Sig_Dig,token_string);
          /* remove trailing zeros from tokens is specified, should not be needed with change to %g */
          if(remove_trailing_zeros) 
        remove_zeros(token_string);
   } /* end else */
   return(OK);
}
/* ************************************************************************* */
int remove_zeros(char *pstr)
{
    int len=strlen(pstr);
    int i=0;
    for( i=0; i<len; i++) /* check for exponential format, skip if find */
    {
       if( !( isdigit(pstr[i]) || /* check that it is a digit */
           pstr[i] == '.' || /* decimal points */
      pstr[i] == '+' || /* sign */
           pstr[i] == '-' )) /* sign */
                  return(FAIL);
    }
    /* remove trailing 0's */ 
    int loc=len-1;
    while(pstr[loc] == '0' && loc > 2) 
    {
       pstr[loc]='\0'; 
       loc--; 
    }
    if(pstr[loc]=='.') pstr[loc]='\0';
    return(OK);
}
/* ************************************************************************* */
int is_math(char *pstr) /* returns OK if a string only has math characters in it */
{
   int len=strlen(pstr);
   for(int i=0; i<len;i++)
   {
      if( !( isdigit(pstr[i]) || /* check that it is a digit */
             pstr[i] == '^' || /* For exponentiation */
               pstr[i] == '.' || /* decimal points */
               pstr[i] == '+' || /* sign */
               pstr[i] == '-' || /* sign */
               pstr[i] == '*' ||
               pstr[i] == '/' ||
               pstr[i] == 'e' || /* for exponentials */
               pstr[i] == 'E'  ) ) return(FAIL);
   }
        /* last character MUST be a digit */
        if( isdigit(pstr[len-1]) ) return(OK);
   return(FAIL);
}
/* ********************************************************** */
int string_value(char *pstr, double *value)
{
/* converts a string to a "value" */
   int sign = 1;
   int i=0;
   /* check if the number is signed, if so, apply the sign */
   while(pstr[i] == '+' || pstr[i] == '-') /* if character is a sign */
   {
      if(pstr[i] == '-') sign = -1*sign;
      i++;
   }
   pstr+=i; /* advance out all of the sign stuff */
   int len = strlen(pstr);
   for(i=0;i<len;i++)
   {
      if( !( isdigit(pstr[i]) || /* check that it is a digit */
               pstr[i] == '.' || /* decimal points */
               pstr[i] == '+' || /* sign */
               pstr[i] == '-' || /* sign */
/*               pstr[i] == '*' ||
               pstr[i] == '/' || */
               pstr[i] == 'e' || /* for exponentials */
               pstr[i] == 'E'  ) )
      {
/*          printf("\n String Lengths: %d %d",strlen(pstr),strlen(pstr1));
          printf("\n %s Not a Number at character %d",pstr1,i); */
         return(FAIL);
      }
   }
   if(sscanf(pstr,"%lf",value)!=1)
   {
      return(FAIL);
   }
   if(sign < 0.0 )
   {
      *value= -1.0*(*value); /* correct signed value */
   }
   return(OK);
}
/* ********************************************************************* */
int check_for_defined(char *token)
/* checks a given token to see if it is defined
   returns OK if token is found, returns FAIL if token not found */
{
   int len;
   len = strlen(token);
   /* remove spaces from the end of the string for comparison purposes */
   while(isspace(token[len-1])) len--;
   for(int i=0;i<ndefined;i++)
   {
     int iLen=strlen(defined[i]->input); // make sure tokens are the same length
     if(iLen == len) {
        if(strncmp(defined[i]->input,token,len)==0){
          return(OK);
       }
     }
   }
   return(FAIL);
}
/* *********************************************************************** */
int recursiveReplacementSearch(int iMax) {
  for(int iDefine=0; iDefine<iMax; iDefine++) {
    if( 0==strcmp(defined[iMax]->output,defined[iDefine]->input) ){
      printf("\n Found 2ndary match for %s = %s, replace with %s", defined[iMax]->input, defined[iMax]->output, defined[iDefine]->output);
      // found a match, need to deal with it...
      recursiveReplacementSearch(iDefine);
      strcpy(defined[iMax]->output,defined[iDefine]->output);
    }
  }
  return(0);
}
/* *********************************************************************** */
int replace_defines(char *string)
{
   /* determine the length of the line */
   /* have temporary string to put everything in */
   char out_string[MAX_STR_LEN];
   strnset(out_string,'\0',MAX_STR_LEN); /* null entire output string */
   // #define DEBUG
#ifdef DEBUG
   printf("\n replace_defines Input String:\t%s\n", string);
#endif
   for(int i=0; i<ndefined;i++) /* loop over all #defined things */
   {
      int inlen = strlen(string);
      int olen = strlen(defined[i]->input); /* get length of output string */
      int ocount = 0;
      // printf("\n Comparison String: %s", defined[i]->input); 
      out_string[0]=STR_NULL; /* ensure string is null terminated */
      for(int j=0; j < inlen; j++)      /* increment through the string */
      {
         if( /*j < inlen-olen+1 && */strncmp(defined[i]->input,string+j,olen)==0 )
         { /* if find a match, replace #define in the output string */
             /* printf("\n String Cat %s %s", out_string, defined[i]->output); */
	   // --- 6/19/2010 --- see if the replacement string is defined -- this needs to be recursive
           recursiveReplacementSearch(i);
	   // ---
             ocount+=strlen(defined[i]->output); /* advance output string counter */
             if(ocount > MAX_STR_LEN)
             {
                printf("\n ERROR: Length of Output String Exceeded in replace_defines"); 
                printf("\n \tIncrease check input or increase MAX_STR_LEN");
                printf("\n\t string: %s\n\t out_string: %s", string, out_string);return(FAIL);
             }
             strcat(out_string,defined[i]->output);    /* Add string to end */
             j+=olen-1; /* advance input string counter by number of elements used */
             /* printf("\n #define Replacement:");
             printf("\n string %s\nostring %s", string, out_string); */
         }
         else
         { /* if no match, patch to the end of the string */
            /* printf("\n no match %s",out_string); */
            out_string[ocount++] = string[j];
            if(ocount >= MAX_STR_LEN)
	    {
                printf("\n ERROR: Length of Output String Exceeded in replace_defines"); 
                printf("\n \tIncrease check input or increase MAX_STR_LEN");
                printf("\n\t string: %s\n\t out_string: %s", string, out_string);return(FAIL);
            }
         }
         out_string[ocount] = STR_NULL ; /* be sure string is null terminated */
      }
      strcpy(string,out_string); /* copy the output string to the input for next itteration */
   }
#ifdef DEBUG
   printf("\n replace_defines Return String:\t%s\n", string);
#endif
   return(OK);
   // #undef DEBUG
}
/* ********************************************************************** */
#ifdef OLD_COMMENTS
int remove_comments(char *string)
{
   /* determine the length of the line */
   int length = strlen(string);
   /* have temporary string to put everything in */
   for(int i=0; i<length; i++)
   {
      if(string[i] == '$') /* check for comments starting with $ */
      {
         string[i] = STR_NULL;
      }
   }
   return(OK);
}
#endif
/* ************************************************************************** */
int get_string(FILE *fspec, char *string)
{
#ifdef DEBUG
  int rvalue=fget_c_string(string, MAX_STR_LEN, fspec);
  printf("\n fget_c_string returns %s", string);
  return(rvalue);
#else
   return(fget_c_string(string, MAX_STR_LEN, fspec));
#endif
}
#define REWIND_STREAM 100
/* ************************************************************************** */
int fget_c_string(char *string, int Max_Str_Len, FILE *fspec)
{
   /* gets a string from the input and removes comments from it */
   /* allows comments in standard "c" syntax,
           starting with / *
      ending with  * /  */
   /* also allows c++ type comments, // causes rest of line to be skipped */

   int check;
   char comment_start[4]="/*";  /* signals start of comment */
   char comment_stop[4]="*/";   /* signals end of comment   */
   int clen; /* length of string for start/stop*/
   int ilen; /* length of input string */
   char *istring; /* input string */
   int olen; /* location on output string */
   int icnt; /* location on string */

   //   int n_pass = 0; /* Number of passes through the file looking for a value */

   olen = 0;
   /* allocate memory for input string */
   istring = (char *)calloc(Max_Str_Len,sizeof(char));
   if(istring == NULL)
   {
      printf("\n ERROR: Allocating memory for input string if fget_c_string");
      return(FAIL);
   }
   strnset(string,'\0',Max_Str_Len); /* null entire output string */
   strnset(istring,'\0',Max_Str_Len); /* null entire input string */

#ifdef DEBUG
   printf ("\n --------------fget_c_string");
#endif
   clen = strlen(comment_start);
   /* read in the line, verify that it exists */
   do{
      /* read in a line from the file */
      while(fgets(istring, Max_Str_Len, fspec) == NULL) /* output warning if not a valid read */
      {
#ifdef DEBUG
        printf("\n istring: %s", istring);
#endif
#ifdef ALLOW_REWIND
   if(n_pass) /* if already gone through file once looking for value, quit */
#endif
   {
#ifdef DEBUG
         printf ("\n***End of Input File in get_string, closing"); 
#endif
//           printf ("\nERROR: Reading File : End of File On Read ");
           fclose(fspec);
           free(istring);
           return(FAIL);
        }
#ifdef ALLOW_REWIND
        n_pass++;      /* increment the number of times through the file */
        rewind(fspec); /* rewind to the beginning of the file */
        free(istring);
        return(REWIND_STREAM); 
#endif
      }
#ifdef DEBUG
        printf("\n istring: %s", istring);
#endif
      ilen = strlen(istring); /* length of input string */
      istring[ilen]='\0'; /* null terminate the string */
      if(ilen < clen) /* not possible to have comment on the line */
      {               /* so output the string as is */
         strcpy(string,istring);
         olen = strlen(string);
      }
      else
      {
        /* strip comments out of input string */
        icnt=0;
        do{
          check = 1;
          if(icnt < ilen - clen)  /* make sure have enough characters for start of comment */
             check = strncmp(istring+icnt,comment_start,clen); /* check if start of comment */
          if(check == 0) /* comment found for standard c syntax */
          {
            /* find end of comment */
            icnt+=clen; /* advance past comment delimeter */
            clen=strlen(comment_stop); /* get length of end of comment delimiter */
            /* look for end of comment till end of string */
            do{
               check = 1;
               if(icnt < ilen - clen)  /* make sure have enough characters for end of comment */
                  check = strncmp(istring+icnt, comment_stop,clen);
               if(check != 0)  /* if not end of comment */
               {
                  icnt++; /* increment location on string */
                  if(icnt>ilen) /* if advance past end of string, get a new one */
                  {
                     if(fgets(istring, Max_Str_Len, fspec) == NULL) /* output warning if not a valid read */
                     {
                        printf ("\nERROR: Reading File, looking for end of comment %s",comment_stop);
                        fclose(fspec);
                        free(istring);
                        return(FAIL);
                     }
                     ilen = strlen(istring); /* get length of this new string */
                     /* null terminate the string */
                     istring[ilen]='\0';
                     icnt = 0; /* reset the counter to the start of the string */
                  }
               }
               else
               {
                  icnt+=clen; /* advance past comment delimiter */
               }
            }while(check != 0); /* end of comment found */
          }  /* end if */
          else /* check if comment is in c++ format */
          {
             check = strncmp(istring+icnt, "//",2);
             if(check == 0) /* c++ style comment found */
             {  /* skip till end of string */
                icnt = ilen;
                string[olen++]='\n';
                string[olen]='\0';
             }
             else /* is a valid character for the string */
             {
                string[olen++] = istring[icnt++]; /* append value to the string */
                string[olen]='\0';
             }
          }
        }while(icnt < ilen          &&    /* do till end of string */
               olen < Max_Str_Len); /* and output string not too long */
        /* check for only carriage return (should have been caught above) */
        if(olen == 1 && string[0] == '\n') olen = 0;

      }  /* end else */
   }while(olen == 0); /* do till read in a string */
   if(olen == Max_Str_Len)
   {
      printf ("\nERROR: Input line too long");
      fclose(fspec);
      free(istring);
      return(FAIL);
   }
   free(istring);
   return(OK);
}
/* ***************************************************************************** */
int old_get_string(FILE *fspec, char *string)
{
   /* gets a string from the input and removes comments from it */
   /* allows comments in standard "c" syntax, */
   //        starting with /*
   //        ending with  */
   /* also allows c++ type comments, // causes rest of line to be skipped */

   int check;
   char comment_start[4]="/*";  /* signals start of comment */
   char comment_stop[4]="*/";   /* signals end of comment   */
   int clen; /* length of string for start/stop*/
   int ilen; /* length of input string */
   char istring[MAX_STR_LEN]; /* input string */
   int olen; /* location on output string */
   int icnt; /* location on string */

   olen = 0;
   strnset(string,'\0',MAX_STR_LEN); /* null entire output string */
   clen = strlen(comment_start);
   /* read in the line, verify that it exists */
   do{
      /* read in a line from the file */
      if(fgets(istring, MAX_STR_LEN, fspec) == NULL) /* output warning if not a valid read */
      {
#ifdef DEBUG
         printf ("\n***End of Input File in get_string, closing"); 
#endif
         fclose(fspec);
         return(FAIL);
      }
      ilen = strlen(istring); /* length of input string */

#ifndef MSDOS
      /* get rid of <cr><lf> in pc based machines */
#ifdef DEBUG
      printf("\nBefore: (%d) : %s",ilen,istring);
      printf("\n %d %d %d",istring[ilen],istring[ilen-1],istring[ilen-2]);
#endif
      if(istring[ilen-2] == '\x0d')
      {
#ifdef DEBUG
       printf("\n Replacing <cr><lf> with \n");
#endif
       istring[ilen-2] = '\n';
       istring[ilen-1] = '\0';
       ilen=strlen(istring);
      }
#ifdef DEBUG
      printf("\nAfter (%d) : %s",ilen,istring);
      printf("\n %d %d %d",istring[ilen],istring[ilen-1],istring[ilen-2]);
#endif
#endif
      istring[ilen]='\0';     /* null terminate the string */
      if(ilen < clen)         /* not possible to have comment on the line */
      {                       /* so output the string as is */
         strcpy(string,istring);
         olen = strlen(string);
      }
      else
      {
        /* strip comments out of input string */
        icnt=0;
        do{
          check = 1;
          if(icnt < ilen - clen)  /* make sure have enough characters for start of comment */
             check = strncmp(istring+icnt,comment_start,clen); /* check if start of comment */
          if(check == 0) /* comment found for standard c syntax */
          {
            /* find end of comment */
            icnt+=clen; /* advance past comment delimeter */
            clen=strlen(comment_stop); /* get length of end of comment delimeter */
            /* look for end of comment till end of string */
            do{
               check = 1;
               if(icnt < ilen - clen)  /* make sure have enough characters for end of comment */
               {
                  check = strncmp(istring+icnt, comment_stop,clen);
               }
               if(check != 0)  /* if not end of comment */
               {
                  icnt++; /* increment location on string */
                  if(icnt>ilen) /* if advance past end of string, get a new one */
                  {
                     if(fgets(istring, MAX_STR_LEN, fspec) == NULL) /* output warning if not a valid read */
                     {
                        printf ("\nERROR: Reading File, looking for end of comment %s",comment_stop);
                        fclose(fspec);
                        return(FAIL);
                     }
                     ilen = strlen(istring); /* get length of this new string */
#ifndef MSDOS
                     /* get rid of "newline" in pc based machines */
                     if(istring[ilen-2] == '\x0d')
                     {
#ifdef DEBUG
   printf("\n Removing _newline_ from pc based machines");
#endif
                        istring[ilen-2] = '\n';
                        istring[ilen-1] = '\0';
                        ilen=strlen(istring);
                     }
#endif
                     istring[ilen]='\0';     /* null terminate the string */
                     icnt = 0; /* reset the counter to the start of the string */
                  }
               }
               else
               {
                  icnt+=clen; /* advance past comment delimiter */
               }
            }while(check != 0); /* end of comment found */
          }  /* end if */
          else /* check if comment is in c++ format */
          {
             check = strncmp(istring+icnt, "//",2);
             if(check == 0) /* c++ style comment found */
             {  /* skip till end of string */
                icnt = ilen;
                string[olen]='\0';
             }
             else /* is a valid character for the string */
             {
                string[olen++] = istring[icnt++]; /* append value to the string */
                string[olen]='\0';
             }
          }
        }while(icnt < ilen          &&    /* do till end of string */
               olen < MAX_STR_LEN); /* and output string not too long */
        /* check for only carriage return (should have been caught above) */
        if(olen == 1 && (string[0] == '\0' || string[0] == '\n')){
         olen = 0;
/*         string[0] = '\0';*/
        }

      }  /* end else */
   }while(olen == 0); /* do till read in a string */
   if(olen == MAX_STR_LEN)
   {
      printf ("ERROR: Input line too long");
      fclose(fspec);
      return(FAIL);
   }
#ifdef DEBUG
   printf("\n get_string returns (%d): %s", strlen(string), string);
/*   printf("\n %c %c %c", string[strlen(string)],string[strlen(string)-1],string[strlen(string)-2]);
   printf("\n %d %d %d", string[strlen(string)],string[strlen(string)-1],string[strlen(string)-2]);
*/
#endif
   return(OK);
}
/* ***************************************************************************** */


