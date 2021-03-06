<cfcomponent extends="Basis.App" output="false">
	
	<cfset this.name = "codedayspa_0_1" />
	<cfset this.applicationTimeout = createTimeSpan(1, 0, 0, 0) />
	<cfset this.clientManagement = false />
	<cfset this.sessionManagement = false />
	
	<cfset variables.frameworkSettings.reloadFrameworkEveryRequest = false />
	<cfset variables.frameworkSettings.flushBufferBeforeOutput = true />
	<cfset variables.frameworkSettings.removeIndexCfm = true />
	
	<!---
		Register MongoDB
	<cfset application.dbName = "codedayspa" />
	<cfset mongoRegister(name = "codedayspa", server = "127.0.0.1", db = application.dbName) />
	--->

	<cffunction name="applicationStart" output="false">
		<cfset application.version = "0.1" />
	</cffunction>

</cfcomponent>