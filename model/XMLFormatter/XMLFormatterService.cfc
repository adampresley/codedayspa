<cfcomponent extends="Basis.Service" output="false">

	<cffunction name="xmlStringToHtml" output="false">
		<cfargument name="input" type="string" required="true" />

		<cfset var stream = createObject("java", "javax.xml.transform.stream.StreamSource").init(
			createObject("java", "java.io.StringReader").init(arguments.input)
		) />
		<cfset var writer = createObject("java", "java.io.StringWriter").init() />
		<cfset var xmlOutput = createObject("java", "javax.xml.transform.stream.StreamResult").init(writer) />

		<cfset var transformerFactory = createObject("java", "javax.xml.transform.TransformerFactory").newInstance() />
		<cfset var transformer = transformerFactory.newTransformer() />

		<cfset transformer.setOutputProperty("indent", "yes") />
		<cfset transformer.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "3") />
		<cfset transformer.transform(stream, xmlOutput) />

		<cfreturn xmlOutput.getWriter().toString() />
	</cffunction>

</cfcomponent>