<cffunction name="loadModel" output="false">
	<cfargument name="category" type="string" required="true" />
	<cfargument name="name" type="string" required="true" />

	<cfinclude template="/#application.frameworkSettings.modelPath#/#arguments.category#/#arguments.name#.cfm" />
</cffunction>
