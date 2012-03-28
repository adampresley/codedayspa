<!---
	Class: ajaxProxy
	This is an example AJAX proxy that has fake validation for a logged in user.
	In real life you would put in your own validation to ensure that the AJAX caller
	is valid in your system.
--->
<cfcomponent extends="Basis.AjaxProxy" output="false">
	
	<cffunction name="onAjaxError" access="private" output="false">
		<cfargument name="errorInfo" />

		<cfset writeLog(
			text = "ACTION = #request.rc.action# : #arguments.errorInfo.message#",
			type = "Error",
			log = "application"
		) />

		<cfheader statusCode="500" statusText="Internal Server Error" />
		<cfreturn {
			"message" = "An error occurred: #arguments.errorInfo.message#",
			"success" = false
		} />
	</cffunction>

</cfcomponent>
