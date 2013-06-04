<cfcomponent extends="mxunit.framework.TestCase" output="false">

	<cffunction name="jsonStringToHtml_ValidJsonInput_ReturnsFormattedHTML" output="false">
		<cfscript>
			var service = _getService();
			var jsonString = serializeJson({
				firstName="Adam",
				lastName="Presley",
				stuff=3
			});

			var expected = "<pre class=""prettyprint lang-js"">{   &quot;firstName&quot;: &quot;Adam&quot;,   &quot;lastName&quot;: &quot;Presley&quot;,   &quot;stuff&quot;: 3}</pre>";
			var actual = replaceNoCase(service.jsonStringToHtml(input=jsonString), "#chr(10)#", "", "ALL");

			assertEquals(expected, actual, "Expected JSON converted to markup");
		</cfscript>
	</cffunction>


	<cffunction name="_getService" access="private" output="false">
		<cfscript>
			return createObject("component", "model.Beautifier.BeautifierService").init();
		</cfscript>
	</cffunction>

</cfcomponent>