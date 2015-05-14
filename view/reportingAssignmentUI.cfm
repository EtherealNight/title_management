<html>
    <head>
        <title>First Title Reporting Assignment </title>
    </head>
    <body bgcolor="#CCCCCC">
    <cfsetting showdebugoutput="no">
    <!---Employee List Query--->
    <cfquery name="getAvailableEmployees" datasource="First_Title_Main_Dev"> <!---This query selects employee names from the First_Admin table then concatenates the names.--->
    SELECT fname + ' ' + lname AS Full_Name									 <!---SELECT Statement then concatenate the first and last name, aliased as column Full_Name--->
    FROM First_Admin														 <!---Table referenced is First_Admin--->
    </cfquery>
    
    <!---Employee Assigned Query--->
    <cfquery name="getAssignedEmployees" datasource="First_Title_Main_Dev">  <!---This query selects the assigned employees from the AssignedReports table--->
 	SELECT fname + ' ' + lname AS Full_Name									 <!---SELECT Statement then concatenate the first and last name, aliased as column Full_Name--->
    FROM AssignedReports												  	 <!---Table referenced is AssignedReports--->
    </cfquery>
    
    <!---Report Name Retrieval Query--->
     <cfquery name="getReports" datasource="First_Title_Main_Dev"> 			 <!---This query selects the assigned employees from the AssignedReports table--->
 	SELECT Report_Id, Report_Name											 <!---SELECT Statement then concatenate the first and last name, aliased as column Full_Name--->
    FROM Report_Master													  	 <!---Table referenced is AssignedReports--->
    </cfquery>
         <!---Application Control Pane--->
  <div id="right_div" style="position:fixed; width: 100%; background-color:#CCC; float:none;">
  
            <!---Application Control Pane Query--->
<cfquery name="qEmployeeAssignments" datasource="First_Title_Main_Dev">		<!---Control Grid Query. Grabs all employees assigned to a report--->
    SELECT fname + ' ' + lname AS Full_Name, reportName, reportDescrip      <!---Query criteria: first name, last name, reportName, reportDescrip --->
    FROM AssignedReports													<!--- Table being referenced --->
</cfquery>

     <!---This begins the visual component layout--->
     <div id="entire-page-div" style="position: relative; overflow: hidden; width:95%; margin-left:20px">
     <div id="left_module" style="position: relative; width: 30%; background-color:#CCC; float:left; margin-right:10px" >
     <label for="reportsList">Available Employees:</label>                 <!---This is the available employees list. Returns employees not assigned to a report--->
     <cfform name="assignedEmployees" action="getReport.cfm" width="20%">  <!---Form Initialization--->
     <cfselect name="employee" query="getAvailableEmployees"               <!---CFSELECT To populate form element from above Available Employee  query --->
     value="Full_Name" display="Full_Name" required="yes" size="10">       <!---CFSELECT To populate form element from above Available Employee  query --->
     </cfselect>
   	 </cfform>
     </div>
           
		   <!---     ---->
           <!---     ---->
           <!---     ---->
            
     <div id="center_div" style="position: relative; width: 30%; background-color:#CCC; float:left;">
     <!---Assigned Employees Module---> 
	 <label for="reportsList">Assigned Employees:</label>
     <cfform name="assignedEmployees" action="getReport.cfm" width="25%">    <!---Assigned Employee Form Initialization--->
   	 <cfselect name="employee" query="getAssignedEmployees"                  <!---CFSELECT To populate form element from above Employee Assignment query --->
     value="Full_Name" display="Full_Name" required="yes" size="10">		 <!---CFSELECT To populate form element from above Employee Assignment query --->
     </cfselect>
   	 </cfform>
     </div>
            
          <!---     ---->
          <!---     ---->
          <!---     ---->
          
     <div id="right_div" style="position: relative; width: 25%; background-color:#CCC; float: left;">
     <!---Report List Module --->											
     <label for="reportsList">Reports List:</label>
     <cfform name="assignedEmployees" action="getReport.cfm" width="20%">	<!---Report List Form Initialization--->
     <cfselect name="employee" query="getReports" 							<!---CFSELECT To populate form element from above Get Report query--->
     value="Report_Name" display="Report_Name" required="yes" size="10">    <!---CFSELECT To populate form element from above Get Report query--->
     </cfselect>
   	 </cfform>
     </div>            
     </div>
    <br/>
        <br/>
         <br/>
        <br/>
        
             

