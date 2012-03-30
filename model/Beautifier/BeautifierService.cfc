<cfcomponent extends="Basis.Service" output="false">

	<cffunction name="jsonStringToHtml" access="public" output="false">
		<cfargument name="input" type="string" required="true" />

		<cfset var JSON = "" />
		<cfset var serializer = "" />
		<cfset var result = "" />

		<cfif trim(left(arguments.input, 1)) EQ "[">
			<cfset JSON = createObject("java", "net.sf.json.JSONArray") />
		<cfelse>
			<cfset JSON = createObject("java", "net.sf.json.JSONObject") />
		</cfif>

		<cfset serializer = JSON.fromObject(arguments.input) />

		<cfset result = htmlCodeFormat(serializer.toString(3, 0)) />
		<cfset result = reReplaceNoCase(result, "<pre\s*>", "<pre class=""prettyprint lang-js"">", "ALL") />

		<cfreturn result />
	</cffunction>


	<cffunction name="wsdlXmlToHtml" access="public" output="false">
		<cfargument name="inputUrl" type="string" required="true" />

		<cfset var wsdlParsed = application.theFactory.getService("WSDLParser").parseWSDL(arguments.inputUrl) />
		<cfset var result = "" />

		<cfset var service = "" />
		<cfset var port = "" />
		<cfset var operation = "" />

		<cfsavecontent variable="result"><cfoutput>
			<cfloop array="#wsdlParsed#" index="service">
				<h2>#service.name#</h2>

				<cfloop array="#service.ports#" index="port">
					<h3>Port: #port.name#</h3>

					<ul><cfloop array="#port.operations#" index="operation">
						<li><em>#operation.method.returnType#</em> <strong>#operation.method.methodName#</strong>(<em>#operation.method.argumentList#</em>)</li>
					</cfloop></ul>

					<br />
				</cfloop>
			</cfloop>
		</cfoutput></cfsavecontent>
		
		<cfreturn result />
	</cffunction>


	<cffunction name="sqlStringToHtml" output="false">
		<cfargument name="input" type="string" required="true" />

		<cfset var formatter = createObject("java", "blanco.commons.sql.format.BlancoSqlFormatter").init(
			createObject("java", "blanco.commons.sql.format.BlancoSqlRule").init()
		) />

		<cfset var result = htmlCodeFormat(formatter.format(arguments.input)) />
		<cfset result = reReplaceNoCase(result, "<pre\s*>", "<pre class=""prettyprint lang-sql"">", "ALL") />
		<cfreturn result />
	</cffunction>
	
</cfcomponent>