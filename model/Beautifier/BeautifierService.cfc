<cfcomponent extends="Basis.Service" output="false">

	<cffunction name="jsonStringToHtml" access="public" output="false">
		<cfargument name="input" type="string" required="true" />

		<cfset var JSON = "" />
		<cfset var serializer = "" />

		<cfif trim(left(arguments.input, 1)) EQ "[">
			<cfset JSON = createObject("java", "net.sf.json.JSONArray") />
		<cfelse>
			<cfset JSON = createObject("java", "net.sf.json.JSONObject") />
		</cfif>

		<cfset serializer = JSON.fromObject(arguments.input) />
		<cfreturn htmlCodeFormat(serializer.toString(3, 0)) />
	</cffunction>

</cfcomponent>