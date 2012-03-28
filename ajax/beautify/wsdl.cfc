<cfcomponent extends="Basis.Service" output="false">

	<cffunction name="process" output="false">
		<cfset var beautifier = application.theFactory.getService("Beautifier") />
		<cfset var result = { output = beautifier.wsdlXmlToHtml(rc.wsdlUrl) } />

		<cfreturn result />
	</cffunction>

</cfcomponent>