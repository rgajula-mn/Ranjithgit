update TMOBILE_CUSTOM.TMO_DISPADJ_EVENTMAPPING set new_event_type_id= DECODE ( event_type_id, 24,46, 7,39, 31,38, 30,34, 5,33, 32,36, 27,45, 26,44,
8,35, 6,37,
25,43,event_type_id ) ;
commit;
