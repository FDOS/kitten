
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../kitten.h"

#define MSG1 "A message that must not be replaced by the Spanish nls\n"
#define MSG2 "A message that must be replaced by the Spanish nls\n"
#define MSG3 "Look in the second class for the second message"
#define RSP3 "Quiero leer el mensaje"

// Please excuse the lack of an opening question mark on Spanish translation
#define MSG4 "Really delete this message (Y/N)? "
#define RSP4 "De verdad borrar este mensaje (S/N)? "
#define KEY4 "SN"


int main(void) {

  nl_catd cat;
  const char *m;
  char tmpstr[10];

  putenv("NLSPATH=test\\nls");
  putenv("LANG=es");

  cat = catopen("test", 0);

  m = catgets(cat, 2, 1, MSG1);
  if (strcmp(MSG1, m) != 0) {
    puts("FAIL: MSG1 was incorrectly replaced");
    return 1;
  }

  m = catgets(cat, 0, 2, MSG2);
  if (strcmp(MSG2, m) == 0) {
    puts("FAIL: MSG2 was not replaced");
    return 1;
  }

  m = catgets(cat, 1, 1, MSG3);
  if (strcmp(MSG3, m) == 0) {
    puts("FAIL: MSG3 was not replaced");
    return 1;
  }
  if (strcmp(RSP3, m) != 0) {
    puts("FAIL: MSG3 was not replaced with correct Spanish");
    return 1;
  }

  m = catgets(cat, 3, 0, MSG4);
  if (strcmp(MSG4, m) == 0) {
    puts("FAIL: MSG4 was not replaced");
    return 1;
  }
  if (strcmp(RSP4, m) != 0) {
    puts("FAIL: MSG4 was not replaced with correct Spanish");
    return 1;
  }
  if (!kitten_extract_response(m, "(/)", tmpstr, 2)) {
    puts("FAIL: RSP4 was not parsed");
    return 1;
  }
  if (tmpstr[0] != 'S' || tmpstr[1] != 'N') {
    puts("FAIL: RSP4 was not parsed correctly");
    return 1;
  }

  if (!kitten_extract_response("Choose [A:B:C:D]", "[:]", tmpstr, 4)) {
    puts("FAIL: \"Choose [A:B:C:D]\" was not parsed");
    return 1;
  }
  if (tmpstr[0] != 'A' || tmpstr[1] != 'B' || tmpstr[2] != 'C' || tmpstr[3] != 'D') {
    puts("FAIL: \"Choose [A:B:C:D]\" was not parsed correctly");
    return 1;
  }

  catclose(cat);
  puts("PASS: Tests completed");
  return 0;
}
