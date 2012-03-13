<cfset reader = createObject("java", "com.ibm.wsdl.factory.WSDLFactoryImpl").newWSDLReader() />
<cfset path = "http://www.webservicex.net/CurrencyConvertor.asmx?WSDL" />
<cfset def = reader.readWSDL(path) />

<cfoutput>

	<cfset portTypes = def.getPortTypes() />
	<cfdump var="#portTypes.keySet().iterator()#" expand="false" label="" />

	<cfset iterator = portTypes.keySet().iterator() />
	<cfloop condition="iterator.hasNext()">
		<cfset key = iterator.next() />

		<h3>#key#</h3>
		<cfset port = def.getPortType(createObject("java", "javax.xml.namespace.QName").init(key)) />
		<cfdump var="#port#" />
	</cfloop>

	<cfabort	/>

	<cfloop collection="portTypes" item="key">
		<cfset operations = port.getOperations() />

		<h3>#key#</h3>
		<cfloop array="#operations#" index="operation">
			<cfdump var="#operation#" expand="false" label="" />
		</cfloop>
	</cfloop>

	<cfdump var="#def#" expand="false" label="" />

</cfoutput>