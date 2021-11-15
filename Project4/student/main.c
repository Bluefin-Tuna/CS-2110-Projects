/* DO NOT REMOVE INCLUDES - Do NOT add your own */
#include "part1-porting_assembly.h"
#include "part2-calendar.h"

int main(void) {

    /* Call your part1 and part2 functions here if you would like to test them yourself */
    time e1s;
    time e1e;
    time e2s;
    time e2e;

    e1s.hour = 1;
    e1s.minute = 0;
    e1e.hour = 1;
    e1e.minute = 10;
    e2s.hour = 1;
    e2s.minute = 15;
    e2e.hour = 3;
    e2e.minute = 15;

    event e1;
    event e2;
    e1.start = e1s;
    e1.end = e1e;
    e2.start = e2s;
    e2.end = e2e;

    printf("%d\n",check_event_overlap(e1,e2));
}

