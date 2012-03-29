<cfcomponent extends="Basis.Service" output="false">

	<cffunction name="parseWSDL" access="public" output="false">
		<cfargument name="inputUrl" type="string" required="true" />

		<cfset var result = [] />
		<cfset var resultItem = {} />
		<cfset var portItem = {} />

		<cfset var reader = createObject("java", "com.ibm.wsdl.factory.WSDLFactoryImpl").newWSDLReader() />
		<cfset var definitions = reader.readWSDL(null, arguments.inputUrl) />
		<cfset var services = definitions.getServices() />
		<cfset var serviceIterator = "" />
		<cfset var service = "" />
		<cfset var qName = "" />
		<cfset var ports = [] />
		<cfset var portIterator = "" />
		<cfset var port = "" />


		<cfif !isNull(services)>
			<cfset serviceIterator = services.values().iterator() />

			<cfloop condition="serviceIterator.hasNext()">
				<cfset resultItem = {} />

				<cfset service = serviceIterator.next() />
				<cfset qName = service.getQName() />
				<cfset ports = service.getPorts() />

				<cfset resultItem.name = qName.getLocalPart() />
				<cfset resultItem.ports = [] />

				<cfset portIterator = ports.values().iterator() />
				<cfloop condition="portIterator.hasNext()">
					<cfset port = portIterator.next() />
					<cfset portItem = {
						name = port.getName(),
						operations = __getOperations(port)
					} />
					<cfset arrayAppend(resultItem.ports, portItem) />
				</cfloop>

				<cfset arrayAppend(result, resultItem) />
			</cfloop>
		</cfif>

		<cfreturn result />
	</cffunction>


	<cffunction name="__getOperations" returntype="array" access="private" output="false">
		<cfargument name="port" required="true" />

		<cfset var result = [] />
		<cfset var resultItem = {} />

		<cfset var binding = arguments.port.getBinding() />
		<cfset var bindingOperations = binding.getBindingOperations() />
		<cfset var bindingOperation = "" />
		<cfset var operation = "" />

		<cfloop array="#bindingOperations#" index="bindingOperation">
			<cfset operation = bindingOperation.getOperation() />
			<cfset resultItem = {
				method = __getMethodSignature(operation)
			} />
			<cfset arrayAppend(result, resultItem) />
		</cfloop>

		<cfreturn result />
	</cffunction>


	<cffunction name="__getMethodSignature" returntype="struct" access="private" output="false">
		<cfargument name="operation" required="true" />

		<cfset var result = {
			methodSignature = "",
			returnType = "",
			methodName = "",
			argumentList = ""
		} />
		<cfset var input = arguments.operation.getInput() />
		<cfset var output = arguments.operation.getOutput() />
		
		<cfset var inMessage = input.getMessage() />
		<cfset var outMessage = output.getMessage() />
		<cfset var inParts = inMessage.getOrderedParts(null) />
		<cfset var outParts = outMessage.getOrderedParts(null) />
		<cfset var firstAdd = true />

		<cfset var partIterator = "" />
		<cfset var part = "" />
		<cfset var typeName = "" />
		<cfset var outputType = "" />
		<cfset var argType = "" />

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

				<cfset result.methodSignature &= outputType />
				<cfset result.returnType = outputType />
			</cfloop>
		</cfif>

		<!---
			Method name
		--->
		<cfset result.methodSignature &= " #arguments.operation.getName()#(" />
		<cfset result.methodName = arguments.operation.getName() />

		<!---
			Arguments 
		--->
		<cfif !isNull(inParts)>
			<cfset partIterator = inParts.iterator() />

			<cfloop condition="partIterator.hasNext()">
				<cfset part = partIterator.next() />
				<cfset typeName = part.getTypeName() />

				<cfif !isNull(typeName)>
					<cfset argType = typeName.getLocalPart() />
				<cfelse>
					<cfset argType = part.getElementName().getLocalPart() />
				</cfif>

				<cfif !firstAdd>
					<cfset result.methodSignature &= ", " />
					<cfset result.argumentList &= ", " />
				</cfif>

				<cfset result.methodSignature &= "#argType# #part.getName()#" />
				<cfset result.argumentList &= "#argType# #part.getName()#" />
				<cfset firstAdd = false />
			</cfloop>
		</cfif>

		<cfset result.methodSignature &= ")" />
		<cfreturn result />
	</cffunction>

</cfcomponent>