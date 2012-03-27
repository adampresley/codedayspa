<cfset reader = createObject("java", "com.ibm.wsdl.factory.WSDLFactoryImpl").newWSDLReader() />
<!---
<cfset path = "http://adamptss05main.api-wi.com/tss_adampmain/clearConnect/2_0/webservice.cfc?wsdl" />
--->
<cfset path = "http://www.webservicex.net/CurrencyConvertor.asmx?WSDL" />

<cfset def = reader.readWSDL(null, path) />

<cfoutput>

	<cfset services = def.getServices() />

	<cfif !isNull(services)>
		<h3>Services</h3>

		<cfset iterator = services.values().iterator() />
		<cfloop condition="iterator.hasNext()">
			<cfset service = iterator.next() />
			<cfset qName = service.getQName() />
			<cfset ports = service.getPorts() />

			<cfset portIter = ports.values().iterator() />

			<h4>Service: #qName.getLocalPart()#</h4>

			<cfloop condition="portIter.hasNext()">
				<cfset port = portIter.next() />
				<cfset binding = port.getBinding() />
				<cfset operations = binding.getBindingOperations() />
				
				<h5>Port: #port.getName()#</h5>

				<cfloop array="#operations#" index="bindingOperation">
					<cfset operation = bindingOperation.getOperation() />
					<cfset input = operation.getInput() />
					<cfset output = operation.getOutput() />

					<cfset inMessage = input.getMessage() />
					<cfset inParts = inMessage.getOrderedParts(null) />
					<cfset outMessage = output.getMessage() />
					<cfset outParts = outMessage.getOrderedParts(null) />

					<cfset methodSignature = "" />


					<!---
						Return type
					--->
					<cfif !isNull(outParts)>
						<cfset partIterator = outParts.iterator() />
						<cfloop condition="partIterator.hasNext()">
							<cfset part = partIterator.next() />
							<cfset typeName = part.getTypeName() />
							
							<cfset outputType = "" />
							<cfif !isNull(typeName)>
								<cfset outputType = typeName.getLocalPart() />
							<cfelse>
								<cfset outputType = part.getElementName().getLocalPart() />
							</cfif>

							<cfset methodSignature &= outputType />
						</cfloop>
					</cfif>

					<!---
						Method Name
					--->
					<cfset methodSignature &= " #operation.getName()#(" />

					<!---
						Arguments
					--->
					<cfif !isNull(inParts)>
						<cfset partIterator = inParts.iterator() />
						<cfset firstAdd = true />

						<cfloop condition="partIterator.hasNext()">
							<cfset part = partIterator.next() />
							<cfset typeName = part.getTypeName() />

							<cfif !isNull(typeName)>
								<cfset argType = typeName.getLocalPart() />
							<cfelse>
								<cfset argType = part.getElementName().getLocalPart() />
							</cfif>

							<cfif !firstAdd><cfset methodSignature &= ", " /></cfif>
							<cfset methodSignature &= "#argType# #part.getName()#" />

							<cfset firstAdd = false />
						</cfloop>
					</cfif>

					<cfset methodSignature &= ")" />
					#methodSignature#<br />
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