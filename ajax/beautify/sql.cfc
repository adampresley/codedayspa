<cfcomponent extends="Basis.Service" output="false">

	<cffunction name="process" output="false">
		<cfset var result = { output = "" } />
		<cfset var beautifier = application.theFactory.getService("Beautifier") />

		<cfset result.output = beautifier.sqlStringToHtml(rc.sqlString) />
		<cfreturn result />
	</cffunction>

</cfcomponent>