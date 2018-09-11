prompt PL/SQL Developer import file
prompt Created on Tuesday, January 17, 2017 by nako02141
set feedback off
set define off
prompt Disabling triggers for TMO_GLREVENUECODEMAP...
alter table TMO_GLREVENUECODEMAP disable all triggers;
prompt Deleting TMO_GLREVENUECODEMAP...
delete from TMO_GLREVENUECODEMAP;
commit;
prompt Loading TMO_GLREVENUECODEMAP...
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('Long Distance Discount', 'TOLL Long Distance', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('Special Incentive', 'Special Incentive', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('V Adjustment', 'Misc Adjustment - M2M', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('V Call Support Overage', 'V Call Support Overage', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('V Adj Airtime - VAR', 'Adj Airtime Usage - M2M', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('V Adj Subscriber Roaming - VAR', 'V Adj Subscriber Roaming - VAR', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('V Volume Discount', 'AVD', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('V Adj SMS Usage - VAR', 'Adj SMS Usage - M2M', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('V Adj GPRS Usage - VAR', 'Adj GPRS Usage - M2M', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('V Adj Intl GPRS- VAR', 'Adj Intl GPRS Usage - M2M', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('V Adj Intl SMS - VAR', 'Adj Intl SMS Usage - M2M', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('V Adj Intl Voice - VAR', 'Adj Intl Voice Usage - M2M', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('V Adj Intl Roaming GPRS - VAR', 'Adj Intl Roaming GPRS Usage - M2M', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('V Adj Intl Roaming SMS - VAR', 'Adj Intl Roaming SMS Usage - M2M', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('V Adj Intl Roaming Voice - VAR', 'Adj Intl Roaming Voice Usage - M2M', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('V Adj MRC  - VAR', 'Adj  MRC - M2M', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('V Premium Service Charge Adj.- VAR', 'Adj Premium Service Charge - M2M', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('V Courtesy Adjustment', 'Adj Courtesy - M2M', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('Undefined', 'Undefined', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('Adjustment', 'Adjustment', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('Call Support Overage', 'Call Support Overage', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('Product Discount Amounts', 'Product Charges', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('Package Discount Amounts', 'Discount', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('Product Charges', 'Product Charges', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('Adj Airtime - Wholesale', 'Adj Airtime - Wholesale', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('Adj Subscriber Roaming - Wholesale', 'Adj Subscriber Roaming - Wholesale', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('Adj Toll - Wholesale', 'Adj Toll - Wholesale', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('Adj SMS Usage - Wholesale', 'Adj SMS Usage - Wholesale', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('Adj GPRS Usage - Wholesale', 'Adj GPRS Usage - Wholesale', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('Adj MMS Usage - Wholesale', 'Adj MMS Usage - Wholesale', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('Adj Other Service Fee Revenue -Wholesale', 'Adj Other Service Fee Revenue -Wholesale', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('Discount', 'Discount', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('REV Offset', 'REV Offset', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('0_#N/A', '1_Service Tax-Oth', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('2_Utility Users Tax', '2_Utility Users Tax', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('4_Business & Occupation Tax', '4_Business & Occupation Tax', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('2_911 Tax', '2_911 Tax', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('2_PUC Tax', '2_PUC Tax', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('3_Telephone Sales Tax', '3_Telephone Sales Tax', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('2_Statutory Gross Receipts Tax', '2_Statutory Gross Receipts Tax', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('3_Utility Users Tax Business', '3_Utility Users Tax Business', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('2_License Tax', '2_License Tax', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('4_Service Tax', '4_Service Tax', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('2_District Tax', '2_District Tax', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('4_911 Tax Business', '4_911 Tax Business', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('2_T-Mobile Customized', '2_T-Mobile Customized', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('1_Universal Service Fund Surcharge WN', '1_Universal Service Fund Surcharge WN', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('2_Universal Service Fund Surcharge WN', '2_Universal Service Fund Surcharge WN', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('1_Telecoms Relay Service Surcharge WN', '1_Telecoms Relay Service Surcharge WN', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('2_Telecoms Relay Service Surcharge WN', '2_Telecoms Relay Service Surcharge WN', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('2_DEAF Surcharge', '2_DEAF Surcharge', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('2_High Cost Fund Surcharge', '2_High Cost Fund Surcharge', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('2_Poison Control Surcharge', '2_Poison Control Surcharge', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('2_Lifeline', '2_Lifeline', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('4_Excise Tax', '4_Excise Tax', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('1_Special Tax', '1_Special Tax', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('3_Surcharge', '3_Surcharge', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('2_License Tax Wireless', '2_License Tax Wireless', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('4_Utility Users Tax Business, Wireless', '4_Utility Users Tax Business, Wireless', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('2_Utility Users Tax, Wireless', '2_Utility Users Tax, Wireless', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('4_Business & Occupation Tax Wireless', '4_Business & Occupation Tax Wireless', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('2_911 Tax Wireless', '2_911 Tax Wireless', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('3_Statutory Gross Receipts Tax Wireless', '3_Statutory Gross Receipts Tax Wireless', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('1_Universal Service Fund Surcharge WS', '1_Universal Service Fund Surcharge WS', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('2_Telecoms Relay Service Surcharge WS', '2_Telecoms Relay Service Surcharge WS', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('2_DEAF Surcharge Wireless', '2_DEAF Surcharge Wireless', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('2_High Cost Fund Surcharge Wireless', '2_High Cost Fund Surcharge Wireless', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('2_Poison Control Surcharge Wireless', '2_Poison Control Surcharge Wireless', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('1_Federal Excise Tax', '1_Federal Excise Tax', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('2_Sales Tax', '2_Sales Tax', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('V 36 Month Tax', 'GPRS MRC Advance', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('V 24 Month Tax', 'GPRS MRC Advance', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('V 12 Month Tax', 'GPRS MRC Advance', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('V 36 Month Charge', 'GPRS MRC Advance', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('V 24 Month Charge', 'GPRS MRC Advance', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('V 12 Month Charge', 'GPRS MRC Advance', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('Gross Activation', 'Gross Activation', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('Miscellanous Adjustment Revenue Code', 'Misc Adjustment', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('Monthly Minimum Payment Guarantee', 'Suspend', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('Minimum Payment Guarantee', 'Monthly Minimum Payment', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('Adj Intl Roaming Voice - MVNO', 'Adj Subscriber Roaming - Wholesale', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('Adj Intl Roaming SMS - MVNO', 'Adj SMS Usage - Wholesale', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('Adj Intl Roaming GPRS - MVNO', 'Adj GPRS Usage - Wholesale', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('V 12 Month Reverse', 'GPRS MRC Advance', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('V 24 Month Reverse', 'GPRS MRC Advance', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('V 36 Month Reverse', 'GPRS MRC Advance', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('Recovery Fee', 'Recovery Fee', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('Excise Tax', 'Excise Tax', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('Adj Voice Roaming', 'Discount - Voice Roaming', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('Adj SMS Roaming', 'Discount - SMS Roaming', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('V Adjustment 20 ', 'Test Ajay2', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('V Event Discount Amounts', 'EXP - 10 Free Voice - Home _AJAY_KUMAR', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('TEST', 'TEST', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('Other Service Fee Revenue', 'Other Service Fee Revenue', null);
insert into TMO_GLREVENUECODEMAP (REVENUE_CODE_NAME, LINE_ITEM_TEXT, CREDIT)
values ('SudZ Revenue Code', 'SudZ Line item text', null);
commit;
prompt 95 records loaded
prompt Enabling triggers for TMO_GLREVENUECODEMAP...
alter table TMO_GLREVENUECODEMAP enable all triggers;
set feedback on
set define on
prompt Done.
