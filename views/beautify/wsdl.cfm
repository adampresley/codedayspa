<cfset reader = createObject("java", "com.ibm.wsdl.factory.WSDLFactoryImpl").newWSDLReader() />
<cfset path = "http://www.webservicex.net/CurrencyConvertor.asmx?WSDL" />
<cfset def = reader.readWSDL(null, path) />

<cfoutput>

	<cfset services = def.getServices() />

	<cfif !isNull(services)>
		<h4>Services</h4>
		<cfdump var="#services#" />

		<cfset iterator = services.values().iterator() />
		<cfloop condition="iterator.hasNext()">
			<cfset service = iterator.next() />
			<cfset qName = service.getQName() />
			<cfset ports = service.getPorts() />

			<cfset portIter = ports.values().iterator() />

			<h5>#qName.getLocalPart()#</h5>

			<cfloop condition="portIter.hasNext()">
				<cfset port = portIter.next() />
				<cfset binding = port.getBinding() />
				<cfset operations = binding.getBindingOperations() />
				
				<cfloop array="#operations#" index="bindingOperation">
					<cfset operation = bindingOperation.getOperation() />
					<cfset input = operation.getInput() />
					<cfset message = input.getMessage() />
					<cfset parts = message.getParts() />

					<cfdump var="#operation#" expand="false" label="" />
					<cfdump var="#input#" expand="false" label="" />
					<cfdump var="#message#" expand="false" label="" />
					<cfdump var="#parts#" expand="false" label="" />

					<cfif !isNull(parts)>
						<cfset partIterator = parts.values().iterator() />
						<cfloop condition="partIterator.hasNext()">
							<cfset part = partIterator.next() />
							Part: #part.getName()#<br />
						</cfloop>
					</cfif>
				</cfloop>
			</cfloop>
		</cfloop>
	</cfif>

	<cfabort />

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