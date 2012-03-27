<!---
	Class: ajaxProxy
	This is an example AJAX proxy that has fake validation for a logged in user.
	In real life you would put in your own validation to ensure that the AJAX caller
	is valid in your system.
--->
<cfcomponent extends="Basis.AjaxProxy" output="false">
	
	<cffunction name="onAjaxError" access="private" output="false">
		<cfargument name="errorInfo" />

		<cfdump var="#arguments.errorInfo#" />
		<cfabort />
		<cfreturn {
			"message" = "Custom error handler: #arguments.errorInfo.message#",
			"success" = false
		} />
	</cffunction>

</cfcomponent>
