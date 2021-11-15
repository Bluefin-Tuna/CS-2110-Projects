/* DO NOT REMOVE INCLUDES - Do NOT add your own */
#include "part2-calendar.h"

/* GLOBAL CALENDAR ARRAY */
date calendar_2021[NUM_DAYS];


extern int find_calendar_index(date d);
extern int monthHelper(int month);
extern int check_Times(event e1);
extern int time2min(time t);
extern void validate_Events(date d);
/**
 * @brief Initialize the entire calendar
 *            Set each date in calendar_2021 to the correct month, day, and year.
 *            Also, set each date's num_events value 
 * september april june and november
 */
void initialize_calendar(void){
    int index = 0;
    for (int month = 1; month < 13; month++){
        if (month == 9 || month == 4 || month == 11 || month == 6) {
            for (int day = 1; day < 31; day++) {
                date toAdd;
                toAdd.year = 2021;
                toAdd.month = month;
                toAdd.day = day;
                toAdd.num_events = 0;
                calendar_2021[index++] = toAdd;
            }
        } else if (month == 2) {
            for (int day = 1; day < 29; day++) {
                date toAdd;
                toAdd.year = 2021;
                toAdd.month = month;
                toAdd.day = day;
                toAdd.num_events = 0;
                calendar_2021[index++] = toAdd;
            }
        } else {
            for (int day = 1; day < 32; day++) {
                date toAdd;
                toAdd.year = 2021;
                toAdd.month = month;
                toAdd.day = day;
                toAdd.num_events = 0;
                calendar_2021[index++] = toAdd;
            }
        }
    }
    printf("%i\n",index);
    return;
}

/**
 * @brief Compare the times of two events and determine if they 'overlap'
 *             See PDF section - Calendar Conditions - for how we define 'overlap'
 * 
 * @param e1 event 1
 * @param e2 event 2
 * @return int SUCCESS or ERROR
 */
int check_event_overlap(event e1, event e2){
    // 1:00 -1:10 1:05 - 1:30
    // If either event starts in the hours before the other ends
    int e1s = time2min(e1.start);
    int e1e = time2min(e1.end);
    int e2s = time2min(e2.start);
    int e2e = time2min(e2.end);
    if ((e1e >= e2e && e1s <= e2e) || (e2e >= e1e && e2s <= e1e)) return ERROR;
    return SUCCESS;
}


/**
 * @brief Add new event to the calendar on the specified date.
 *             Remember event times canNOT overlap
 *             Consider using your check_event_overlap() function
 * 
 * @param d used to locate the date's index in calendar_2021
 * @param new_event event being added
 * @return int SUCCESS or ERROR
 */
int add_calendar_event(date d, event new_event){
    
    /* Remove once the function is implemented */
    
    int index = find_calendar_index(d);
    if (index > 364) return ERROR;
    date tmp = calendar_2021[index];
    validate_Events(d);
    if (tmp.num_events >= 10) return ERROR;
    if (check_Times(new_event) == ERROR) return ERROR;
    for (int i = 0; i < tmp.num_events; i++) {
        if (check_event_overlap(new_event,tmp.events[i]) == ERROR) return ERROR;
    }   
    calendar_2021[index].events[tmp.num_events] = new_event;
    calendar_2021[index].num_events = tmp.num_events + 1;
    return SUCCESS;   
}




/**
 * @brief Remove an event from the specified date.
 *             Remember to shift any subsequent events 'up' in the array
 * 
 *  EX:
 *      Remove Event at index 2:
 *          - [e1, e2, e3, e4, e5]
 *          - [e1, e2, e4, e5]
 * 
 * @param d used to locate the date's index in calendar_2021
 * @param event_index index of the event to remove
 * @return int SUCCESS or ERROR
 */
int remove_calendar_event(date d, int event_index){
    validate_Events(d);
    
    int index = find_calendar_index(d);
    date tmp = calendar_2021[index];
    if(event_index > tmp.num_events - 1) return ERROR;
    if (event_index == tmp.num_events - 1) {
        calendar_2021[index].num_events--; 
        return SUCCESS;
    }

    for(int i = event_index; i < tmp.num_events-1; i++) {
        calendar_2021[index].events[i] = calendar_2021[index].events[i+1];
    }
    calendar_2021[index].num_events--; 
    return SUCCESS;
}

