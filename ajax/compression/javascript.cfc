<cfcomponent extends="Basis.Service" output="false">

	<cffunction name="process" output="false">
		<cfset var jsToParse = "" />
		<cfset var result = { output = "" } />
		<cfset var beautifier = application.theFactory.getService("Beautifier") />

		<cfparam name="rc.grid" default="false" />

		<cfif len(trim(rc.jsonUrl))>
			<cfhttp url="#rc.jsonUrl#"></cfhttp>
			<cfset jsonToParse = CFHTTP.fileContent />
		<cfelse>
			<cfset jsonToParse = rc.jsonString />
		</cfif>

		<cfif !rc.grid>
			<cfset result.output = beautifier.jsonStringToHtml(jsonToParse) />
		<cfelse>
			<cfset result.output = jsonToParse />
		</cfif>

		<cfreturn result />
	</cffunction>

</cfcomponent>