<!---Tabbed layout controller for all tabbed layout components ---> 
<cflayout type="tab" tabheight="100" name="mytabs">							<!---Initialization for tab navigation layout--->
<cflayoutarea title="Employee Perspective" name="t1"> 						<!---First Tab navigation pane initialization--->
<cfform>																	<!---CF form initialization --->
    <cfgrid  																<!---CF datagrid initialization--->
        name="AssignedEmployees"                                            <!--- -------Attributes---------- --->
        align="Top" 														<!---            |               --->
        autoWidth="yes" 													<!---            |               --->
        bgColor="FFF"														<!---            |               --->
        colHeaderBold="yes" 												<!---            |               --->
        format="html"														<!---            |               --->
        gridDataAlign="left" 												<!---            |               --->
        gridLines="yes" 													<!---            |               --->
        query="qEmployeeAssignments" 										<!---            |               --->
        sort="yes" 															<!---            |               --->
        stripeRowColor="FC6" 												<!---            |               --->	
        stripeRows="yes"													<!---            |               --->
        width="900" height="500"> 											<!---    End of Attributes       --->
         
        <cfgridcolumn name="Full_Name" header="Employee Name" 			    <!---Datagrid column. Mapped to the First and Last Names in the query--->
        display="yes" width="300" />
        <cfgridcolumn name="reportName" header="Report Name" 				<!---Datagrid column. Mapped to the First and Last Names in the query--->
        hrefKey="videogameid" target="_blank" width="300" />
        <cfgridcolumn name="reportDescrip" header="Report Description"      <!---Datagrid column. Mapped to the First and Last Names in the query--->
        dataalign="center" type="date" width="300" />       
    </cfgrid>
    </cfform>
     </cflayoutarea>
     <cflayoutarea title="Reporting Perspective" name="t2"> 			    <!---First Tab navigation pane initialization--->
<cfform>																	<!---CF form initialization --->
    <cfgrid  																<!---CF datagrid initialization--->
        name="ReportsToEmployees"                                           <!--- -------Attributes---------- --->
        align="Top" 														<!---            |               --->
        autoWidth="yes" 													<!---            |               --->
        bgColor="FFF"														<!---            |               --->
        colHeaderBold="yes" 												<!---            |               --->
        format="html"														<!---            |               --->
        gridDataAlign="left" 												<!---            |               --->
        gridLines="yes" 													<!---            |               --->
        query="qEmployeeAssignments" 										<!---            |               --->
        sort="yes" 															<!---            |               --->
        stripeRowColor="FC6" 												<!---            |               --->	
        stripeRows="yes"													<!---            |               --->
        width="900" height="500"> 											<!---    End of Attributes       --->
         
        <cfgridcolumn name="reportName" header="Report Name" 				<!---Datagrid column. Mapped to the First and Last Names in the query--->
        hrefKey="videogameid" target="_blank" width="300" />
        <cfgridcolumn name="Full_Name" header="Employee Name" 			    <!---Datagrid column. Mapped to the First and Last Names in the query--->
        display="yes" width="300" />
        <cfgridcolumn name="reportDescrip" header="Report Description"      <!---Datagrid column. Mapped to the First and Last Names in the query--->
        dataalign="center" type="date" width="300" />       
    </cfgrid>
    </cfform>
     </cflayoutarea>
    </cflayout>
   

</div>
</body>
</html>
