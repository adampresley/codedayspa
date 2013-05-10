<cfcomponent extends="Basis.Service" output="false">

	<cffunction name="compressJavaScript" access="public" output="false">
		<cfargument name="input" type="string" required="true" />

		<cfscript>
			/*
			 * First write the JavaScript string to a temporary directory. Then
			 * run the YUI compressor against it.
			 */
			var path = writeToTempFile(input=arguments.input);

		</cfscript>
	</cffunction>

	<cffunction name="writeToTempFile" access="public" output="false">
		<cfargument name="input" type="string" required="true" />

		<cfscript>
			var path = getTempFile(getTempDirectory(), "codedayspa");

			fileWrite(path, arguments.input);
			return path;
		</cfscript>
	</cffunction>

</cfcomponent>