/**
 * @brief Modify a specific event's start time and end time
 * 
 * @param d used to locate the date's index in calendar_2021
 * @param event_index index of the event to modify
 * @param start new event start time
 * @param end new event end time
 * @return int SUCCESS or ERROR
 */
int change_event_time(date d, int event_index, time start, time end){

    validate_Events(d);
    event e;
    e.start = start;
    e.end = end; 
    if (check_Times(e) == ERROR) return ERROR; //invalid times
    int index = find_calendar_index(d);
    date tmp = calendar_2021[index];
    if(event_index > tmp.num_events - 1) return ERROR; //invalid event_index

    calendar_2021[index].events[event_index].start = start;
    calendar_2021[index].events[event_index].end = end;

    return SUCCESS;
}

/**
 * @brief Modify a specifc event's description string
 * 
 * @param d used to locate the date's index in calendar_2021
 * @param event_index index of the event to modify
 * @param description new string to copy into the event's description
 * @return int SUCCESS or ERROR
 */
int change_event_description(date d, int event_index, char description[SIZE_DESCRIPTION]){
    validate_Events(d);
    int index = find_calendar_index(d);
    date tmp = calendar_2021[index];
    if(event_index > tmp.num_events - 1) return ERROR; //invalid event_index

    for (int i = 0; i < SIZE_DESCRIPTION; i++) {
        calendar_2021[index].events[event_index].description[i] = description[i];
    }
    


    return SUCCESS;
}

/**
 * @brief Sort a date's event array by start time (earliest time to latest time)
 * Using Selection Sort
 * @param d used to locate the date's index in calendar_2021
 */
void sort_events(date d){
    validate_Events(d);
    int index = find_calendar_index(d);
    date tmp = calendar_2021[index];
    
    for (int i = 0; i < tmp.num_events - 1; i++) {
        int minInd = i;
        for (int j = i+1; j < tmp.num_events; j++) {
            int startcmp = time2min(calendar_2021[index].events[j].start);
            int startorg = time2min(calendar_2021[index].events[minInd].start);
            if (startcmp < startorg) {
                minInd = j;
            }
        }
        event etmp = calendar_2021[index].events[minInd];
        calendar_2021[index].events[minInd] = calendar_2021[index].events[i];
        calendar_2021[index].events[i] = etmp;
    }
    
}

/**
 * @brief Destroy the calendar - set each calendar date month, day, year, and num_events to 0
 */
void destroy_calendar(void){
    date d; //Instantiate empty date
    d.day = 0;
    d.month = 0;
    d.year = 0;
    d.num_events = 0;
    for (int i = 0; i < NUM_DAYS; i++) {
        calendar_2021[i] = d;
    }
}




/* -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------ HELPER FUNCTIONS--------------------------------------------------------------------------------*/
/**
* Validates that a given day's events are indeed all valid, to counteract bad data automatically populated by testcases. Removes the event if event is invalid
*/
void validate_Events(date d) {
    int index = find_calendar_index(d);
    date tmp = calendar_2021[index];
    int i = 0;
    int lastValidIndex = 0;
    while (i < tmp.num_events) {
        if(check_Times(tmp.events[i]) == ERROR) {
            remove_calendar_event(d,i);
            i = lastValidIndex;
        } else {
            lastValidIndex = i++;
        }
    }
}

/**
* Checks if event time is valid (start happens before end)
*
*/
int check_Times (event e1){
    int startmin = time2min(e1.start);
    int endmin = time2min(e1.end);
    if (startmin < endmin) return SUCCESS;
    else return ERROR;
}    
/**
* Finds the index in calendar_2021 based on the date given
*/
int find_calendar_index(date d) {
    int retVal;
    retVal = d.day;
    retVal = retVal + monthHelper(d.month - 1);
    return retVal - 1;
}

/**
* Recursive method that finds the number of days that have passed based on the months full elapsed. For example,
* If the date is 3/11, we have only fully elapsed two months, 1 and 2, so the arg month passed will be 3-1 = 2;
* Essentially, month is the date month -1
*/
int monthHelper(int month) {
    int daysIn;
    if (month == 9 || month == 4 || month == 11 || month == 6) {
        daysIn = 30;
    } else if (month == 2) {
        daysIn = 28;
    } else if (month == 0) {
        return 0;
    } else {
        daysIn = 31;
    }
    return  monthHelper(month - 1) + daysIn;
}

/**
* Converts a time struct to an integer minute representation. This greatly simplifies the comparison process when checking for overlaps
*/
int time2min(time t) {
    return t.hour*60+t.minute;
}
