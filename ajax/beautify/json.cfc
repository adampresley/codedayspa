<cfcomponent extends="Basis.Service" output="false">

	<cffunction name="process" output="false">
		<cfset var jsonToParse = "" />
		<cfset var result = { output = "" } />

		<cfset var JSON = "" />
		<cfset var serializer = "" />

		<cfparam name="rc.grid" default="false" />

		<cfif len(trim(rc.jsonUrl))>
			<cfhttp url="#rc.jsonUrl#"></cfhttp>
			<cfset jsonToParse = CFHTTP.fileContent />
		<cfelse>
			<cfset jsonToParse = rc.jsonString />
		</cfif>

		<cfif !rc.grid>
			<cfif trim(left(jsonToParse, 1)) EQ "[">
				<cfset JSON = createObject("java", "net.sf.json.JSONArray") />
				<cfset serializer = JSON.fromObject(jsonToParse) />

				<cfset result.output = htmlCodeFormat(serializer.toString(3, 0)) />
			<cfelse>
				<cfset JSON = createObject("java", "net.sf.json.JSONObject") />
				<cfset serializer = JSON.fromObject(jsonToParse) />

				<cfset result.output = htmlCodeformat(serializer.toString(3, 0)) />
			</cfif>
		<cfelse>
			<cfset result.output = jsonToParse />
		</cfif>

		<cfreturn result />
	</cffunction>

</cfcomponent>