*** Settings ***
Library    Selenium2Library
Library    DatabaseLibrary
Variables    ../config/db_config.yaml 
Variables    ../config/queries.yaml  

*** Keywords ***
Connect To MySQLDB
    Connect To Database    ${database.api_module}    ${database.name}    ${database.user}    ${database.password}    ${database.host}    ${database.port}
    
Get All Data From Table
    Execute Sql String    ${queries.use_db}    
    @{resultset}=     Query    Select * from employee;
    # @{results}=    Get Text    @{resultset}
    Log    @{resultset}[0]
    Should Be Equal As Strings    ${resultset}    <class,list> 
    Log To Console   @{resultset}     
    
Create person table
    Execute Sql String    ${queries.use_db} 
    ${output} =    Execute SQL String    CREATE TABLE personnew (id integer unique,first_name varchar(10), last_name varchar(10));
    Log    ${output}
    Should Be Equal As Strings    ${output}    None  
    
    
        
    
*** Test Cases ***
Connect DB
    Connect To MySQLDB
    
Get Data From Employee
    Connect To MySQLDB
    Get All Data From Table
    # @{var}=     Execute Sql String    Show databases;   
    # Log    ${var}    
    
    Disconnect From Database 
    
Create Table Person
    Connect To MySQLDB
    Create person table
    Disconnect From Database          